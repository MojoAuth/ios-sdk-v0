//
//  AuthenticationAPI.m
//  MojoAuthSDK
//
//  Created by MojoAuth on 02/11/22.
//

#import "AuthenticationAPI.h"

@implementation AuthenticationAPI
+ (instancetype)authInstance{
    static dispatch_once_t onceToken;
    static AuthenticationAPI *instance;
    
    dispatch_once(&onceToken, ^{
        instance = [[AuthenticationAPI alloc] init];
    });
    
    return instance;
}

- (void)sendMagicLinkWithEmail:(NSString *)email
             language:(NSString *)language
              redirect_url:(NSString *)redirect_url
              completionHandler:(MojoAuthAPIResponseHandler)completion {
    NSString *_language = language ? language: @"";
    NSString *_redirect_url = redirect_url ? redirect_url: @"";
    [[MojoAuthREST apiInstance] sendPOST:@"users/magiclink"
                                queryParams:@{
                                              @"apikey": [MojoAuthSDK apiKey],
                                              @"language": _language,
                                              @"redirect_url":_redirect_url
                                              }
                                       body:@{@"email":email}
                          completionHandler:completion];
}
    
- (void)checkAuthenticationStatusWithStateID:(NSString *)state_id
                                    language:(NSString *)language
                                     redirect_url:(NSString *)redirect_url
              completionHandler:(MojoAuthAPIResponseHandler)completion {
    NSString *_language = language ? language: @"";
    NSString *_redirect_url = redirect_url ? redirect_url: @"";
    [[MojoAuthREST apiInstance] sendGET:@"users/status"
                                queryParams:@{
                                              @"apikey": [MojoAuthSDK apiKey],
                                              @"state_id": state_id,
                                              @"language": _language,
                                              @"redirect_url":_redirect_url
                                              }
                          completionHandler:completion];
}

- (void)resendMagicLinkWithStateID:(NSString *)state_id
                         language:(NSString *)language
                         redirect_url:(NSString *)redirect_url
             completionHandler:(MojoAuthAPIResponseHandler)completion {
    NSString *_language = language ? language: @"";
    NSString *_redirect_url = redirect_url ? redirect_url: @"";
    [[MojoAuthREST apiInstance] sendPOST:@"users/magiclink/resend"
                             queryParams:@{
                                           @"apikey": [MojoAuthSDK apiKey],
                                           @"language": _language,
                                           @"redirect_url":_redirect_url
                                           }
                                    body:@{@"state_id":state_id}
                          completionHandler:completion];
}

- (void)sendEmailOTPWithEmail:(NSString *)email
                     language:(NSString *)language
         completionHandler:(MojoAuthAPIResponseHandler)completion {
    NSString *_language = language ? language: @"";
    [[MojoAuthREST apiInstance] sendPOST:@"users/emailotp"
                                queryParams:@{
                                              @"apikey": [MojoAuthSDK apiKey],
                                              @"language": _language
                                              }
                                       body:@{
                                              @"email":email
                                              }
                          completionHandler:completion];
}

- (void)verifyEmailOTPWithStateID:(NSString *)state_id
                              otp:(NSString *)otp
         completionHandler:(MojoAuthAPIResponseHandler)completion {
    
    [[MojoAuthREST apiInstance] sendPOST:@"users/emailotp/verify"
                                queryParams:@{
                                              @"apikey": [MojoAuthSDK apiKey]
                                              }
                                       body:@{
                                              @"otp":otp,
                                              @"state_id":state_id
                                              }
                          completionHandler:completion];
}

- (void)resendEmailOTPWithStateID:(NSString *)state_id
                         language:(NSString *)language
                completionHandler:(MojoAuthAPIResponseHandler)completion {
    NSString *_language = language ? language: @"";
    [[MojoAuthREST apiInstance] sendPOST:@"users/emailotp/resend"
                                queryParams:@{
                                              @"apikey": [MojoAuthSDK apiKey],
                                              @"language": _language
                                              }
                                    body:@{@"state_id":state_id}
     
                          completionHandler:completion];
}

- (void)sendPhoneOTPWithPhone:(NSString *)phone
                     language:(NSString *)language
              completionHandler:(MojoAuthAPIResponseHandler)completion {
    NSString *_language = language ? language: @"";
    [[MojoAuthREST apiInstance] sendPOST:@"users/phone"
                                queryParams:@{
                                              @"apikey": [MojoAuthSDK apiKey],
                                              @"language": _language
                                              }
                                   body:@{@"phone":phone}
                          completionHandler:completion];
}

- (void)verifyPhoneOTPWithStateID:(NSString *)state_id
                         otp:(NSString *)otp
              completionHandler:(MojoAuthAPIResponseHandler)completion {
    
    [[MojoAuthREST apiInstance] sendPOST:@"users/phone/verify"
                               queryParams:@{
                                             @"apikey": [MojoAuthSDK apiKey]
                                             }
                                   body:@{@"state_id":state_id,
                                          @"otp":otp
                                        }
                         completionHandler:completion];
}

- (void)resendPhoneOTPWithStateID:(NSString *)state_id
                         language:(NSString *)language
              completionHandler:(MojoAuthAPIResponseHandler)completion {
    NSString *_language = language ? language: @"";
    [[MojoAuthREST apiInstance] sendPOST:@"users/phone/resend"
                               queryParams:@{
                                             @"apikey": [MojoAuthSDK apiKey],
                                             @"language": _language
                                             }
                                   body:@{@"state_id":state_id}
                         completionHandler:completion];
}

- (void)JWKS:(MojoAuthAPIResponseHandler)completion {
    
    [[MojoAuthREST apiInstance] sendGET:@"token/jwks"
                               queryParams:@{
                                             @"apikey": [MojoAuthSDK apiKey]
                                             }
                         completionHandler:completion];
}

- (void)validateToken:(NSString *)token
             completionHandler:(MojoAuthAPIResponseHandler)completion {
    
    [[MojoAuthREST apiInstance] sendPOST:@"token/verify"
                               queryParams:@{
                                             @"apikey": [MojoAuthSDK apiKey],
                                             @"token":token
                                             }
                                    body:@{}
                         completionHandler:completion];
}

- (void)refreshAccessTokenWithRefreshToken:(NSString *)refresh_token
                         completionHandler:(MojoAuthAPIResponseHandler)completion {
    
    [[MojoAuthREST apiInstance] sendPOST:@"token/refresh"
                               queryParams:@{
                                             @"apikey": [MojoAuthSDK apiKey]
                                             }
                                   body:@{@"refresh_token":refresh_token}
                         completionHandler:completion];
}

@end
