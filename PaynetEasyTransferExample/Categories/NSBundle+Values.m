//
//  NSBundle+Values.m
//
//  Created by Sergey Anisiforov on 20.07.16.
//  Copyright © 2016 Sergey Anisiforov. All rights reserved.
//

#import "NSBundle+Values.h"

@implementation NSBundle (Resource)

+ (NSString *)readTextFile:(NSString *)filename {
    NSString *path = [[NSBundle mainBundle] pathForResource:filename.stringByDeletingPathExtension ofType:filename.pathExtension];
    if (path) {
        return [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    }
    return nil;
}

+ (NSURL *)URLForResource:(NSString *)filename {
    return [[NSBundle mainBundle] URLForResource:filename.stringByDeletingPathExtension withExtension:filename.pathExtension];
}

@end
