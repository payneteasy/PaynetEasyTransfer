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
@property (nonatomic) NSString *fromBin;
@property (nonatomic) NSString *toBin;
@property (nonatomic) NSNumber *amountCentis;
@property (nonatomic) NSDecimalNumber *comission;
@property (nonatomic) NSString *currency;
@property (nonatomic) NSString *token;

@end
