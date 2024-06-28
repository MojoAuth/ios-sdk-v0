//
//  MojoAuthErrors.h
//  MojoAuthSDK
//
//  Copyright © 2022 MojoAuth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MojoAuthErrorCode.h"
/**
 *  Wrapper class for error objects
 */
@interface MojoAuthErrors : NSObject

#pragma mark - User Registration Service
+ (NSError*)serviceCancelled:(NSString*)action;
+ (NSError*)tokenEmpty;
+ (NSError*)userProfieWithErrorCode:(NSString*)errorCode;
+ (NSError*)userProfileError;
+ (NSError*)nativeFacebookLoginCancelled;
+ (NSError*)nativeFacebookLoginFailedMixedPermissions;
+ (NSError*)nativeFacebookLoginFailed;

#pragma mark - Touch ID
+ (NSError*)touchIDNotAvailable;
+ (NSError*)touchIDNotDeviceOwner;



@end
