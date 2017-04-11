//
//  SourceCardCell.m
//  Transfer
//
//  Created by Sergey Anisiforov on 28/03/17.
//  Copyright © 2017 payneteasy. All rights reserved.
//

#import "SourceCardCell.h"
#import "SHSPhoneLibrary.h"

@interface SourceCardCell ()

@end

@implementation SourceCardCell {
    __weak IBOutlet SHSPhoneTextField *fieldCardNumber;
    __weak IBOutlet SHSPhoneTextField *fieldExpiryMonth;
    __weak IBOutlet SHSPhoneTextField *fieldExpiryYear;
    __weak IBOutlet SHSPhoneTextField *fieldSecurityCode;
    __weak IBOutlet UITextField *fieldCardHolder;
    __weak IBOutlet UITextField *fieldAmount;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [fieldCardNumber.formatter setDefaultOutputPattern:@"#### #### #### ####"];
    [fieldExpiryMonth.formatter setDefaultOutputPattern:@"##"];
    [fieldExpiryYear.formatter setDefaultOutputPattern:@"##"];
    [fieldSecurityCode.formatter setDefaultOutputPattern:@"###"];
}

- (NSString *)number {
    return fieldCardNumber.phoneNumber;
}

- (void)setNumber:(NSString *)number {
    [SHSPhoneLogic applyFormat:fieldCardNumber forText:number];
}

- (NSString *)code {
    return fieldSecurityCode.text;
}

- (void)setCode:(NSString *)code {
    fieldSecurityCode.text = code;
}

- (NSNumber *)expiryMonth {
    return @(fieldExpiryMonth.text.intValue);
}

- (void)setExpiryMonth:(NSNumber *)expiryMonth {
    fieldExpiryMonth.text = expiryMonth.stringValue;
}

- (NSNumber *)expiryYear {
    return @([NSString stringWithFormat:@"20%@", fieldExpiryYear.text].intValue);
}

- (void)setExpiryYear:(NSNumber *)expiryYear {
    fieldExpiryYear.text = expiryYear.stringValue;
}

- (NSString *)cardHolder {
    return fieldCardHolder.text;
}

- (void)setCardHolder:(NSString *)cardHolder {
    fieldCardHolder.text = cardHolder;
}

@end
