//
//  SourceCardCell.h
//  Transfer
//
//  Created by Sergey Anisiforov on 28/03/17.
//  Copyright © 2017 payneteasy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"

@interface SourceCardCell : UITableViewCell

@property (nonatomic) NSString *number;
@property (nonatomic) NSString *code;
@property (nonatomic) NSNumber *expiryMonth;
@property (nonatomic) NSNumber *expiryYear;
@property (nonatomic) NSString *cardHolder;

@end
