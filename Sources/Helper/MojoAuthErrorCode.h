//
//  MojoAuthErrorCode.h
//
//  Copyright © 2022 MojoAuth. All rights reserved.
//

#ifndef MojoAuthErrorCode_h
#define MojoAuthErrorCode_h

/**
 *  Registration Service, Social Login and API Response error code's.
 */
typedef NS_ENUM(NSInteger, MojoAuthErrorCode) {
    /*
     *  Native facebook login cancelled
     */
    MojoAuthErrorCodeNativeFacebookLoginCancelled,
    
    /**
     *  Native facebook login failed
     */
    MojoAuthErrorCodeNativeFacebookLoginFailed,

    
    
    /**
     *  Access Token Invalid
     */
    MojoAuthErrorCodeAccessTokenInvalid,
    
    /**
     *  Access Token Empty
     */
    MojoAuthErrorCodeAccessTokenEmpty,
    
    /**
     *  user profile blocked,
     */
    MojoAuthErrorCodeUserProfileBlocked,
    /**
     *  user profile error
     */
    MojoAuthErrorCodeUserProfileError,
    /**
     *  TouchID error
     */
    MojoAuthErrorCodeTouchIDNotAvailable,
    /**
     *  User is not verified
     */
    MojoAuthErrorCodeUserIsNotVerified,
    
    /**
     *  User profile have Required Fields as null
     */
    MojoAuthErrorCodeUserRequireAdditionalFieldsError

};

#endif /* MojoAuthErrorCode_h */
