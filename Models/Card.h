//
//  Card.h
//  PaynetEasyTransfer
//
//  Created by Sergey Anisiforov on 23/03/17.
//  Copyright © 2017 payneteasy. All rights reserved.
//

#import "CardProtocol.h"

@interface Card : NSObject <CardProtocol>

@property (nonatomic, strong) NSString *cardId;
@property (nonatomic, strong) NSString *number;
@property (nonatomic, strong) NSString *securityCode;
@property (nonatomic, strong) NSNumber *expiryMonth;
@property (nonatomic, strong) NSNumber *expiryYear;
@property (nonatomic, strong) NSString *cardHolder;

@end
