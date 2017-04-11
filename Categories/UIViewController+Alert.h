//
//  UIViewController+Alert.h
//
//  Created by Sergey Anisiforov on 15.11.16.
//  Copyright © 2016 Sergey Anisiforov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Alert)

- (void)alertInfoWithTitle:(NSString *)title
                   message:(NSString *)message
                   handler:(void(^)())handler;

- (void)alertConfirmWithTitle:(NSString *)title
                      message:(NSString *)message
               confirmCaption:(NSString *)confirmCaption
                cancelCaption:(NSString *)cancelCaption
                      handler:(void(^)())handler;

- (void)alertInputTextWithTitle:(NSString *)title
                        message:(NSString *)message
                 confirmCaption:(NSString *)confirmCaption
                  cancelCaption:(NSString *)cancelCaption
                    placeholder:(NSString *)placeholder
                        handler:(void(^)(NSString *result))handler;

- (void)alertInputIntWithTitle:(NSString *)title
                       message:(NSString *)message
                confirmCaption:(NSString *)confirmCaption
                 cancelCaption:(NSString *)cancelCaption
                   placeholder:(NSString *)placeholder
                       handler:(void(^)(NSInteger result))handler;


@end
