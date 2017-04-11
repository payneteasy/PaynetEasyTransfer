//
//  NSString+Format.m
//  TransferAPI
//
//  Created by Sergey Anisiforov on 31/03/17.
//  Copyright © 2017 payneteasy. All rights reserved.
//

#import "NSString+Format.h"

@implementation NSString (Format)

- (NSString *)cardNumberDigits {
    NSMutableString *result = [NSMutableString string];
    for (NSUInteger i = 0; i < self.length; i++) {
        unichar ch = [self characterAtIndex:i];
        if (isdigit(ch)) {
            [result appendString:[NSString stringWithCharacters:&ch length:1]];
        }
    }
    return result;
}

- (NSString *)cardNumberForDisplay {
    int pos = 0;
    NSMutableString *result = [NSMutableString string];
    for (NSUInteger i = 0; i < self.length; i++) {
        unichar ch = [self characterAtIndex:i];
        if (!isdigit(ch))
            continue;
        if (pos == 4) {
            [result appendString:@" "];
            pos = 0;
        }
        pos++;
        [result appendString:[NSString stringWithCharacters:&ch length:1]];
    }
    return result;
}

@end
