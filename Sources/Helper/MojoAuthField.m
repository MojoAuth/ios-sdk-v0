//
//  MojoAuthField.m
//  Pods
//
//  Created by MojoAuth on 02/11/2022.
//
//

#import <Foundation/Foundation.h>
#import "MojoAuthField.h"

NSString *const kProviderEndpoint = @"Endpoint";
NSString *const kProviderName = @"Name";
@implementation MojoAuthField

- (instancetype)init:(NSDictionary*)dictionary
{
    self = [super init];
    if (self) {
        _type = [self setTypeWithString:[dictionary objectForKey:@"type"]];
        _option = (_type == OPTION) ? [self initializeOptions:[dictionary objectForKey:@"options"]] : nil;
        _name = [dictionary objectForKey:@"name"];
        _display = [dictionary objectForKey:@"display"];
        _permission = [((NSString *)[dictionary objectForKey:@"permission"]) isEqualToString:@"w"]? WRITE : READ;
        _rules = ([dictionary objectForKey:@"rules"]) ? [self initializeRules:[dictionary objectForKey:@"rules"]] : nil;
        }
    
    return self;
}

-(instancetype)initWithSocialSchema:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kProviderEndpoint] isKindOfClass:[NSNull class]]){
        self.endpoint = dictionary[kProviderEndpoint];
    }
    if(![dictionary[kProviderName] isKindOfClass:[NSNull class]]){
        self.providerName = dictionary[kProviderName];
    }
    return self;
}

+ (NSArray<NSString *> *_Nonnull) addressFields {
    return @[@"address1",@"address2",@"city",@"country",@"postalcode",@"region",@"state"];
}


- (MojoAuthFieldType) setTypeWithString:(NSString*)fieldString
{
    MojoAuthFieldType fieldType = HIDDEN;
    if ([fieldString isEqualToString:@"string"]) {
        fieldType = STRING;
    } else if ([fieldString isEqualToString:@"option"]) {
        fieldType = OPTION;
    } else if ([fieldString isEqualToString:@"multi"]) {
        fieldType = MULTI;
    } else if ([fieldString isEqualToString:@"password"]) {
        fieldType = PASSWORD;
    } else if ([fieldString isEqualToString:@"hidden"]) {
        fieldType = HIDDEN;
    } else if ([fieldString isEqualToString:@"email"]) {
        fieldType = EMAILID;
    } else if ([fieldString isEqualToString:@"text"]) {
        fieldType = TEXT;
    }
    return fieldType;
}

- (NSDictionary*) initializeOptions:(NSArray*) options
{
    NSMutableDictionary *newOptions = [[NSMutableDictionary alloc] init];
    
    for(NSDictionary *option in options)
    {
        [newOptions setObject:option[@"text"] forKey:option[@"value"]];
    }

    return [newOptions copy];
}

-(NSArray<MojoAuthFieldRule *> *)initializeRules: (NSString*) fullRuleStr
{
    //if nil or empty string
    if (!fullRuleStr || [fullRuleStr length] <= 0)
    {
        return nil;
    }

    NSMutableArray<MojoAuthFieldRule *> *rules = [[NSMutableArray<MojoAuthFieldRule *> alloc] init];
    
    //this is to avoid custom validation regex that containts "|"
    NSString *customValidation = nil;
    if ([fullRuleStr containsString:@"custom_validation"])
    {

        NSRange start = [fullRuleStr rangeOfString:@"custom_validation["];
        NSUInteger startIndex = start.location+start.length;
        int openSquares = 0;
        //iteratate through the content of custom_validation[.... until it founds the ] pair
        while (openSquares >= 0 || startIndex > [fullRuleStr length] )
        {
            if ([[fullRuleStr substringWithRange:NSMakeRange(startIndex,1)] isEqualToString:@"["])
            {
                openSquares++;
            }else if([[fullRuleStr substringWithRange:NSMakeRange(startIndex,1)] isEqualToString:@"]"])
            {
                openSquares--;
            }
        
            startIndex++;
        }
        
        NSAssert((openSquares==-1), @"Invalid Custom Regex");
        
        //save "custom_validation[...]"
        customValidation = [fullRuleStr substringWithRange:NSMakeRange(start.location,startIndex-start.location)];
        //delete it from the fullRuleStr with empty string
        fullRuleStr = [fullRuleStr stringByReplacingCharactersInRange:NSMakeRange(start.location,startIndex-start.location) withString:@""];
    }
    
    NSMutableArray<NSString *> *rulesStr = [[fullRuleStr componentsSeparatedByString:@"|"] mutableCopy];
    
    if (customValidation)
    {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"length > 0"];
        rulesStr = [[rulesStr filteredArrayUsingPredicate:predicate] mutableCopy]; //delete any element with empty array
        [rulesStr addObject:customValidation]; //add custom_validation[...] into rules array
    }
    
    for (NSString *ruleStr in rulesStr)
    {
        MojoAuthFieldRule *newRule = [[MojoAuthFieldRule alloc] init:ruleStr];
        if ([newRule type] == valid_date)
        {
            _type = DATE;
        }
        [rules addObject:[[MojoAuthFieldRule alloc] init:ruleStr]];
    }
    
    return [rules copy];
}

-(NSString *)description
{
    NSString *MojoAuthfieldstr = [NSString stringWithFormat:@"<MojoAuthField, type: %@, name: %@, display: %@, required:%@",MojoAuthFieldType([self type]), [self name], [self display], self.isRequired ? @"YES":@"NO"];
    
    if ([self option])
    {
        MojoAuthfieldstr = [MojoAuthfieldstr stringByAppendingString:[NSString stringWithFormat:@", option:%@",[self option]]];
    }
    
    MojoAuthfieldstr = [MojoAuthfieldstr stringByAppendingString:@">"];

    return MojoAuthfieldstr;
}

-(BOOL) getIsRequired
{
    BOOL req = NO;
    
    for (MojoAuthFieldRule *rule in _rules)
    {
        if ([rule type] == required)
        {
            req = YES;
            break;
        }
    }
    
    return req;
}

-(NSString*) typeToString
{
    return MojoAuthFieldType([self type]);
}

@end
