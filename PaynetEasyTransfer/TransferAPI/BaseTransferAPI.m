//
//  BaseTransferAPI.m
//  PaynetEasyTransfer
//
//  Created by Sergey Anisiforov on 04/07/2017.
//
//

#import "BaseTransferAPI.h"
#import "NSDictionary+Values.h"

#ifdef DEBUG
    #define log_rest_manager
#endif

@implementation BaseTransferAPI {
    NSURL *_baseURL;
    NSURLSession *_session;
    NSTimeInterval _timeoutInterval;
}

- (instancetype)initWithAddress:(NSString *)address {
    self = [self init];
    if (self) {
        _baseURL = [NSURL URLWithString:address];
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
        _timeoutInterval = 20;
    }
    return self;
}

- (void)setTimeoutInterval:(NSTimeInterval)interval {
    _timeoutInterval = interval;
}

#pragma mark - RestServer

- (NSURL *)baseURL {
    return _baseURL;
}

- (void)getWithUrl:(NSURL *)url
        completion:(void(^)(id result, NSError *error))completion {
    
    // compile request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"GET";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    request.timeoutInterval = _timeoutInterval;
    
    [self sendRequest:request completion:completion];
}

- (void)postWithUrl:(NSURL *)url
               body:(NSDictionary *)body
         completion:(void(^)(id result, NSError *error))completion {
    
    // compile request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    request.timeoutInterval = _timeoutInterval;
    if (body.count)
        request.HTTPBody = [NSJSONSerialization dataWithJSONObject:body options:0 error:nil];
    
    [self sendRequest:request completion:completion];
}

- (void)sendRequest:(NSURLRequest *)request completion:(void(^)(id result, NSError *error))completion {
#ifdef log_rest_manager
    NSLog(@"REST %@ address: %@", request.HTTPMethod, request.URL.absoluteString);
    if (request.HTTPBody) {
        NSString *strBody = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
        NSLog(@"REST %@ body: %@", request.HTTPMethod, strBody);
    }
#endif
    NSURLSessionDataTask *task = [_session dataTaskWithRequest:request
                                             completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                 id result = nil;
#ifdef log_rest_manager
                                                 NSInteger statusCode = ((NSHTTPURLResponse *)response).statusCode;
                                                 NSString *strResponse = (data != nil) ? [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] : @"";
                                                     NSLog(@"REST %@ response: [%ld] %@", request.HTTPMethod, (long)statusCode, strResponse);
                                                 if (error)
                                                     NSLog(@"REST %@ error: %@", request.HTTPMethod, error);
#endif
                                                 if (data && !error) {
                                                     error = [self parseResponseErrorFromData:data];
                                                     if (!error)
                                                         result = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                 }
                                                 dispatch_sync(dispatch_get_main_queue(), ^{
                                                     completion(result, error);
                                                 });
                                             }];
    [task resume];
}

- (NSError *)parseResponseErrorFromData:(NSData *)data {
    if (data) {
        NSError *error;
        id obj = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if (obj && [obj isKindOfClass:[NSDictionary class]]) {
            id errDict = [obj get_DictionaryForKey:@"error"];
            if (errDict && [errDict isKindOfClass:[NSDictionary class]]) {
                NSString *cause = [errDict get_StringForKey:@"cause"];
                NSInteger code = [errDict get_IntegerForKey:@"code"];
                NSString *message = [errDict get_StringForKey:@"message"];
                NSDictionary *userInfo = (message.length > 0) ? @{NSLocalizedDescriptionKey : message} : nil;
                return [NSError errorWithDomain:cause code:code userInfo:userInfo];
            }
        }
    }
    return nil;
}

@end
