//
//  PaynetEasyTransferAPI.h
//  PaynetEasyTransfer
//
//  Created by Sergey Anisiforov on 29/03/17.
//  Copyright © 2017 payneteasy. All rights reserved.
//

#import "BaseTransferAPI.h"

#import "ConsumerProtocol.h"
#import "CardProtocol.h"
#import "RateProtocol.h"
#import "SessionProtocol.h"
#import "TransactionProtocol.h"
#import "ReceiptProtocol.h"

@interface MerchantAPI : BaseTransferAPI

// auth

- (void)requestAccessToken:(NSString *)bankId
                   session:(id<SessionProtocol>)session
             completeBlock:(void(^)(BOOL result, NSError *error))completeBlock;

// cardrefs

- (void)getClientIds:(NSString *)invoiceId
             session:(id<SessionProtocol>)session
            consumer:(id<ConsumerProtocol>)consumer
          sourceCard:(id<CardProtocol>)sourceCard
            destCard:(id<CardProtocol>)destCard
       completeBlock:(void(^)(BOOL result, NSError *error))completeBlock;

// config

- (void)getConfig:(id<SessionProtocol>)session
         consumer:(id<ConsumerProtocol>)consumer
    completeBlock:(void(^)(id result, NSError *error))completeBlock;

- (void)getConfigVersion:(id<SessionProtocol>)session
                consumer:(id<ConsumerProtocol>)consumer
           completeBlock:(void(^)(id result, NSError *error))completeBlock;

- (void)getRate:(id<RateProtocol>)rate
        session:(id<SessionProtocol>)session
       consumer:(id<ConsumerProtocol>)consumer
  completeBlock:(void(^)(BOOL result, NSError *error))completeBlock;

// support

- (void)sendMessage:(NSString *)message
              email:(NSString *)email
            orderId:(NSString *)orderId
            session:(id<SessionProtocol>)session
      completeBlock:(void(^)(BOOL result, NSError *error))completeBlock;

// transfer

- (void)initiateTransfer:(id<SessionProtocol>)session
             transaction:(id<TransactionProtocol>)transaction
                consumer:(id<ConsumerProtocol>)consumer
              sourceCard:(id<CardProtocol>)sourceCard
                destCard:(id<CardProtocol>)destCard
           completeBlock:(void(^)(BOOL result, NSError *error))completeBlock;

@end
