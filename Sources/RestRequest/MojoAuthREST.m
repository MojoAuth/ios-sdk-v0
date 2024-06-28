//
//  MojoAuthREST.m
//
//  Copyright © 2022 MojoAuth. All rights reserved.
//

#import "MojoAuthREST.h"
#import "MojoAuthDictionary.h"
#import "MojoAuthError.h"

static NSString * const errorCode = @"errorcode";
static NSString * const isProviderError = @"isprovidererror";
static NSString * const description = @"description";
static NSString * const providerErrorResponse = @"providererrorresponse";
static NSString * const message = @"message";

NSString *const API_BASE_URL = @"https://api.mojoauth.com/";



@interface MojoAuthREST()
@property(nonatomic, copy) NSURL* baseURL;
@end

@implementation MojoAuthREST

+ (instancetype) apiInstance {
	static dispatch_once_t onceToken;
	static MojoAuthREST *_instance;
	dispatch_once(&onceToken, ^{
		_instance = [[MojoAuthREST alloc]init];
    });
	return _instance;
}


- (instancetype) init {
    self = [super init];
    if (self) {
        _baseURL = [NSURL URLWithString:API_BASE_URL];
    }
    return self;
}

- (void)sendGET:(NSString *)url queryParams:(id)queryParams completionHandler:(MojoAuthAPIResponseHandler)completion {
    
    NSString *access_token;
    NSMutableDictionary* queryParameters = [queryParams mutableCopy];
    
    if (queryParameters[@"token"]) {
        access_token = queryParameters[@"token"];
        [queryParameters removeObjectForKey:@"token"];
    }
    
    
    NSURL *requestUrl;
    
    if (queryParameters.count > 0){
        requestUrl = [NSURL URLWithString:[_baseURL.absoluteString stringByAppendingString:queryParameters ? [url stringByAppendingString:[queryParameters queryString]]: url]];
    }else{
        
        requestUrl = [NSURL URLWithString:[_baseURL.absoluteString stringByAppendingString : url]];
        
    }
    
//    NSURL *requestUrl = [NSURL URLWithString:[_baseURL.absoluteString stringByAppendingString:queryParameters ? [url stringByAppendingString:[queryParameters queryString]]: url]];
    
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:requestUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    
    [request setHTTPMethod:@"GET"];//use GET
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    if (access_token !=nil) {
        NSString *token = [NSString stringWithFormat: @"Bearer %@", access_token];
        [request addValue:token forHTTPHeaderField:@"Authorization"];
    }
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        
        if([httpResponse statusCode] == 200){
            
            NSError *jsonError = nil;
            id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
            
            if ([jsonObject isKindOfClass:[NSArray class]]) {
                NSArray *jsonArray = (NSArray *)jsonObject;
                NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                [dict setObject:jsonArray forKey:@"Data"];
                completion(dict, nil);
            }
            else {
                NSDictionary *jsonDictionary = (NSDictionary *)jsonObject;
                completion(jsonDictionary, nil);
                
            }
        }else{
            completion(nil, [self convertError:data response:response]);
        }
    }];
    
    [task resume];
}

- (void)sendPOST:(NSString *)url queryParams:(id)queryParams body:(id)body completionHandler:(MojoAuthAPIResponseHandler)completion {
    NSMutableDictionary* queryParameters = [queryParams mutableCopy];
    NSString *apikey;
    NSString *access_token;
    
    NSError* error;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:body options:NSJSONWritingPrettyPrinted error: &error];
    
    if (queryParameters[@"apikey"]) {
        apikey = queryParameters[@"apikey"];
        [queryParameters removeObjectForKey:@"apikey"];
    }
    if (queryParameters[@"token"]) {
        access_token = queryParameters[@"token"];
        [queryParameters removeObjectForKey:@"token"];
    }
    
    
    NSURL *requestUrl;
    
    if (queryParameters.count > 0){
        requestUrl = [NSURL URLWithString:[_baseURL.absoluteString stringByAppendingString:queryParameters ? [url stringByAppendingString:[queryParameters queryString]]: url]];
    }else{
        
        requestUrl = [NSURL URLWithString:[_baseURL.absoluteString stringByAppendingString : url]];
        
    }
    
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:requestUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    
    [request setHTTPMethod:@"POST"];//use POST
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu",(unsigned long)[jsonData length]] forHTTPHeaderField:@"Content-length"];
    if (apikey !=nil) {
        [request addValue:apikey forHTTPHeaderField:@"X-API-Key"];
    }
    if (access_token !=nil) {
        NSString *token = [NSString stringWithFormat: @"Bearer %@", access_token];
        [request addValue:token forHTTPHeaderField:@"Authorization"];
    }
    
    
    [request setHTTPBody:jsonData];//set data
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        
        if([httpResponse statusCode] == 200){
            
            NSError *jsonError = nil;
            id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
            
            if ([jsonObject isKindOfClass:[NSArray class]]) {
                NSArray *jsonArray = (NSArray *)jsonObject;
                NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                [dict setObject:jsonArray forKey:@"Data"];
                completion(dict, nil);
            }
            else {
                NSDictionary *jsonDictionary = (NSDictionary *)jsonObject;
                completion(jsonDictionary, nil);
                
            }
        }else{
            completion(nil, [self convertError:data response:response]);
        }
    }];
    
    [task resume];
    
}

- (void)sendPUT:(NSString *)url queryParams:(id)queryParams body:(id)body completionHandler:(MojoAuthAPIResponseHandler)completion {
    NSString *apikey;
    NSString *access_token;
    NSMutableDictionary* queryParameters = [queryParams mutableCopy];
    NSError* error;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:body options:NSJSONWritingPrettyPrinted error: &error];
    
    if (queryParameters[@"apikey"]) {
        apikey = queryParameters[@"apikey"];
        [queryParameters removeObjectForKey:@"apikey"];
    }
    if (queryParameters[@"token"]) {
        access_token = queryParameters[@"token"];
        [queryParameters removeObjectForKey:@"token"];
    }
    
    NSURL *requestUrl;
    
    if (queryParameters.count > 0){
        requestUrl = [NSURL URLWithString:[_baseURL.absoluteString stringByAppendingString:queryParameters ? [url stringByAppendingString:[queryParameters queryString]]: url]];
    }else{
        
        requestUrl = [NSURL URLWithString:[_baseURL.absoluteString stringByAppendingString : url]];
        
    }
    
//    NSURL *requestUrl = [NSURL URLWithString:[_baseURL.absoluteString stringByAppendingString:queryParams ? [url stringByAppendingString:[queryParams queryString]]: url]];
    
    
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:requestUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    
    [request setHTTPMethod:@"PUT"];//use PUT
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu",(unsigned long)[jsonData length]] forHTTPHeaderField:@"Content-length"];
    if (apikey !=nil) {
        [request addValue:apikey forHTTPHeaderField:@"X-API-Key"];
    }
    if (access_token !=nil) {
        NSString *token = [NSString stringWithFormat: @"Bearer %@", access_token];
        [request addValue:token forHTTPHeaderField:@"Authorization"];
    }
    
    [request setHTTPBody:jsonData];//set data
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        
        if([httpResponse statusCode] == 200){
            
            NSError *jsonError = nil;
            id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
            
            if ([jsonObject isKindOfClass:[NSArray class]]) {
                NSArray *jsonArray = (NSArray *)jsonObject;
                NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                [dict setObject:jsonArray forKey:@"Data"];
                completion(dict, nil);
            }
            else {
                NSDictionary *jsonDictionary = (NSDictionary *)jsonObject;
                completion(jsonDictionary, nil);
                
            }
        }else{
            completion(nil, [self convertError:data response:response]);
        }
    }];
    
    [task resume];
}

- (void)sendDELETE:(NSString *)url queryParams:(id)queryParams body:(id)body completionHandler:(MojoAuthAPIResponseHandler)completion {
    NSString *apikey;
    NSString *access_token;
    NSMutableDictionary* queryParameters = [queryParams mutableCopy];
    NSError* error;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:body options:NSJSONWritingPrettyPrinted error: &error];
    
    if (queryParameters[@"apikey"]) {
        apikey = queryParameters[@"apikey"];
        [queryParameters removeObjectForKey:@"apikey"];
    }
    if (queryParameters[@"token"]) {
        access_token = queryParameters[@"token"];
        [queryParameters removeObjectForKey:@"token"];
    }
    
    NSURL *requestUrl;
    
    if (queryParameters.count > 0){
        requestUrl = [NSURL URLWithString:[_baseURL.absoluteString stringByAppendingString:queryParameters ? [url stringByAppendingString:[queryParameters queryString]]: url]];
    }else{
        
        requestUrl = [NSURL URLWithString:[_baseURL.absoluteString stringByAppendingString : url]];
        
    }
//    NSURL *requestUrl = [NSURL URLWithString:[_baseURL.absoluteString stringByAppendingString:queryParams ? [url stringByAppendingString:[queryParams queryString]]: url]];
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:requestUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    
    [request setHTTPMethod:@"DELETE"];//use DELETE
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu",(unsigned long)[jsonData length]] forHTTPHeaderField:@"Content-length"];
    if (apikey !=nil) {
        [request addValue:apikey forHTTPHeaderField:@"X-API-Key"];
    }
    if (access_token !=nil) {
        NSString *token = [NSString stringWithFormat: @"Bearer %@", access_token];
        [request addValue:token forHTTPHeaderField:@"Authorization"];
    }

    [request setHTTPBody:jsonData];//set data
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        
        if([httpResponse statusCode] == 200){
            
            NSError *jsonError = nil;
            id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
            
            if ([jsonObject isKindOfClass:[NSArray class]]) {
                NSArray *jsonArray = (NSArray *)jsonObject;
                NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                [dict setObject:jsonArray forKey:@"Data"];
                completion(dict, nil);
            }
            else {
                NSDictionary *jsonDictionary = (NSDictionary *)jsonObject;
                completion(jsonDictionary, nil);
                
            }
        }else{
            completion(nil, [self convertError:data response:response]);
        }
    }];
    
    [task resume];
    
}



-(NSError*) convertError:(NSData *)data response:(NSURLResponse *)response{
    NSError *mojoAuthError;
    
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
    
    if([httpResponse statusCode] == 0){
        mojoAuthError = [NSError errorWithCode:0 description:@"something went wrong or network not available please try again later" failureReason:@"something went wrong please try again later"];
    }else{
        
        NSError *jsonError;
        NSDictionary *payload = [[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError] dictionaryWithLowercaseKeys]; //lowercase all json dictionary keys
        if (!jsonError) { // HTTP Not acceptable errorCode. Deserialize MojoAuth Error if payload present
            
            if([payload objectForKey:errorCode]){
                if([payload[isProviderError] boolValue]) {
                    mojoAuthError = [NSError errorWithCode:[payload[errorCode] integerValue] description:payload[description] failureReason:payload[providerErrorResponse]];
                } else {
                    mojoAuthError = [NSError errorWithCode:[payload[errorCode] integerValue] description:payload[description] failureReason:payload[message]];
                }
                
            }else{
                NSString *convertedString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                if ([response.MIMEType  isEqual: @"application/javascript"])
                {
                    mojoAuthError = [NSError errorWithCode:0 description:convertedString failureReason:convertedString];
                }else
                {
                    mojoAuthError = [NSError errorWithCode:1 description:convertedString failureReason:convertedString];
                    
                }
            }
        }
    }
    return mojoAuthError;
    
}

-(NSData*) convertJSONPtoJSON: (NSData*)jsonpData
{
    NSString *jsonString = [[NSString alloc] initWithData:jsonpData encoding:NSUTF8StringEncoding];
    NSRange range = [jsonString rangeOfString:@"("];
    range.location++;
    NSRange rangeBack = [jsonString rangeOfString:@")" options:NSBackwardsSearch];
    range.length = rangeBack.location - range.location;
    jsonString = [jsonString substringWithRange:range];
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    return jsonData;
}

@end
