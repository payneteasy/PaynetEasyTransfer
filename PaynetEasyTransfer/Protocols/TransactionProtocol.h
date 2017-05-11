//
//  TransactionProtocol.h
//  PaynetEasyTransfer
//
//  Created by Sergey Anisiforov on 23/03/17.
//  Copyright © 2017 payneteasy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TransactionProtocol

@property (nonatomic) NSString *endpointId;
@property (nonatomic) NSString *invoiceId;
@property (nonatomic) NSNumber *amountCentis;
@property (nonatomic) NSNumber *commissionCentis;
@property (nonatomic) NSString *currency;

@end
