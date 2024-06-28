//
//  MojoAuthField.h
//
//  Copyright © 2022 MojoAuth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MojoAuthFieldRule.h"

typedef NS_ENUM(NSUInteger, MojoAuthFieldType) {
    STRING, //this is single row text
    OPTION, //this is for html select, need to check field's option for full possible option values
    MULTI, //this is 'checkbox' in dashboard for checkbox
    PASSWORD,
    HIDDEN,
    EMAILID,
    TEXT, //this is text area, meaning multi-line text area
    DATE //this field type only exist in iOS, core field type is a string.
};
#define MojoAuthFieldType(enum) [@[@"string",@"option",@"multi",@"password",@"hidden",@"email",@"text",@"date"] objectAtIndex:enum]


typedef NS_ENUM(NSUInteger, MojoAuthFieldPermission) {
    READ,
    WRITE
};

@interface MojoAuthField : NSObject
    @property (nonatomic) MojoAuthFieldType type;
    @property (strong, nonatomic) NSString * _Nonnull name; // unique field name
    @property (strong, nonatomic) NSString * _Nonnull display; // display name
    @property (strong, nonatomic, nullable) NSDictionary<NSString *, NSString *> *option;
    @property (nonatomic) MojoAuthFieldPermission permission;
    @property (strong, nonatomic, nullable) NSArray<MojoAuthFieldRule *> *rules;
    @property (nonatomic, getter=getIsRequired) BOOL isRequired; //will loop through rules for a 'required' rule
    @property (nonatomic, strong) NSString *_Nullable endpoint;
    @property (nonatomic, strong) NSString *_Nullable providerName;

    -(instancetype)initWithSocialSchema:(NSDictionary *)dictionary;
    - (instancetype _Nonnull )init:(NSDictionary*_Nonnull)dictionary;
    - (NSString* _Nonnull)typeToString;
    + (NSArray<NSString *> *_Nonnull) addressFields;
@end
