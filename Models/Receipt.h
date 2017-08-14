//
//  Receipt.h
//  PaynetEasyTransferExample
//
//  Created by Sergey Anisiforov on 10/05/2017.
//  Copyright © 2017 payneteasy. All rights reserved.
//

#import "ReceiptProtocol.h"

@interface Receipt : NSObject <ReceiptProtocol>

@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, strong) NSString *invoiceId;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSString *sourceCard;
@property (nonatomic, strong) NSString *sourceCardId;
@property (nonatomic, strong) NSString *destCard;
@property (nonatomic, strong) NSString *destCardId;
@property (nonatomic, strong) NSNumber *amountCentis;
@property (nonatomic, strong) NSNumber *commissionCentis;
@property (nonatomic, strong) NSString *currency;
@property (nonatomic, strong) NSString *comment;
@property (nonatomic, assign) TransferStatus status;

@end
