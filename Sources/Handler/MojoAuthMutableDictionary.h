//
//  MojoAuthMutableDictionary
//
//  Copyright © 2022 MojoAuth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (MojoAuthMutableDictionary)

- (NSMutableDictionary *) replaceNullWithBlank;

@end
