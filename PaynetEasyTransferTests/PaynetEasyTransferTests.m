//
//  PaynetEasyTransferTests.m
//  PaynetEasyTransfer
//
//  Created by Sergey Anisiforov on 04/04/17.
//  Copyright © 2017 payneteasy. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PaynetEasyTransferAPI.h"
#import "TestPaynetServer.h"
#import "TestMerchantServer.h"
#import "Consumer.h"
#import "Card.h"
#import "Session.h"
#import "Transaction.h"
#import "Receipt.h"

@interface PaynetEasyTransferTests : XCTestCase

@end

@implementation PaynetEasyTransferTests {
    TestPaynetServer *paynetTestServer;
    TestMerchantServer *merchantTestServer;
    PaynetEasyTransferAPI *transferApi;
}

- (void)setUp {
    [super setUp];
    
    paynetTestServer = [[TestPaynetServer alloc] initWithPort:20001];
    [paynetTestServer start];
    
    merchantTestServer = [[TestMerchantServer alloc] initWithPort:20002];
    [merchantTestServer start];
    
    transferApi = [[PaynetEasyTransferAPI alloc] init];
    transferApi.paynetURL = paynetTestServer.paynetURL;
    transferApi.merchantAuthURL = merchantTestServer.merchantAuthURL;
    transferApi.merchantTransferRateURL = merchantTestServer.merchantTransferRateURL;
    transferApi.merchantTransferInitURL = merchantTestServer.merchantTransferInitURL;
    [transferApi setTimeoutInterval:10];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testTransfer {
    Card *sourceCard = [[Card alloc] init];
    sourceCard.number = @"4444555566661111";
    sourceCard.expiryMonth = @1;
    sourceCard.expiryYear = @2020;
    sourceCard.securityCode = @"123";
    sourceCard.cardHolder = @"TEST";
    
    Card *destCard = [[Card alloc] init];
    destCard.number = @"5555666644441111";
    
    double amount = 100;
    NSString *currency = @"RUB";
    
    Consumer *consumer = [[Consumer alloc] init];
    consumer.deviceNumber = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Transfer"];
    
    Session *session = [[Session alloc] init];
    [transferApi requestAccessToken:session completeBlock:^(BOOL result, NSError *error) {
        if (result) {
            Transaction *transaction = [[Transaction alloc] init];
            transaction.amountCentis = @(round(amount * 100));
            transaction.currency = currency;
            
            Receipt *receipt = [[Receipt alloc] init];
            
            // initiate transfer request
            [transferApi initiateTransfer:session
                              transaction:transaction
                                 consumer:consumer
                               sourceCard:sourceCard
                                 destCard:destCard
                            completeBlock:^(BOOL result, NSError *error) {
                if (result) {
                    // transfer money
                    [transferApi tranferMoney:session
                                  transaction:transaction
                                     consumer:consumer
                                   sourceCard:sourceCard
                                     destCard:destCard
                                      receipt:receipt
                                redirectBlock:nil
                                continueBlock:nil
                                completeBlock:^(BOOL result, NSError *error) {
                                    NSLog(@"PaynetEasyTransferAPI.transferMoney result: %@.", result ? @"approved" : @"declined");
                                    XCTAssert(result && receipt.status == ReceiptStatusApproved);
                                    [expectation fulfill];
                                }];
                } else {
                    NSLog(@"PaynetEasyTransferAPI.initiateTransfer error: %@", error);
                    XCTAssert(NO);
                }
            }];
        } else {
            NSLog(@"PaynetEasyTransferAPI.requestAccessToken error: %@", error);
            XCTAssert(NO);
        }
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"PaynetEasyTransferAPI.tranferMoney timeout Error: %@", error);
        }
    }];
}

@end
