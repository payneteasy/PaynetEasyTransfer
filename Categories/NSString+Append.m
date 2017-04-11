//
//  NSString+Append.m
//  TransferAPI
//
//  Created by Sergey Anisiforov on 28/03/17.
//  Copyright © 2017 payneteasy. All rights reserved.
//

#import "NSString+Append.h"

@implementation NSString (Append)

- (NSString *)appendNonEmptyString:(NSString *)string {
    if (string.length)
        return [self stringByAppendingString:string];
    return self;
}

@end
