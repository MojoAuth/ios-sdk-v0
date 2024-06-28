//
//  NSString+MojoAuthString.h
//
//  Copyright © 2022 MojoAuth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MojoAuthString)

- (NSString *) URLDecodedString;

- (NSString *) URLEncodedString;

- (NSString *) capitalizedFirst;

@end
