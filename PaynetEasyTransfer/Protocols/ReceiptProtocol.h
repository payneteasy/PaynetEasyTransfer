//
//  ReceiptProtocol.h
//  PaynetEasyTransfer
//
//  Created by Sergey Anisiforov on 05/05/17.
//  Copyright © 2017 payneteasy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ReceiptStatus) {
    ReceiptStatusUnknown = 0,
    ReceiptStatusApproved,
    ReceiptStatusDeclined,
    ReceiptStatusCancelled
};

@protocol ReceiptProtocol

@property (nonatomic) NSString *orderId;
@property (nonatomic) NSDate *date;
@property (nonatomic) NSString *sourceCard;
@property (nonatomic) NSString *destCard;
@property (nonatomic) NSNumber *amountCentis;
@property (nonatomic) NSNumber *commissionCentis;
@property (nonatomic) NSString *currency;
@property (nonatomic) NSString *comment;
@property (nonatomic) ReceiptStatus status;

@end
