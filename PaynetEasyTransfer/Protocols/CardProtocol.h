//
//  CardProtocol.h
//  PaynetEasyTransfer
//
//  Created by Sergey Anisiforov on 23/03/17.
//  Copyright © 2017 payneteasy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CardProtocol

@property (nonatomic) NSString *number;
@property (nonatomic) NSString *securityCode;
@property (nonatomic) NSNumber *expiryMonth;
@property (nonatomic) NSNumber *expiryYear;
@property (nonatomic) NSString *cardHolder;

@end
