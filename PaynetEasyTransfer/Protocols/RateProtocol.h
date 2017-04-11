//
//  RateProtocol.h
//  PaynetEasyTransfer
//
//  Created by Sergey Anisiforov on 30/03/17.
//  Copyright © 2017 payneteasy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RateProtocol

@property (nonatomic) NSString *fromBin;
@property (nonatomic) NSString *toBin;
@property (nonatomic) NSDecimalNumber *interest;
@property (nonatomic) NSDecimalNumber *rateMin;
@property (nonatomic) NSDecimalNumber *rateMax;
@property (nonatomic) NSDecimalNumber *limitMin;
@property (nonatomic) NSDecimalNumber *limitMax;

@end
