//
//  AuthenticationAPI.h
//  MojoAuthSDK
//
//  Created by MojoAuth on 02/11/22.
//

#import <Foundation/Foundation.h>
#import "MojoAuth.h"
#import "MojoAuthDictionary.h"

@interface AuthenticationAPI : NSObject
+ (instancetype)authInstance;

- (void)sendMagicLinkWithEmail:(NSString *)email
                      language:(NSString *)language
                  redirect_url:(NSString *)redirect_url
              completionHandler:(MojoAuthAPIResponseHandler)completion;

- (void)checkAuthenticationStatusWithStateID:(NSString *)state_id
                                    language:(NSString *)language
                                     redirect_url:(NSString *)redirect_url
   completionHandler:(MojoAuthAPIResponseHandler)completion;

- (void)resendMagicLinkWithStateID:(NSString *)state_id
                          language:(NSString *)language
                          redirect_url:(NSString *)redirect_url
             completionHandler:(MojoAuthAPIResponseHandler)completion;

- (void)sendEmailOTPWithEmail:(NSString *)email
                     language:(NSString *)language
         completionHandler:(MojoAuthAPIResponseHandler)completion;

- (void)verifyEmailOTPWithStateID:(NSString *)state_id
                              otp:(NSString *)otp
         completionHandler:(MojoAuthAPIResponseHandler)completion;

- (void)resendEmailOTPWithStateID:(NSString *)state_id
                         language:(NSString *)language
         completionHandler:(MojoAuthAPIResponseHandler)completion;

- (void)sendPhoneOTPWithPhone:(NSString *)phone
                     language:(NSString *)language
                completionHandler:(MojoAuthAPIResponseHandler)completion;

- (void)verifyPhoneOTPWithStateID:(NSString *)state_id
                              otp:(NSString *)otp
              completionHandler:(MojoAuthAPIResponseHandler)completion;

- (void)resendPhoneOTPWithStateID:(NSString *)state_id
                         language:(NSString *)language
                 completionHandler:(MojoAuthAPIResponseHandler)completion;

- (void)JWKS:(MojoAuthAPIResponseHandler)completion;

- (void)validateToken:(NSString *)token
             completionHandler:(MojoAuthAPIResponseHandler)completion;

- (void)refreshAccessTokenWithRefreshToken:(NSString *)refresh_token
                         completionHandler:(MojoAuthAPIResponseHandler)completion;


@end

