
//
//  MojoAuth.m
//  MojoAuthSDK
//
//  Copyright © 2022 MojoAuth Inc. All rights reserved.
//
//

#import "MojoAuthSession.h"
#import "MojoAuthMutableDictionary.h"
#import "MojoAuthSDK.h"
#import "MojoAuth.h"
#import "MojoAuthKeychainWrapper.h"

@interface MojoAuthSession() {
    MojoAuthKeychainWrapper *keychainItem;
}
@end

@implementation MojoAuthSession


+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static MojoAuthSession *instance;
    dispatch_once(&onceToken, ^{
        instance = [MojoAuthSession instance];
    });
    
    return instance;
}

+ (instancetype)instance {
    return [[MojoAuthSession alloc] init];
}
- (nullable NSString*) accessToken {
    
    NSString *token = nil;
    
    if([[MojoAuthSDK sharedInstance] useKeychain])
    {
        //retrive keychain
        //KeychainAccessVersionNumber
        NSString *appIdentifierPrefix = [self bundleSeedID];
        NSString *groupKey = [NSString stringWithFormat:@"%@.%@",appIdentifierPrefix,[MojoAuthSDK  apiKey]];
        keychainItem = [[MojoAuthKeychainWrapper alloc] initWithIdentifier:[MojoAuthSDK apiKey] accessGroup:groupKey];
        token = [[NSString alloc] initWithData:[keychainItem dataForKey:@"MojoAuthAccessToken" promptMessage:@""] encoding:NSUTF8StringEncoding];
    }else
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        token = [defaults valueForKey:@"MojoAuthAccessToken"];
        
    }
    if(!token.length)
        return nil;
    return token;
}

- (nullable NSDictionary*) userProfile {
    NSDictionary *profile = nil;
    
    if([[MojoAuthSDK sharedInstance] useKeychain])
    {
        //retrive keychain
        NSString *appIdentifierPrefix = [self bundleSeedID];
        NSString *groupKey = [NSString stringWithFormat:@"%@.%@",appIdentifierPrefix,[MojoAuthSDK  apiKey]];
        keychainItem = [[MojoAuthKeychainWrapper alloc] initWithIdentifier:[MojoAuthSDK apiKey] accessGroup:groupKey];
        
        NSData *profileData = [keychainItem dataForKey:@"MojoAuthUserProfile" promptMessage:@""];
        NSDictionary *profileDict = [NSKeyedUnarchiver unarchiveObjectWithData:profileData] ;
        profile = profileDict;
    }else
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        profile = [defaults valueForKey:@"MojoAuthUserProfile"];
    }
    
    return profile;
}
- (instancetype)initWithAccessToken:(NSString*_Nonnull)token userProfile:(NSDictionary*_Nonnull)userProfile{
    
    self = [super init];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    long MojoAuthUserBlocked = [[userProfile objectForKey:@"IsDeleted"] integerValue];
    if([[MojoAuthSDK sharedInstance] useKeychain])
    {
        //save to keychain
        NSString *appIdentifierPrefix = [self bundleSeedID];
        NSString *groupKey = [NSString stringWithFormat:@"%@.%@",appIdentifierPrefix,[MojoAuthSDK  apiKey]];
        keychainItem = [[MojoAuthKeychainWrapper alloc] initWithIdentifier:[MojoAuthSDK apiKey] accessGroup:groupKey];
        [keychainItem setData:[token dataUsingEncoding:NSUTF8StringEncoding] forKey:@"MojoAuthAccessToken" promptMessage:@""];
        
        BOOL yes = YES;
        BOOL no = NO;
        
        if(MojoAuthUserBlocked == 0) {
            self.isLoggedIn = YES;
        }
        NSMutableDictionary* profile;
        if (![userProfile objectForKey:@"errorCode"]) {
            profile = [[userProfile mutableCopy] replaceNullWithBlank];
            NSData *profileData = [NSKeyedArchiver archivedDataWithRootObject:profile];
            [keychainItem setData:profileData forKey:@"MojoAuthUserProfile" promptMessage:@""];
        }
    }else
    {
        //save to user defaults
        [defaults setObject:token forKey:@"MojoAuthAccessToken"];
        //User is not blocked
        if(MojoAuthUserBlocked == 0) {
            [defaults setInteger:true forKey:@"isLoggedIn"];
            [defaults setInteger:false forKey:@"MojoAuthUserBlocked"];
        } else {
            [defaults setInteger:true forKey:@"MojoAuthUserBlocked"];
        }
        
        NSMutableDictionary* profile;
        if (![userProfile objectForKey:@"errorCode"]) {
            profile = [[userProfile mutableCopy] replaceNullWithBlank];
            [defaults setObject:profile forKey:@"MojoAuthUserProfile"];
        }
        [defaults synchronize];
    }
    return self;
}

- (BOOL) logout
{
    //if its already logged out then don't do anything
    //and if user specify don't invalidate the access token
    
    if(![self isLoggedIn])
    {
        return NO;
    }
    
    if([[MojoAuthSDK sharedInstance] useKeychain])
    {
        NSString *appIdentifierPrefix = [self bundleSeedID];
        
        NSString *groupKey = [NSString stringWithFormat:@"%@.%@",appIdentifierPrefix,[MojoAuthSDK apiKey]];
        
        keychainItem = [[MojoAuthKeychainWrapper alloc] initWithIdentifier:[MojoAuthSDK apiKey] accessGroup:groupKey];
        
        [keychainItem clearAll];
        
    }else
    {
        NSUserDefaults *MojoAuthUserDefault = [NSUserDefaults standardUserDefaults];
        [MojoAuthUserDefault removeObjectForKey:@"isLoggedIn"];
        [MojoAuthUserDefault removeObjectForKey:@"MojoAuthAccessToken"];
        [MojoAuthUserDefault removeObjectForKey:@"MojoAuthUserBlocked"];
        [MojoAuthUserDefault removeObjectForKey:@"MojoAuthUserProfile"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    return YES;
}

- (BOOL) isLoggedIn
{
    return [self accessToken] && [self userProfile];
    
}
- (NSString *)bundleSeedID {
    NSDictionary *query = [NSDictionary dictionaryWithObjectsAndKeys:
                           (__bridge NSString *)kSecClassGenericPassword, (__bridge NSString *)kSecClass,
                           @"bundleSeedID", kSecAttrAccount,
                           @"", kSecAttrService,
                           (id)kCFBooleanTrue, kSecReturnAttributes,
                           nil];
    CFDictionaryRef result = nil;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, (CFTypeRef *)&result);
    if (status == errSecItemNotFound)
        status = SecItemAdd((__bridge CFDictionaryRef)query, (CFTypeRef *)&result);
    if (status != errSecSuccess)
        return nil;
    NSString *accessGroup = [(__bridge NSDictionary *)result objectForKey:(__bridge NSString *)kSecAttrAccessGroup];
    NSArray *components = [accessGroup componentsSeparatedByString:@"."];
    NSString *bundleSeedID = [[components objectEnumerator] nextObject];
    CFRelease(result);
    return bundleSeedID;
}

@end
