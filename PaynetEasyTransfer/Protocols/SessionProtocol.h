//
//  SessionProtocol.h
//  PaynetEasyTransfer
//
//  Created by Sergey Anisiforov on 23/03/17.
//  Copyright © 2017 payneteasy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SessionProtocol

@property (nonatomic) NSString *accessToken;
@property (nonatomic) NSString *token;
@property (nonatomic) NSString *nonce;
@property (nonatomic) NSString *signature;

@end

