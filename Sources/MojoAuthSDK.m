//
//  MojoAuthSDK.m
//
//  Copyright © 2022 MojoAuth All rights reserved.
//

#import "MojoAuthSDK.h"
#import "MojoAuthSocialLoginManager.h"
#import "MojoAuthSession.h"

static NSString * const MojoAuthPlistFileName = @"MojoAuth";
static NSString * const MojoAuthAPIKey = @"apiKey";
static NSString * const MojoAuthKeychain = @"useKeychain";


@interface MojoAuthSDK ()
@property (strong, nonatomic) MojoAuthSocialLoginManager *socialLoginManager;
@end

@implementation MojoAuthSDK

- (instancetype)init {
    NSString *path = [[NSBundle mainBundle] pathForResource:MojoAuthPlistFileName ofType:@"plist"];
    NSDictionary* values = [NSDictionary dictionaryWithContentsOfFile:path];
    NSString *apiKey = values[MojoAuthAPIKey];
    
    BOOL useKeychain = values[MojoAuthKeychain] ? [values[MojoAuthKeychain] boolValue] : NO; // if nil set to false
   
    
    if([apiKey isEqualToString:@"<Your MojoAuth ApiKey>"] || [apiKey isEqualToString:@""]){
        NSString *str = nil;
        NSAssert(str, @"apiKey cannot be null in MojoAuth.plist");
    }
    
    NSAssert(apiKey, @"apiKey cannot be null in MojoAuth.plist");
   
   
    
    self = [super init];
    
    if (self) {
        _apiKey = apiKey;
        _useKeychain = useKeychain;
        _session = [[MojoAuthSession alloc] init];
        _socialLoginManager = [[MojoAuthSocialLoginManager alloc] init];
    }
    
    return self;
}

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static MojoAuthSDK *instance;
    dispatch_once(&onceToken, ^{
        instance = [MojoAuthSDK instance];
    });
    
    return instance;
}

+ (instancetype)instance {
    
    return [[MojoAuthSDK alloc] init];
}

+ (BOOL) logout {
    
    BOOL is = [(MojoAuthSession *)[[self sharedInstance] session] logout];
    [[MojoAuthSocialLoginManager sharedInstance] logout];
    // Clearing all stored tokens userprofiles for MojoAuth
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
    return is;
}

+ (NSString*) apiKey {
    return [MojoAuthSDK sharedInstance].apiKey;
}

+ (BOOL) useKeychain {
    return [MojoAuthSDK sharedInstance].useKeychain;
}



#pragma mark Application Delegate methods

- (void)applicationLaunchedWithOptions:(NSDictionary *)launchOptions {
    [self.socialLoginManager applicationLaunchedWithOptions:launchOptions];
    
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    return [[MojoAuthSocialLoginManager sharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

@end
