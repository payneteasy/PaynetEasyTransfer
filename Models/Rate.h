//
//  Rate.h
//  PaynetEasyTransfer
//
//  Created by Sergey Anisiforov on 30/03/17.
//  Copyright © 2017 payneteasy. All rights reserved.
//

#import "RateProtocol.h"

@interface Rate : NSObject <RateProtocol>

@property (nonatomic, strong) NSString *fromBin;
@property (nonatomic, strong) NSString *toBin;
@property (nonatomic) NSDecimalNumber *interest;
@property (nonatomic) NSDecimalNumber *rateMin;
@property (nonatomic) NSDecimalNumber *rateMax;
@property (nonatomic) NSDecimalNumber *limitMin;
@property (nonatomic) NSDecimalNumber *limitMax;

@end
