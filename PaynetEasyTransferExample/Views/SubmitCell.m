//
//  SubmitCell.m
//  Transfer
//
//  Created by Sergey Anisiforov on 28/03/17.
//  Copyright © 2017 payneteasy. All rights reserved.
//

#import "SubmitCell.h"

@interface SubmitCell ()

@end

@implementation SubmitCell {
    __weak IBOutlet UITextField *fieldAmount;
    __weak IBOutlet UITextField *fieldComission;
    __weak IBOutlet UITextField *fieldTotal;
}

- (double)amount {
    return fieldAmount.text.doubleValue;
}

- (void)setAmount:(double)amount {
    fieldAmount.text = (amount > 0) ? @(amount).stringValue : nil;
}

- (double)comission {
    return fieldComission.text.doubleValue;
}

- (void)setComission:(double)comission {
    fieldComission.text = (comission > 0) ? @(comission).stringValue : nil;
    fieldTotal.text = (comission > 0) ? @(self.amount + self.comission).stringValue : fieldAmount.text;
}

- (double)total {
    return fieldTotal.text.doubleValue;
}

#pragma mark - Actions

- (IBAction)fieldAmountDidChange:(UITextField *)sender {
    [_delegate submitCellDidChange:self];
}

- (IBAction)buttonSubmitUpInside:(id)sender {
    [_delegate submitCellDidSubmit:self];
}

@end
