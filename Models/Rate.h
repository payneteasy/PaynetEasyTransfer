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
@property (nonatomic, strong) NSDecimalNumber *interest;
@property (nonatomic, strong) NSDecimalNumber *rateMin;
@property (nonatomic, strong) NSDecimalNumber *rateMax;
@property (nonatomic, strong) NSDecimalNumber *limitMin;
@property (nonatomic, strong) NSDecimalNumber *limitMax;

@end
