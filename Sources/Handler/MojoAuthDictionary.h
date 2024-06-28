//
//  MojoAuthDictionary
//
//  Copyright © 2022 MojoAuth. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface NSDictionary (MojoAuthDictionary)

- (NSString *)queryString;

+ (NSDictionary *)dictionaryWithQueryString: (NSString *)queryString;

- (NSDictionary *) dictionaryWithLowercaseKeys;

@end
