//
//  MojoAuthREST.h
//
//  Copyright © 2022 MojoAuth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MojoAuthSDK.h"

/**
 *  REST client
 */
@interface MojoAuthREST : NSObject

#pragma mark - Init

/**
 *  shared singleton
 *
 *  @return singleton instance of REST client
 */
+ (instancetype) apiInstance;

#pragma mark - Methods

- (void)sendGET:(NSString *)url queryParams:(id)queryParams completionHandler:(MojoAuthAPIResponseHandler)completion;
- (void)sendPOST:(NSString *)url queryParams:(id)queryParams body:(id)body completionHandler:(MojoAuthAPIResponseHandler)completion;
- (void)sendPUT:(NSString *)url queryParams:(id)queryParams body:(id)body completionHandler:(MojoAuthAPIResponseHandler)completion;
- (void)sendDELETE:(NSString *)url queryParams:(id)queryParams body:(id)body completionHandler:(MojoAuthAPIResponseHandler)completion;

@end
