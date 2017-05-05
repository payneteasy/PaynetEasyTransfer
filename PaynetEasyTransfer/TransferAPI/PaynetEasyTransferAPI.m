//
//  PaynetEasyTransferAPI.m
//  PaynetEasyTransfer
//
//  Created by Sergey Anisiforov on 29/03/17.
//  Copyright © 2017 payneteasy. All rights reserved.
//

#import "PaynetEasyTransferAPI.h"
#import "NSDictionary+Values.h"
#import "NSMutableDictionary+Values.h"
#import "NSDictionary+Utils.h"

#define transferState_PROCESSING        @"PROCESSING"
#define transferState_REDIRECT_REQUEST  @"REDIRECT_REQUEST"
#define transferState_APPROVED          @"APPROVED"
#define transferState_DECLINED          @"DECLINED"

#ifdef DEBUG
    #define log_rest_manager
#endif

@implementation PaynetEasyTransferAPI {
    NSURLSession *_session;
    NSTimeInterval _updateInterval;
    NSTimeInterval _timeoutInterval;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
        _updateInterval = 1.0;
        _timeoutInterval = 20;
    }
    return self;
}

- (void)setUpdateInterval:(NSTimeInterval)interval {
    _updateInterval = interval;
}

- (void)setTimeoutInterval:(NSTimeInterval)interval {
    _timeoutInterval = interval;
}

#pragma mark - merchant methods

- (void)requestAccessToken:(id<SessionProtocol>)session
             completeBlock:(void(^)(BOOL result, NSError *error))completeBlock {
    [self getWithUrl:_merchantAuthURL completion:^(id result, NSError *error) {
        if (result && !error) {
            session.accessToken = [result get_StringForPath:@"session.accessToken"];
            completeBlock(YES, nil);
        } else
            completeBlock(NO, error);
    }];
}

- (void)requestTransferRate:(id<RateProtocol>)rate
              completeBlock:(void(^)(BOOL result, NSError *error))completeBlock {

    [self postWithUrl:_merchantTransferRateURL body:nil completion:^(id result, NSError *error) {
        if (result && !error) {
            rate.interest = [[NSDecimalNumber alloc] initWithDouble:[result get_DoubleForPath:@"rateInterest"]];
            rate.rateMin  = [[NSDecimalNumber alloc] initWithDouble:[result get_DoubleForPath:@"rateMin"]];
            rate.rateMax  = [[NSDecimalNumber alloc] initWithDouble:[result get_DoubleForPath:@"rateMax"]];
            rate.limitMin = [[NSDecimalNumber alloc] initWithDouble:[result get_DoubleForPath:@"limitMin"]];
            rate.limitMax = [[NSDecimalNumber alloc] initWithDouble:[result get_DoubleForPath:@"limitMax"]];
            completeBlock(YES, nil);
        } else
            completeBlock(NO, error);
    }];
}

- (void)initiateTransfer:(id<SessionProtocol>)session
             transaction:(id<TransactionProtocol>)transaction
                consumer:(id<ConsumerProtocol>)consumer
           completeBlock:(void(^)(BOOL result, NSError *error))completeBlock {

    // body
    NSMutableDictionary *body = [NSMutableDictionary dictionary];
    [body set_Object:consumer.deviceNumber       forPath:@"consumer.device.serialNumber"];
    [body set_Object:session.accessToken         forPath:@"session.accessToken"];
    [body set_Object:transaction.fromBin         forPath:@"transaction.fromBin"];
    [body set_Object:transaction.toBin           forPath:@"transaction.toBin"];
    [body set_Object:transaction.amountCentis    forPath:@"transaction.amountCentis"];
    [body set_Object:transaction.currency        forPath:@"transaction.currency"];
    
    [self postWithUrl:_merchantTransferInitURL body:[body clearEmptyChilds] completion:^(id result, NSError *error) {
        if (result && !error) {
            transaction.endpointId = [result get_StringForPath:@"endpointId"];
            transaction.invoiceId  = [result get_StringForPath:@"invoiceId"];
            session.nonce          = [result get_StringForPath:@"session.nonce"];
            session.signature      = [result get_StringForPath:@"session.signature"];
            completeBlock(YES, nil);
        } else
            completeBlock(NO, error);
    }];
}

#pragma mark - paynet methods

- (void)tranferMoney:(id<TransactionProtocol>)transaction
             session:(id<SessionProtocol>)session
          sourceCard:(id<CardProtocol>)sourceCard
            destCard:(id<CardProtocol>)destCard
            consumer:(id<ConsumerProtocol>)consumer
       redirectBlock:(void(^)(NSString *redirectUrl))redirectBlock
       continueBlock:(void(^)(BOOL *stop))continueBlock
       completeBlock:(void(^)(BOOL result, NSError *error))completeBlock {
    
    // body
    NSMutableDictionary *body = [NSMutableDictionary dictionary];
    [body set_Object:consumer.deviceNumber      forPath:@"consumer.device.serialNumber"];
    
    [body set_Object:session.accessToken        forPath:@"session.accessToken"];
    [body set_Object:session.nonce              forPath:@"session.nonce"];
    [body set_Object:session.signature          forPath:@"session.signature"];
    
    [body set_Object:transaction.amountCentis   forPath:@"transaction.amountCentis"];
    [body set_Object:transaction.currency       forPath:@"transaction.currency"];
    
    [body set_Object:sourceCard.number          forPath:@"sourceOfFunds.card.number"];
    [body set_Object:sourceCard.securityCode    forPath:@"sourceOfFunds.card.securityCode"];
    [body set_Object:sourceCard.expiryMonth     forPath:@"sourceOfFunds.card.expiry.month"];
    [body set_Object:sourceCard.expiryYear      forPath:@"sourceOfFunds.card.expiry.year"];
    [body set_Object:sourceCard.cardHolder      forPath:@"sourceOfFunds.card.holder.printedName"];
    
    [body set_Object:destCard.number            forPath:@"destinationOfFunds.card.number"];
    
    // url
    NSURL *url = _paynetURL;
    url = [url URLByAppendingPathComponent:transaction.endpointId];
    url = [url URLByAppendingPathComponent:transaction.invoiceId];
    
    [self postWithUrl:url body:[body clearEmptyChilds] completion:^(id result, NSError *error) {
        if (result && !error) {
            session.token = [result get_StringForPath:@"session.token"];
            [self checkTransferStatus:transaction
                              session:session
                        redirectBlock:redirectBlock
                        continueBlock:continueBlock
                        completeBlock:completeBlock];
        } else
            completeBlock(NO, error);
    }];
}

- (void)checkTransferStatus:(id<TransactionProtocol>)transaction
                    session:(id<SessionProtocol>)session
              redirectBlock:(void(^)(NSString *redirectUrl))redirectBlock
              continueBlock:(void(^)(BOOL *stop))continueBlock
              completeBlock:(void(^)(BOOL result, NSError *error))completeBlock {
    
    // body
    NSMutableDictionary *body = [NSMutableDictionary dictionary];
    [body set_Object:session.accessToken forPath:@"session.accessToken"];
    [body set_Object:session.token       forPath:@"session.token"];
    
    // url
    NSURL *url = _paynetURL;
    url = [url URLByAppendingPathComponent:transaction.endpointId];
    url = [url URLByAppendingPathComponent:transaction.invoiceId];
    url = [url URLByAppendingPathComponent:@"status"];
    
    [self postWithUrl:url body:[body clearEmptyChilds] completion:^(id result, NSError *error) {
        if (result && !error) {
            BOOL stop = NO;
            if (continueBlock)
                continueBlock(&stop);
            if (!stop) {
                BOOL needRepeat = NO;
                NSString *state = [result get_StringForPath:@"state"];
                // processing
                if ([state isEqualToString:transferState_PROCESSING]) {
                    needRepeat = YES;
                // approved
                } else if ([state isEqualToString:transferState_APPROVED]) {
                    transaction.orderId = [result get_StringForPath:@"orderId"];
                    transaction.orderDate = [self parseDateTimeFromString:[result get_StringForPath:@"transaction.orderCreatedDate"]];
                    transaction.transactionDate = [self parseDateTimeFromString:[result get_StringForPath:@"transaction.transactionCreatedDate"]];
                    transaction.transactionAmountCentis = @([result get_IntegerForPath:@"transaction.amountCentis"]);
                    transaction.transactionCommissionCentis = @([result get_IntegerForPath:@"transaction.commissionCentis"]);
                    completeBlock(YES, nil);
                // redirect
                } else if ([state isEqualToString:transferState_REDIRECT_REQUEST]) {
                    NSString *redirectUrl = [result get_StringForPath:@"redirectUrl"];
                    if (redirectBlock)
                        redirectBlock(redirectUrl);
                    needRepeat = YES;
                // decline
                } else {
                    transaction.orderId = [result get_StringForPath:@"orderId"];
                    transaction.orderDate = [self parseDateTimeFromString:[result get_StringForPath:@"transaction.orderCreatedDate"]];
                    transaction.transactionDate = [self parseDateTimeFromString:[result get_StringForPath:@"transaction.transactionCreatedDate"]];
                    transaction.transactionAmountCentis = @([result get_IntegerForPath:@"transaction.amountCentis"]);
                    transaction.transactionCommissionCentis = [[NSDecimalNumber alloc] initWithDouble:[result get_DoubleForPath:@"transaction.commissionCentis"]];
                    completeBlock(NO, nil);
                }
                // repeat
                if (needRepeat) {
                    if (!stop) {
                        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, _updateInterval * NSEC_PER_SEC);
                        dispatch_after(time, dispatch_get_main_queue(), ^{
                            [self checkTransferStatus:transaction
                                              session:session
                                        redirectBlock:redirectBlock
                                        continueBlock:continueBlock
                                        completeBlock:completeBlock];
                        });
                    }
                }
            } else
                completeBlock(NO, nil);
        } else
            completeBlock(NO, error);
    }];
}

#pragma mark - rest methods

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
    NSLog(@"%@ address:\n%@", request.HTTPMethod, request.URL.absoluteString);
    if (request.HTTPBody) {
        NSString *strBody = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
        NSLog(@"%@ body:\n%@", request.HTTPMethod, strBody);
    }
#endif
    NSURLSessionDataTask *task = [_session dataTaskWithRequest:request
                                             completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                 id result = nil;
#ifdef log_rest_manager
                                                 if (data) {
                                                     NSString *strResponse = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                     NSLog(@"%@ response:\n%@", request.HTTPMethod, strResponse);
                                                 }
                                                 if (error)
                                                     NSLog(@"%@ error:\n%@", request.HTTPMethod, error);
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
                return [NSError errorWithDomain:cause code:code userInfo:@{NSLocalizedDescriptionKey : message}];
            }
        }
    }
    return nil;
}

- (NSDate *)parseDateTimeFromString:(NSString *)string {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSSZ"];
    return [dateFormat dateFromString:string];
}

@end
