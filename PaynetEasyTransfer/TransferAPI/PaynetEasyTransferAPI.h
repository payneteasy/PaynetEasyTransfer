//
//  PaynetEasyTransferAPI.h
//  PaynetEasyTransfer
//
//  Created by Sergey Anisiforov on 29/03/17.
//  Copyright © 2017 payneteasy. All rights reserved.
//

#import "ConsumerProtocol.h"
#import "CardProtocol.h"
#import "RateProtocol.h"
#import "SessionProtocol.h"
#import "TransactionProtocol.h"
#import "ReceiptProtocol.h"

@interface PaynetEasyTransferAPI : NSObject

@property (nonatomic, strong) NSURL *paynetURL;
@property (nonatomic, strong) NSURL *merchantAuthURL;
@property (nonatomic, strong) NSURL *merchantTransferRateURL;
@property (nonatomic, strong) NSURL *merchantTransferInitURL;

- (void)setUpdateInterval:(NSTimeInterval)interval;
- (void)setTimeoutInterval:(NSTimeInterval)interval;

// merchant methods

- (void)requestAccessToken:(id<SessionProtocol>)session
             completeBlock:(void(^)(BOOL result, NSError *error))completeBlock;

- (void)requestTransferRate:(id<RateProtocol>)rate
              completeBlock:(void(^)(BOOL result, NSError *error))completeBlock;

- (void)initiateTransfer:(id<SessionProtocol>)session
             transaction:(id<TransactionProtocol>)transaction
                consumer:(id<ConsumerProtocol>)consumer
              sourceCard:(id<CardProtocol>)sourceCard
                destCard:(id<CardProtocol>)destCard
           completeBlock:(void(^)(BOOL result, NSError *error))completeBlock;

// paynet methods

- (void)tranferMoney:(id<SessionProtocol>)session
         transaction:(id<TransactionProtocol>)transaction
            consumer:(id<ConsumerProtocol>)consumer
          sourceCard:(id<CardProtocol>)sourceCard
            destCard:(id<CardProtocol>)destCard
             receipt:(id<ReceiptProtocol>)receipt
       redirectBlock:(void(^)(NSString *redirectUrl))redirectBlock
       continueBlock:(void(^)(BOOL *stop))continueBlock
       completeBlock:(void(^)(BOOL result, NSError *error))completeBlock;

@end
