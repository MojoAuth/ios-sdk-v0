//
//  NSError+MojoAuthError.m
//
//  Copyright © 2022 MojoAuth. All rights reserved.
//

#import "MojoAuthError.h"

static NSString * _Nonnull const MojoAuthDomain = @"com.mojoauth";

@implementation NSError (MojoAuthError)

+ (NSError *)errorWithCode:(NSInteger)code
			   description:(NSString *)description
			 failureReason:(NSString *)failureReason {
	NSError *err = [NSError errorWithDomain:MojoAuthDomain
									   code:code
								   userInfo:@{
											  NSLocalizedDescriptionKey: description,
											  NSLocalizedFailureReasonErrorKey: failureReason,
											  }];
	return err;
}


@end
