//
//  MojoAuthErrors.m
//  MojoAuthSDK
//
//  Copyright © 2022 MojoAuth. All rights reserved.
//

#import "MojoAuthErrors.h"
#import "MojoAuthError.h"

@implementation MojoAuthErrors


+ (NSError*)tokenEmpty {
	return [NSError errorWithCode:MojoAuthErrorCodeAccessTokenEmpty
					  description:@"User profile fetching failed"
					failureReason:@"Access token is empty or null"];
}

+ (NSError*)userProfieWithErrorCode:(NSString*)errorCode {
	return [NSError errorWithCode:MojoAuthErrorCodeUserProfileError
					  description:@"User profile error"
					failureReason:[NSString stringWithFormat:@"User profile error with error code %@", errorCode]];
}

+ (NSError*)userProfileError {
	return [NSError errorWithCode:MojoAuthErrorCodeUserProfileError
			   description:@"User profile error"
			 failureReason:@"User profile is either bloked or returned with an errorCode"];
}



+ (NSError*)nativeFacebookLoginCancelled {
	return [NSError errorWithCode:MojoAuthErrorCodeNativeFacebookLoginCancelled
					  description:@"Facebook Login cancelled"
					failureReason:@"Faceook native login is cancelled"];

}

+ (NSError*)nativeFacebookLoginFailed {
	return [NSError errorWithCode:MojoAuthErrorCodeNativeFacebookLoginFailed
					  description:@"Facebook login failed"
					failureReason:@"Your app should only ask for read permissions for first time login"];
}

+ (NSError*)nativeFacebookLoginFailedMixedPermissions {
	return [NSError errorWithCode:MojoAuthErrorCodeNativeFacebookLoginFailed
					  description:@"Facebook login failed"
					failureReason:@"Your app can't ask for both read and write permissions"];
}

+ (NSError*)touchIDNotAvailable {
    return [NSError errorWithCode:MojoAuthErrorCodeTouchIDNotAvailable
                      description:@"Touch ID authentication failed"
                    failureReason:@"The User's device cannot be authenticated using TouchID"];
}

+ (NSError*)touchIDNotDeviceOwner {
    return [NSError errorWithCode:MojoAuthErrorCodeTouchIDNotAvailable
                      description:@"Touch ID authentication failed"
                    failureReason:@"TouchID Authentiction failed since the user is not the device's owner"];
}

@end
