//
//  TransferController.m
//  PaynetEasyTransfer
//
//  Created by Sergey Anisiforov on 21/03/17.
//  Copyright © 2017 payneteasy. All rights reserved.
//

#import "TransferController.h"
#import "WebViewController.h"
#import "TestPaynetServer.h"
#import "TestMerchantServer.h"

#import "PaynetEasyAPI.h"
#import "MerchantAPI.h"

#import "Transaction.h"
#import "Session.h"
#import "Card.h"
#import "Consumer.h"
#import "Receipt.h"

@interface TransferController () <WebViewControllerDelegate>

@end

@implementation TransferController {
    TestPaynetServer *paynetTestServer;
    TestMerchantServer *merchantTestServer;
    
    PaynetEasyAPI *transferApi;
    MerchantAPI *merchantApi;

    Session *session;
    Consumer *consumer;

    NSString *webContent;
    BOOL stopTransfer;
    
    WebViewController *webViewController;
}

- (void)dealloc {
    [paynetTestServer stop];
    [merchantTestServer stop];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Only for example, use real servers
    paynetTestServer = [[TestPaynetServer alloc] initWithPort:10001];
    [paynetTestServer start];
    merchantTestServer = [[TestMerchantServer alloc] initWithPort:10002];
    [merchantTestServer start];
    
    transferApi = [[PaynetEasyAPI alloc] initWithAddress:paynetTestServer.serverHost.absoluteString];
    merchantApi = [[MerchantAPI alloc] initWithAddress:merchantTestServer.serverHost.absoluteString];

    consumer = [[Consumer alloc] init];
    consumer.deviceNumber = [[UIDevice currentDevice].identifierForVendor UUIDString];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"transfer" ofType:@"html"];
    webContent = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
}

- (void)transferAmount:(double)amount
              currency:(NSString *)currency
              fromCard:(id<CardProtocol>)sourceCard
                toCard:(id<CardProtocol>)destCard {
    
    __block NSString *_redirectUrl;
    stopTransfer = NO;
    
    [self showWebStatus:@"Обработка перевода..." andHide:NO];
    
    // 1. Request access token
    Session *session = [[Session alloc] init];
    [merchantApi requestAccessToken:session completeBlock:^(BOOL result, NSError *error) {
        if (result) {
            Transaction *transaction = [[Transaction alloc] init];
            transaction.amountCentis = @(round(amount * 100));
            transaction.currency = currency;
            
            Receipt *receipt = [[Receipt alloc] init];
            
            // 2. Initiate transfer request
            [merchantApi initiateTransfer:session
                              transaction:transaction
                                 consumer:consumer
                               sourceCard:sourceCard
                                 destCard:destCard
                            completeBlock:^(BOOL result, NSError *error) {
                if (result) {
                    // 3. Transfer money
                    [transferApi tranferMoney:session
                                  transaction:transaction
                                     consumer:consumer
                                   sourceCard:sourceCard
                                     destCard:destCard
                                      receipt:receipt
                                redirectBlock:^(NSString *redirectUrl) {
                                    if (![_redirectUrl isEqualToString:redirectUrl]) {
                                        _redirectUrl = redirectUrl;
                                        [webViewController loadAddress:redirectUrl];
                                    }
                                }
                                continueBlock:^(BOOL *stop) {
                                    *stop = stopTransfer;
                                }
                                completeBlock:^(BOOL result, NSError *error) {
                                    [self showWebStatus:result ? @"Перевод успешно совершен." : @"Перевод отклонен." andHide:YES];
                                }];
                } else
                    [self showWebStatus:@"Ошибка сервиса." andHide:YES];
            }];
        } else {
            [self showWebStatus:@"Ошибка сервиса." andHide:YES];
        }
    }];
}

- (void)showWebStatus:(NSString *)status andHide:(BOOL)hide {
    if (!webViewController) {
        webViewController = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([WebViewController class])];
        webViewController.delegate = self;
        [self.navigationController pushViewController:webViewController animated:NO];
    }
    [webViewController loadContent:[webContent stringByReplacingOccurrencesOfString:@"transfer_status" withString:status]];
    if (hide) {
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2.0 * NSEC_PER_SEC);
        dispatch_after(time, dispatch_get_main_queue(), ^{
            [self hideWebController];
        });
    }
}

- (void)hideWebController {
    [self.navigationController popToViewController:self animated:NO];
    webViewController = nil;
}

#pragma mark - WebViewControllerDelegate

- (void)webControllerDidClose:(WebViewController *)controller {
    stopTransfer = YES;
}

- (IBAction)gestureRecognizerAction:(id)sender {
    [self.view endEditing:YES];
}

#pragma mark - Actions

- (IBAction)buttonSubmitUpInside:(id)sender {
    [[self view] endEditing:YES];
    
    Card *sourceCard = [[Card alloc] init];
    sourceCard.number = self.fieldSourceCardNumber.text;
    sourceCard.securityCode = self.fieldSourceSecurityCode.text;
    sourceCard.expiryMonth = @(self.fieldSourceExpiryMonth.text.intValue);
    sourceCard.expiryYear = @(self.fieldSourceExpiryYear.text.intValue);
    sourceCard.cardHolder = self.fieldSourceCardHolder.text;
    
    Card *destCard = [[Card alloc] init];
    destCard.number = self.fieldDestCardNumber.text;
    
    [self transferAmount:self.fieldAmount.text.doubleValue
                currency:@"RUB"
                fromCard:sourceCard
                  toCard:destCard];
}

@end
