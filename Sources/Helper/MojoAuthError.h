//
//  NSError+MojoAuthError.h
//
//  Copyright © 2022 MojoAuth All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (MojoAuthError)

+ (NSError *)errorWithCode:(NSInteger)code description:(NSString *)description failureReason:(NSString *)failureReason;

@end
