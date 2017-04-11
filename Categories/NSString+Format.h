//
//  NSString+Format.h
//  TransferAPI
//
//  Created by Sergey Anisiforov on 31/03/17.
//  Copyright © 2017 payneteasy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Format)

- (NSString *)cardNumberDigits;
- (NSString *)cardNumberForDisplay;

@end
