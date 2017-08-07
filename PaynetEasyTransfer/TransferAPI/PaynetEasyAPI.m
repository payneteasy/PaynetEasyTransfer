//
//  PaynetEasyAPI.m
//  PaynetEasyTransfer
//
//  Created by Sergey Anisiforov on 29/03/17.
//  Copyright © 2017 payneteasy. All rights reserved.
//

#import "PaynetEasyAPI.h"
#import "NSDictionary+Values.h"
#import "NSMutableDictionary+Values.h"
#import "NSDictionary+Utils.h"

#define transferState_PROCESSING        @"PROCESSING"
#define transferState_REDIRECT_REQUEST  @"REDIRECT_REQUEST"
#define transferState_APPROVED          @"APPROVED"
#define transferState_DECLINED          @"DECLINED"

@implementation PaynetEasyAPI {
    NSTimeInterval _updateInterval;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _updateInterval = 1.0;
    }
    return self;
}

- (void)setUpdateInterval:(NSTimeInterval)interval {
    _updateInterval = interval;
}

- (void)tranferMoney:(id<SessionProtocol>)session
         transaction:(id<TransactionProtocol>)transaction
            consumer:(id<ConsumerProtocol>)consumer
          sourceCard:(id<CardProtocol>)sourceCard
            destCard:(id<CardProtocol>)destCard
             receipt:(id<ReceiptProtocol>)receipt
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
    
    if (sourceCard.cardId.length) {
        [body set_Object:sourceCard.cardId          forPath:@"sourceOfFunds.reference.clientCardId"];
        [body set_Object:sourceCard.securityCode    forPath:@"sourceOfFunds.reference.securityCode"];
    } else {
        [body set_Object:sourceCard.number          forPath:@"sourceOfFunds.card.number"];
        [body set_Object:sourceCard.securityCode    forPath:@"sourceOfFunds.card.securityCode"];
        [body set_Object:sourceCard.expiryMonth     forPath:@"sourceOfFunds.card.expiry.month"];
        [body set_Object:sourceCard.expiryYear      forPath:@"sourceOfFunds.card.expiry.year"];
        [body set_Object:sourceCard.cardHolder      forPath:@"sourceOfFunds.card.holder.printedName"];
    }
    
    if (destCard.cardId.length) {
        [body set_Object:destCard.cardId            forPath:@"destinationOfFunds.reference.clientCardId"];
    } else {
        [body set_Object:destCard.number            forPath:@"destinationOfFunds.card.number"];
    }
    
    // url
    NSURL *url = self.baseURL;
    url = [url URLByAppendingPathComponent:transaction.endpointId];
    url = [url URLByAppendingPathComponent:transaction.invoiceId];
    
    [self postWithUrl:url body:[body clearEmptyChilds] completion:^(id result, NSError *error) {
        if (result && !error) {
            session.token = [result get_StringForPath:@"session.token"];
            if (receipt) {
                receipt.invoiceId = transaction.invoiceId;
                receipt.sourceCard = sourceCard.number;
                receipt.sourceCardId = sourceCard.cardId;
                receipt.destCard = destCard.number;
                receipt.destCardId = destCard.cardId;
                receipt.status = TransferStatusUnknown;
            }
            [self checkTransferStatus:session
                          transaction:transaction
                              receipt:receipt
                        redirectBlock:redirectBlock
                        continueBlock:continueBlock
                        completeBlock:completeBlock];
        } else
            completeBlock(NO, error);
    }];
}

- (void)checkTransferStatus:(id<SessionProtocol>)session
                transaction:(id<TransactionProtocol>)transaction
                    receipt:(id<ReceiptProtocol>)receipt
              redirectBlock:(void(^)(NSString *redirectUrl))redirectBlock
              continueBlock:(void(^)(BOOL *stop))continueBlock
              completeBlock:(void(^)(BOOL result, NSError *error))completeBlock {
    
    // body
    NSMutableDictionary *body = [NSMutableDictionary dictionary];
    [body set_Object:session.accessToken forPath:@"session.accessToken"];
    [body set_Object:session.token       forPath:@"session.token"];
    
    // url
    NSURL *url = self.baseURL;
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
                    if (receipt) {
                        [self parseReceipt:receipt fromDict:result];
                        receipt.status = TransferStatusApproved;
                    }
                    completeBlock(YES, nil);
                // redirect
                } else if ([state isEqualToString:transferState_REDIRECT_REQUEST]) {
                    NSString *redirectUrl = [result get_StringForPath:@"redirectUrl"];
                    if (redirectBlock)
                        redirectBlock(redirectUrl);
                    needRepeat = YES;
                // decline
                } else {
                    if (receipt) {
                        [self parseReceipt:receipt fromDict:result];
                        receipt.status = TransferStatusDeclined;
                    }
                    completeBlock(NO, nil);
                }
                // repeat
                if (needRepeat) {
                    if (!stop) {
                        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, _updateInterval * NSEC_PER_SEC);
                        dispatch_after(time, dispatch_get_main_queue(), ^{
                            [self checkTransferStatus:session
                                          transaction:transaction
                                              receipt:receipt
                                        redirectBlock:redirectBlock
                                        continueBlock:continueBlock
                                        completeBlock:completeBlock];
                        });
                    }
                }
            } else {
                if (receipt)
                    receipt.status = TransferStatusCancelled;
                completeBlock(NO, nil);
            }
        } else {
            if (receipt)
                receipt.status = TransferStatusError;
            completeBlock(NO, error);
        }
    }];
}

#pragma mark - parse methods

- (void)parseReceipt:(id<ReceiptProtocol>)receipt fromDict:(NSDictionary *)dict {
    receipt.orderId = [dict get_StringForPath:@"orderId"];
    receipt.date = [self parseDateTimeFromString:[dict get_StringForPath:@"transaction.transactionCreatedDate"]];
    receipt.amountCentis = @([dict get_IntegerForPath:@"transaction.amountCentis"]);
    receipt.commissionCentis = @([dict get_IntegerForPath:@"transaction.commissionCentis"]);
    receipt.currency = [dict get_StringForPath:@"transaction.currency"];
    receipt.comment = nil;
}

- (NSDate *)parseDateTimeFromString:(NSString *)string {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSSZ"];
    return [dateFormat dateFromString:string];
}

@end
