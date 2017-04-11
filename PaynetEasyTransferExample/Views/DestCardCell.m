//
//  DestCardCell.m
//  Transfer
//
//  Created by Sergey Anisiforov on 28/03/17.
//  Copyright © 2017 payneteasy. All rights reserved.
//

#import "DestCardCell.h"
#import "SHSPhoneLibrary.h"

@implementation DestCardCell {
    __weak IBOutlet SHSPhoneTextField *fieldCardNumber;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [fieldCardNumber.formatter setDefaultOutputPattern:@"#### #### #### ####"];
}

- (NSString *)number {
    return fieldCardNumber.phoneNumber;
}

- (void)setNumber:(NSString *)number {
    [SHSPhoneLogic applyFormat:fieldCardNumber forText:number];
}

@end
