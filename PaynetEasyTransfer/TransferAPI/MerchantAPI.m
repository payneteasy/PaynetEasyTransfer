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

@implementation MerchantAPI

- (void)requestAccessToken:(id<SessionProtocol>)session
             completeBlock:(void(^)(BOOL result, NSError *error))completeBlock {
    
    // url
    NSURL *url = self.baseURL;
    url = [url URLByAppendingPathComponent:@"auth"];
    url = [url URLByAppendingPathComponent:@"request-access-token"];
    
    [self getWithUrl:url completion:^(id result, NSError *error) {
        if (result && !error) {
            session.accessToken = [result get_StringForPath:@"session.accessToken"];
            completeBlock(YES, nil);
        } else
            completeBlock(NO, error);
    }];
}

- (void)initiateTransfer:(id<SessionProtocol>)session
             transaction:(id<TransactionProtocol>)transaction
                consumer:(id<ConsumerProtocol>)consumer
              sourceCard:(id<CardProtocol>)sourceCard
                destCard:(id<CardProtocol>)destCard
           completeBlock:(void(^)(BOOL result, NSError *error))completeBlock {

    // body
    NSMutableDictionary *body = [NSMutableDictionary dictionary];
    [body set_Object:consumer.deviceNumber forPath:@"consumer.device.serialNumber"];
    [body set_Object:session.accessToken forPath:@"session.accessToken"];
    if (sourceCard.number.length > 5)
        [body set_Object:[sourceCard.number substringToIndex:6] forPath:@"transaction.fromBin"];
    if (destCard.number.length > 5)
        [body set_Object:[destCard.number substringToIndex:6] forPath:@"transaction.toBin"];
    [body set_Object:transaction.amountCentis forPath:@"transaction.amountCentis"];
    [body set_Object:transaction.currency forPath:@"transaction.currency"];
    
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
