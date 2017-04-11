//
//  Session.h
//  PaynetEasyTransfer
//
//  Created by Sergey Anisiforov on 23/03/17.
//  Copyright © 2017 payneteasy. All rights reserved.
//

#import "SessionProtocol.h"

@interface Session : NSObject <SessionProtocol>

@property (nonatomic, strong) NSString *accessToken;
@property (nonatomic, strong) NSString *nonce;
@property (nonatomic, strong) NSString *signature;

@end

