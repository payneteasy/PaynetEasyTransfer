//
//  PaynetEasyAPI.h
//  PaynetEasyTransfer
//
//  Created by Sergey Anisiforov on 29/03/17.
//  Copyright © 2017 payneteasy. All rights reserved.
//

#import "BaseTransferAPI.h"

#import "SessionProtocol.h"
#import "TransactionProtocol.h"
#import "ConsumerProtocol.h"
#import "CardProtocol.h"
#import "ReceiptProtocol.h"

@interface PaynetEasyAPI : BaseTransferAPI

- (void)setUpdateInterval:(NSTimeInterval)interval;

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
