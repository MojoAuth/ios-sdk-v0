//
//  MojoAuthSession.h
//  MojoAuthSDK
//
//  Copyright © 2022 MojoAuth. All rights reserved.
//
//

#import <Foundation/Foundation.h>

@interface MojoAuthSession : NSObject

@property (nonatomic, getter=accessToken, nullable) NSString *accessToken;
@property (nonatomic, getter=userProfile, nullable) NSDictionary *userProfile;
@property (nonatomic, getter=isLoggedIn) BOOL isLoggedIn;


#pragma mark - Initilizers

+ (instancetype _Nonnull )instance;
+ (instancetype _Nonnull )sharedInstance;

- (instancetype _Nonnull )initWithAccessToken:(NSString *_Nonnull)token userProfile:(NSDictionary*_Nonnull)userProfile;

/**
 *  Log out the user from session
 */
- (BOOL) logout;

@end
