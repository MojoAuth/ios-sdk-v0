//
//  MojoAuthFacebookLogin.m
//
//  Copyright © 2022 MojoAuth. All rights reserved.
//

#import "MojoAuthFacebookLogin.h"
#import "MojoAuthREST.h"
#import "MojoAuthErrors.h"
#import "MojoAuth.h"

@interface MojoAuthFacebookLogin ()
@property(nonatomic, copy) MojoAuthAPIResponseHandler handler;
@property BOOL EmailVerified;
@property BOOL PhoneIdVerified;
@end

@implementation MojoAuthFacebookLogin

- (void)loginfromViewController:(UIViewController*)controller
                     parameters:(NSDictionary*)params
              withSocialAppName:(NSString *)socialAppName
                        handler:(MojoAuthAPIResponseHandler)handler {
    
    BOOL permissionsAllowed = YES;
    NSArray *permissions;
    self.handler = handler;
    
    
    if (params[@"facebookPermissions"]) {
        permissions = params[@"facebookPermissions"];
    } else {
        // permissions not set using basic permissions;
        permissions = @[@"public_profile",@"email"];
    }
    
    FBSDKAccessToken *token = [FBSDKAccessToken currentAccessToken];
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    
    void (^handleLogin)(FBSDKLoginManagerLoginResult *result, NSError *error) = ^void(FBSDKLoginManagerLoginResult *result, NSError *error) {
        [self onLoginResult:result error:error  withSocialAppName:socialAppName controller:controller];
    };
    
    if (token) {
        // remove permissions that the user already has
        permissions = [permissions filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
            return ![token.permissions containsObject:evaluatedObject];
        }]];
        
        BOOL publishPermissionFound = NO;
        BOOL readPermissionFound = NO;
        for (NSString *p in permissions) {
            if ([self isPublishPermission:p]) {
                publishPermissionFound = YES;
            } else {
                readPermissionFound = YES;
            }
        }
        
        if ([permissions count] == 0) {
            if ([[[MojoAuthSDK sharedInstance] session] isLoggedIn]){
                [self finishLogin:[[[MojoAuthSDK sharedInstance] session] userProfile] withError:nil];
            }else{
                [self convertFacebookTokenToMojoAuthToken:[token tokenString] inController:controller];
            }
        } else if (publishPermissionFound && readPermissionFound) {
            // Mix of permissions, not allowed
            permissionsAllowed = NO;
            [self finishLogin:nil withError:[MojoAuthErrors nativeFacebookLoginFailedMixedPermissions]];
        } else if (publishPermissionFound) {
            // Only publish permissions
            [login logInWithPermissions:permissions fromViewController:controller handler:handleLogin];
        } else {
            // Only read permissions
            [login logInWithPermissions:permissions fromViewController:controller handler:handleLogin];
        }
    } else {
        // Initial log in, can only ask for read type permissions
        if ([self areAllPermissionsReadPermissions:permissions]) {
            [login logInWithPermissions:permissions fromViewController:controller handler:handleLogin];
        } else {
            permissionsAllowed = NO;
            [self finishLogin:nil withError:[MojoAuthErrors nativeFacebookLoginFailed]];
        }
    }
}

- (void) onLoginResult:(FBSDKLoginManagerLoginResult *) result
                 error:(NSError *)error
     withSocialAppName:(NSString *)socialAppName
            controller:(UIViewController *) controller{
    if (error) {
        [self finishLogin:nil withError:error];
    } else if (result.isCancelled) {
        [self finishLogin:nil withError:[MojoAuthErrors nativeFacebookLoginCancelled]];
    } else {
        // all other cases are handled by the access token notification
        NSString *accessToken = [[FBSDKAccessToken currentAccessToken] tokenString];
        // Get MojoAuth access_token for facebook access_token
        
        [self convertFacebookTokenToMojoAuthToken:accessToken  inController:controller];
        
    }
}
- (void)convertFacebookTokenToMojoAuthToken :(NSString*)fb_token
                          inController:(UIViewController *)controller {
    NSMutableDictionary *dictParam = [NSMutableDictionary dictionaryWithDictionary:@{@"api_key": [MojoAuthSDK apiKey], @"fb_access_token" : fb_token}];
     
       
   
    [[MojoAuthREST apiInstance] sendGET:@"api/v2/access_token/facebook" queryParams:dictParam completionHandler:^(NSDictionary *data, NSError *error) {
        self.handler(data, error);
    }];
}

- (void) logout {
    if ([FBSDKAccessToken currentAccessToken]) {
        FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
        [login logOut];
    }
}

- (BOOL) isPublishPermission:(NSString*)permission {
    return [permission hasPrefix:@"ads_management"] ||
    [permission hasPrefix:@"manage_notifications"] ||
    [permission isEqualToString:@"publish_actions"] ||
    [permission isEqualToString:@"manage_pages"] ||
    [permission isEqualToString:@"rsvp_event"];
}

- (BOOL) areAllPermissionsReadPermissions:(NSArray*)permissions {
    for (NSString *permission in permissions) {
        if ([self isPublishPermission:permission]) {
            return NO;
        }
    }
    return YES;
}

- (void)finishLogin:(NSDictionary *)data withError:(NSError*)error {
    if (self.handler) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.handler(data, error);
        });
    }
}

- (void)applicationLaunchedWithOptions:(NSDictionary *)launchOptions {
    [(FBSDKApplicationDelegate *)[FBSDKApplicationDelegate sharedInstance] application:[UIApplication sharedApplication] didFinishLaunchingWithOptions:launchOptions];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    @try {
        BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
                                                                      openURL:url
                                                            sourceApplication:sourceApplication
                                                                   annotation:annotation];
        return handled;
    } @catch (NSException *exception) {
        NSLog(@"{facebook} Exception while processing openurl event: %@", exception);
    }
    
}

@end

