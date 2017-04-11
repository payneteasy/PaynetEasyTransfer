//
//  Consumer.h
//  PaynetEasyTransfer
//
//  Created by Sergey Anisiforov on 23/03/17.
//  Copyright © 2017 payneteasy. All rights reserved.
//

#import "ConsumerProtocol.h"

@interface Consumer : NSObject <ConsumerProtocol>

@property (nonatomic, strong) NSString *deviceNumber;

@end
