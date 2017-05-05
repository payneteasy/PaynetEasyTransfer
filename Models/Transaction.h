//
//  Transaction.h
//  PaynetEasyTransfer
//
//  Created by Sergey Anisiforov on 23/03/17.
//  Copyright © 2017 payneteasy. All rights reserved.
//

#import "TransactionProtocol.h"

@interface Transaction : NSObject <TransactionProtocol>

@property (nonatomic, strong) NSString *endpointId;
@property (nonatomic, strong) NSString *invoiceId;
@property (nonatomic, strong) NSString *fromBin;
@property (nonatomic, strong) NSString *toBin;
@property (nonatomic, strong) NSNumber *amountCentis;
@property (nonatomic, strong) NSNumber *commissionCentis;
@property (nonatomic, strong) NSString *currency;

@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, strong) NSDate *orderDate;
@property (nonatomic, strong) NSDate *transactionDate;
@property (nonatomic, strong) NSNumber *transactionAmountCentis;
@property (nonatomic, strong) NSNumber *transactionCommissionCentis;

@end
