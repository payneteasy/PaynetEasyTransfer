//
//  NSBundle+Values.h
//
//  Created by Sergey Anisiforov on 20.07.16.
//  Copyright © 2016 Sergey Anisiforov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBundle (Values)

+ (NSString *)readTextFile:(NSString *)filename;
+ (NSURL *)URLForResource:(NSString *)filename;

@end
