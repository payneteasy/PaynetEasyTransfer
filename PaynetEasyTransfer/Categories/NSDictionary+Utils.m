//
//  NSDictionary+Utils.m
//  PaynetEasyTransfer
//
//  Created by Sergey Anisiforov on 27/03/17.
//  Copyright © 2017 payneteasy. All rights reserved.
//

#import "NSDictionary+Utils.h"

@implementation NSDictionary (Utils)

- (NSDictionary *)clearEmptyChilds {
    NSMutableDictionary *clearedDict = [NSMutableDictionary dictionary];
    NSArray *allKeys = self.allKeys;
    for (NSString *key in allKeys) {
        id value = [self valueForKey:key];
        if ([value isKindOfClass:[NSDictionary class]]) {
            NSDictionary *clearedValue = [value clearEmptyChilds];
            if (clearedValue.count)
                [clearedDict setObject:clearedValue forKey:key];
        } else {
            [clearedDict setObject:value forKey:key];
        }
    }
    return [clearedDict copy];
}

@end
