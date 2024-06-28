//
//  SocialLoginManager.m
//
//  Copyright © 2022 MojoAuth. All rights reserved.
//

#import "MojoAuthSocialLoginManager.h"
#import "MojoAuthFacebookLogin.h"
#import <SafariServices/SafariServices.h>
#import "MojoAuthREST.h"
#import "MojoAuth.h"

@interface MojoAuthSocialLoginManager() {}
@property(nonatomic, strong) MojoAuthFacebookLogin * facebookLogin;
@property (assign, readonly, nonatomic) BOOL isSafariLogin;
@property (assign, readonly, nonatomic) BOOL isFacebookNativeLogin;
@end

@implementation MojoAuthSocialLoginManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static MojoAuthSocialLoginManager *instance;

    dispatch_once(&onceToken, ^{
        instance = [[MojoAuthSocialLoginManager alloc] init];
    });

    return instance;
}

-(instancetype)init {
    self = [super init];
    if (self) {
        _facebookLogin = [[MojoAuthFacebookLogin alloc] init];
    }
    return self;
}




- (void)nativeFacebookLoginWithPermissions:(NSDictionary *)params
withSocialAppName:(NSString *)socialAppName
                              inController:(UIViewController *)controller
completionHandler:(MojoAuthAPIResponseHandler)handler {
   // self.handler=handler;
    _isFacebookNativeLogin = YES;
    [self.facebookLogin loginfromViewController:controller parameters:params withSocialAppName:socialAppName handler:handler];
}



- (void)convertGoogleTokenToMojoAuthToken:(NSString *)google_token google_refresh_token:(NSString *)google_refresh_token google_client_id:(NSString *)google_client_id
                       inController:(UIViewController *)controller completionHandler:(MojoAuthAPIResponseHandler)handler {
    NSString *refresh_token = google_refresh_token ? google_refresh_token: @"";
    NSString *client_id = google_client_id ? google_client_id: @"";
    NSMutableDictionary *dictParam = [NSMutableDictionary dictionaryWithDictionary:@{@"api_key": [MojoAuthSDK apiKey],
    @"google_access_token" : google_token,
    @"refresh_token" : refresh_token,
    @"client_id" : client_id
    }];
    
    [[MojoAuthREST apiInstance] sendGET:@"users/social/google"
                               queryParams:dictParam
                         completionHandler:^(NSDictionary *data, NSError *error) {

         handler(data, error);
        
    }];

}






- (void)logout {
    // Only facebook native login stores sessions that we have to clear
    [self.facebookLogin logout];
}

#pragma mark Application delegate methods
- (void)applicationLaunchedWithOptions:(NSDictionary *)launchOptions {
    [self.facebookLogin applicationLaunchedWithOptions:launchOptions];
}




@end
