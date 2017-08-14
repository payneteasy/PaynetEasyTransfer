//
//  PaynetEasyTransferAPI.h
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

@interface MerchantAPI : BaseTransferAPI

- (void)requestAccessToken:(id<SessionProtocol>)session
             completeBlock:(void(^)(BOOL result, NSError *error))completeBlock;

- (void)initiateTransfer:(id<SessionProtocol>)session
             transaction:(id<TransactionProtocol>)transaction
                consumer:(id<ConsumerProtocol>)consumer
              sourceCard:(id<CardProtocol>)sourceCard
                destCard:(id<CardProtocol>)destCard
           completeBlock:(void(^)(BOOL result, NSError *error))completeBlock;

@end
