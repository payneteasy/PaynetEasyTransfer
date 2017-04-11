//
//  TransferCell.h
//  Transfer
//
//  Created by Sergey Anisiforov on 28/03/17.
//  Copyright © 2017 payneteasy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SubmitCell;

@protocol SubmitCellDelegate
- (void)submitCellDidChange:(SubmitCell *)cell;
- (void)submitCellDidSubmit:(SubmitCell *)cell;
@end

@interface SubmitCell : UITableViewCell

@property (nonatomic) double amount;
@property (nonatomic) double comission;
@property (nonatomic, readonly) double total;
@property (nonatomic, weak) id<SubmitCellDelegate> delegate;

@end
