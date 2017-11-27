//
//  TransferController.h
//  PaynetEasyTransfer
//
//  Created by Sergey Anisiforov on 21/03/17.
//  Copyright © 2017 payneteasy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransferController : UIViewController

@property (nonatomic, weak) IBOutlet UITextField *fieldSourceCardNumber;
@property (nonatomic, weak) IBOutlet UITextField *fieldSourceExpiryMonth;
@property (nonatomic, weak) IBOutlet UITextField *fieldSourceExpiryYear;
@property (nonatomic, weak) IBOutlet UITextField *fieldSourceSecurityCode;
@property (nonatomic, weak) IBOutlet UITextField *fieldSourceCardHolder;
@property (nonatomic, weak) IBOutlet UITextField *fieldDestCardNumber;
@property (nonatomic, weak) IBOutlet UITextField *fieldAmount;

@end

