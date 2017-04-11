//
//  NSString+UUID.m
//
//  Created by Sergey Anisiforov on 08.08.16.
//  Copyright © 2016 Sergey Anisiforov. All rights reserved.
//

#import "NSString+UUID.h"

@implementation NSString (UUID)

+ (NSString *)generateUUID {
    CFUUIDRef udid = CFUUIDCreate(NULL);
    return (NSString *)CFBridgingRelease(CFUUIDCreateString(NULL, udid));
}

@end
