//
//  MerchantAPI.m
//  PaynetEasyTransfer
//
//  Created by Sergey Anisiforov on 29/03/17.
//  Copyright © 2017 payneteasy. All rights reserved.
//

#import "MerchantAPI.h"
#import "NSDictionary+Values.h"
#import "NSMutableDictionary+Values.h"
#import "NSDictionary+Utils.h"

#define transferState_PROCESSING        @"PROCESSING"
#define transferState_REDIRECT_REQUEST  @"REDIRECT_REQUEST"
#define transferState_APPROVED          @"APPROVED"
#define transferState_DECLINED          @"DECLINED"

@implementation MerchantAPI

#pragma mark - auth

- (void)requestAccessToken:(NSString *)bankId
                   session:(id<SessionProtocol>)session
             completeBlock:(void(^)(BOOL result, NSError *error))completeBlock {

    if (!bankId.length) {
        completeBlock(NO, nil);
        return;
    }
    
    // url
    NSURL *url = self.baseURL;
    url = [url URLByAppendingPathComponent:@"auth"];
    url = [url URLByAppendingPathComponent:bankId];
    url = [url URLByAppendingPathComponent:@"request-access-token"];
    
    [self getWithUrl:url completion:^(id result, NSError *error) {
        if (result && !error) {
            session.accessToken = [result get_StringForPath:@"session.accessToken"];
            completeBlock(YES, nil);
        } else
            completeBlock(NO, error);
    }];
}

#pragma mark - cardrefs

- (void)getClientIds:(NSString *)invoiceId
             session:(id<SessionProtocol>)session
            consumer:(id<ConsumerProtocol>)consumer
          sourceCard:(id<CardProtocol>)sourceCard
            destCard:(id<CardProtocol>)destCard
       completeBlock:(void(^)(BOOL result, NSError *error))completeBlock {
    
    if (!invoiceId.length) {
        completeBlock(NO, nil);
        return;
    }
    
    // body
    NSMutableDictionary *body = [NSMutableDictionary dictionary];
    [body set_Object:consumer.deviceNumber       forPath:@"consumer.device.serialNumber"];
    [body set_Object:session.accessToken         forPath:@"session.accessToken"];
    
    // url
    NSURL *url = self.baseURL;
    url = [url URLByAppendingPathComponent:@"cardrefs"];
    url = [url URLByAppendingPathComponent:invoiceId];
    url = [url URLByAppendingPathComponent:@"get-client-ids"];
    
    [self postWithUrl:url body:body completion:^(id result, NSError *error) {
        if (result && !error) {
            sourceCard.cardId  = [result get_StringForPath:@"sourceCardRefId"];
            destCard.cardId = [result get_StringForPath:@"destinationCardRefId"];
            completeBlock(YES, nil);
        } else
            completeBlock(NO, error);
    }];
}

#pragma mark - config

- (void)getConfig:(id<SessionProtocol>)session
         consumer:(id<ConsumerProtocol>)consumer
    completeBlock:(void(^)(id result, NSError *error))completeBlock {
    
    // body
    NSMutableDictionary *body = [NSMutableDictionary dictionary];
    [body set_Object:consumer.deviceNumber       forPath:@"consumer.device.serialNumber"];
    [body set_Object:session.accessToken         forPath:@"session.accessToken"];
    
    // url
    NSURL *url = self.baseURL;
    url = [url URLByAppendingPathComponent:@"config"];
    url = [url URLByAppendingPathComponent:@"get-config"];
    
    [self postWithUrl:url body:body completion:^(id result, NSError *error) {
        if (result && !error) {
            completeBlock(result, nil);
        } else
            completeBlock(nil, error);
    }];
}

- (void)getConfigVersion:(id<SessionProtocol>)session
                consumer:(id<ConsumerProtocol>)consumer
           completeBlock:(void(^)(id result, NSError *error))completeBlock {
    
    // body
    NSMutableDictionary *body = [NSMutableDictionary dictionary];
    [body set_Object:consumer.deviceNumber       forPath:@"consumer.device.serialNumber"];
    [body set_Object:session.accessToken         forPath:@"session.accessToken"];
    
    // url
    NSURL *url = self.baseURL;
    url = [url URLByAppendingPathComponent:@"config"];
    url = [url URLByAppendingPathComponent:@"get-config-version"];
    
    [self postWithUrl:url body:body completion:^(id result, NSError *error) {
        if (result && !error) {
            completeBlock(result, nil);
        } else
            completeBlock(nil, error);
    }];
}

- (void)getRate:(id<RateProtocol>)rate
        session:(id<SessionProtocol>)session
       consumer:(id<ConsumerProtocol>)consumer
  completeBlock:(void(^)(BOOL result, NSError *error))completeBlock {
    
    // body
    NSMutableDictionary *body = [NSMutableDictionary dictionary];
    [body set_Object:consumer.deviceNumber       forPath:@"consumer.device.serialNumber"];
    [body set_Object:session.accessToken         forPath:@"session.accessToken"];
    
    // url
    NSURL *url = self.baseURL;
    url = [url URLByAppendingPathComponent:@"config"];
    url = [url URLByAppendingPathComponent:@"get-rate"];

    [self postWithUrl:url body:body completion:^(id result, NSError *error) {
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

#pragma mark - support

- (void)sendMessage:(NSString *)message
              email:(NSString *)email
            orderId:(NSString *)orderId
            session:(id<SessionProtocol>)session
      completeBlock:(void(^)(BOOL result, NSError *error))completeBlock {
    
    // body
    NSMutableDictionary *body = [NSMutableDictionary dictionary];
    [body set_Object:message forPath:@"message"];
    [body set_Object:email forPath:@"email"];
    [body set_Object:orderId forPath:@"orderId"];
    [body set_Object:session.accessToken forPath:@"session.accessToken"];
    
    // url
    NSURL *url = self.baseURL;
    url = [url URLByAppendingPathComponent:@"support"];
    url = [url URLByAppendingPathComponent:@"send-message"];
    
    [self postWithUrl:url body:body completion:^(id result, NSError *error) {
        if (!error) {
            completeBlock(YES, nil);
        } else
            completeBlock(NO, error);
    }];
}

#pragma mark - transfer

- (void)initiateTransfer:(id<SessionProtocol>)session
             transaction:(id<TransactionProtocol>)transaction
                consumer:(id<ConsumerProtocol>)consumer
              sourceCard:(id<CardProtocol>)sourceCard
                destCard:(id<CardProtocol>)destCard
           completeBlock:(void(^)(BOOL result, NSError *error))completeBlock {

    // body
    NSMutableDictionary *body = [NSMutableDictionary dictionary];
    [body set_Object:consumer.deviceNumber       forPath:@"consumer.device.serialNumber"];
    [body set_Object:session.accessToken         forPath:@"session.accessToken"];
    if (sourceCard.number.length > 5)
        [body set_Object:[sourceCard.number substringToIndex:6] forPath:@"transaction.fromBin"];
    if (destCard.number.length > 5)
        [body set_Object:[destCard.number substringToIndex:6] forPath:@"transaction.toBin"];
    [body set_Object:transaction.amountCentis    forPath:@"transaction.amountCentis"];
    [body set_Object:transaction.currency        forPath:@"transaction.currency"];
    
    // url
    NSURL *url = self.baseURL;
    url = [url URLByAppendingPathComponent:@"transfer"];
    url = [url URLByAppendingPathComponent:@"initiate-transfer"];
    
    [self postWithUrl:url body:[body clearEmptyChilds] completion:^(id result, NSError *error) {
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

@end
