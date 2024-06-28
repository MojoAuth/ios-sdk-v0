//
//  MojoAuthSDK.h
//
//  Copyright © 2022 MojoAuth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MojoAuthSession.h"

typedef void (^MojoAuthAPIResponseHandler)(NSDictionary * _Nullable data, NSError * _Nullable error);
typedef void (^MojoAuthServiceCompletionHandler)(BOOL success, NSError * _Nullable error);

/**
 *  This class is the entry point for all mojoAuth functionality
 */
@interface MojoAuthSDK : NSObject
@property (strong, readonly, nonatomic) NSString* _Nonnull apiKey;
@property (strong, atomic) MojoAuthSession* _Nonnull session;
@property (readonly, nonatomic) BOOL useKeychain;


#pragma mark - Initilizers

/**
 *  Initilization, this should be the first function that should be called before any other call to MojoAuthSDK.
 */
+ (instancetype _Nonnull )instance;

/**
 *  MojoAuthSDK singleton
 *
 *  @return MojoAuth singleton object
 */
+ (instancetype _Nonnull )sharedInstance;
+ (NSString*_Nonnull)apiKey;
+ (BOOL)useKeychain;

#pragma mark - Application Delegate methods

/** Application Delegate methods
 */

- (void)applicationLaunchedWithOptions:(NSDictionary *_Nullable)launchOptions;

- (BOOL)application:(UIApplication *_Nonnull)application
            openURL:(NSURL *_Nonnull)url
  sourceApplication:(NSString *_Nullable)sourceApplication
         annotation:(id _Nullable )annotation;

- (void)applicationDidBecomeActive:(UIApplication *_Nonnull)application;


#pragma mark - Logout
/**
 *  Log out the user
 */
+ (BOOL) logout;

@end
