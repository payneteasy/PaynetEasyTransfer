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
#import "UIViewController+Alert.h"
#import "SourceCardCell.h"
#import "DestCardCell.h"
#import "SubmitCell.h"
#import "NSBundle+Values.h"
#import "PaynetEasyTransferAPI.h"
#import "Transaction.h"
#import "Session.h"
#import "Card.h"
#import "Rate.h"
#import "Consumer.h"
#import "Receipt.h"

@interface TransferController () <UITableViewDataSource, UITableViewDelegate, SubmitCellDelegate, WebViewControllerDelegate>

@end

@implementation TransferController {
    TestPaynetServer *paynetTestServer;
    TestMerchantServer *merchantTestServer;
    
    PaynetEasyTransferAPI *transferApi;
    
    Consumer *consumer;
    Rate *rate;
    NSString *webContent;
    BOOL stopTransfer;
    
    SourceCardCell *sourceCardCell;
    DestCardCell *destCardCell;
    SubmitCell *submitCell;
    WebViewController *webViewController;
}

- (void)dealloc {
    [paynetTestServer stop];
    [merchantTestServer stop];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    paynetTestServer = [[TestPaynetServer alloc] initWithPort:10001];
    [paynetTestServer start];
    
    merchantTestServer = [[TestMerchantServer alloc] initWithPort:10002];
    [merchantTestServer start];

    transferApi = [[PaynetEasyTransferAPI alloc] init];
    transferApi.paynetURL = paynetTestServer.paynetURL;
    transferApi.merchantAuthURL = merchantTestServer.merchantAuthURL;
    transferApi.merchantTransferRateURL = merchantTestServer.merchantTransferRateURL;
    transferApi.merchantTransferInitURL = merchantTestServer.merchantTransferInitURL;

    consumer = [[Consumer alloc] init];
    consumer.deviceNumber = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    rate = [[Rate alloc] init];
    [self requestComission];
    
    webContent = [NSBundle readTextFile:@"transfer.html"];
}

- (void)requestComission {
    [transferApi requestTransferRate:rate completeBlock:^(BOOL result, NSError *error) {
        if (result) {
            [self updateTransferAmount];
        }
    }];
}

- (void)transferAmount:(double)amount
              currency:(NSString *)currency
              fromCard:(id<CardProtocol>)sourceCard
                toCard:(id<CardProtocol>)destCard {
    
    __block NSString *_redirectUrl;
    stopTransfer = NO;
    
    [self showWebStatus:@"Обработка перевода..." andHide:NO];
    
    // request access token
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

- (void)updateTransferAmount {
    double amount = submitCell.amount;
    double comission = round(amount * rate.interest.doubleValue / 100);
    if (amount > 0 && rate.rateMin.doubleValue)
        comission = MAX(comission, rate.rateMin.doubleValue);
    if (amount > 0 && rate.rateMax.doubleValue)
        comission = MIN(comission, rate.rateMax.doubleValue);
    
    submitCell.comission = comission;
}

- (void)showWebStatus:(NSString *)status andHide:(BOOL)hide {
    if (!webViewController) {
        webViewController = [[WebViewController alloc] initWithNibName:NSStringFromClass([WebViewController class]) bundle:nil];
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

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier;
    switch (indexPath.row) {
        case 0: {
            cellIdentifier = NSStringFromClass([SourceCardCell class]);
            sourceCardCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            return sourceCardCell;
            break;
        }
        case 1: {
            cellIdentifier = NSStringFromClass([DestCardCell class]);
            destCardCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            return destCardCell;
            break;
        }
        case 2: {
            cellIdentifier = NSStringFromClass([SubmitCell class]);
            submitCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            submitCell.delegate = self;
            return submitCell;
            break;
        }
    }
    return nil;
}

- (BOOL)checkCardNumber:(NSString *)cardNumber {
    return cardNumber.length > 6;
}

#pragma mark - SubmitCellDelegate

- (void)submitCellDidSubmit:(SubmitCell *)cell {
    if (![self checkCardNumber:sourceCardCell.number] || ![self checkCardNumber:destCardCell.number]) {
        [self alertInfoWithTitle:nil
                         message:[NSString stringWithFormat:@"Некорректный номер карты"]
                         handler:nil];
        return;
    }
    if (submitCell.amount < rate.limitMin.doubleValue) {
        [self alertInfoWithTitle:nil
                         message:[NSString stringWithFormat:@"Сумма перевода не может быть меньше %.f", rate.limitMin.doubleValue]
                         handler:^{
                             cell.amount = rate.limitMin.doubleValue;
                             [self updateTransferAmount];
                         }];
        return;
    }
    if (rate.limitMax.doubleValue && cell.amount > rate.limitMax.doubleValue) {
        [self alertInfoWithTitle:nil
                         message:[NSString stringWithFormat:@"Сумма перевода не может быть больше %.f", rate.limitMax.doubleValue]
                         handler:^{
                             cell.amount = rate.limitMax.doubleValue;
                             [self updateTransferAmount];
                         }];
        return;
    }
    
    [[self view] endEditing:YES];
    
    Card *sourceCard = [[Card alloc] init];
    sourceCard.number = sourceCardCell.number;
    sourceCard.securityCode = sourceCardCell.code;
    sourceCard.expiryMonth = sourceCardCell.expiryMonth;
    sourceCard.expiryYear = sourceCardCell.expiryYear;
    sourceCard.cardHolder = sourceCardCell.cardHolder;
    
    Card *destCard = [[Card alloc] init];
    destCard.number = destCardCell.number;
    
    [self transferAmount:cell.amount
                currency:@"RUB"
                fromCard:sourceCard
                  toCard:destCard];
}

- (void)submitCellDidChange:(SubmitCell *)cell {
    [self updateTransferAmount];
}

#pragma mark - WebViewControllerDelegate

- (void)webControllerDidClose:(WebViewController *)controller {
    stopTransfer = YES;
}

- (IBAction)gestureRecognizerAction:(id)sender {
    [self.view endEditing:YES];
}

@end
