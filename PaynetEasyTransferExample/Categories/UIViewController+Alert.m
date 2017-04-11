//
//  UIViewController+Alert.m
//
//  Created by Sergey Anisiforov on 15.11.16.
//  Copyright © 2016 Sergey Anisiforov. All rights reserved.
//

#import "UIViewController+Alert.h"

@implementation UIViewController (Alert)

- (void)alertInfoWithTitle:(NSString *)title message:(NSString *)message handler:(void(^)())handler {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action) {
                                                         if (handler)
                                                             handler();
                                                     }];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)alertConfirmWithTitle:(NSString *)title
                      message:(NSString *)message
               confirmCaption:(NSString *)confirmCaption
                cancelCaption:(NSString *)cancelCaption
                      handler:(void(^)())handler {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:confirmCaption
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {
                                                              if (handler)
                                                                  handler();
                                                          }];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelCaption
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    [alertController addAction:confirmAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)alertInputTextWithTitle:(NSString *)title
                        message:(NSString *)message
                 confirmCaption:(NSString *)confirmCaption
                  cancelCaption:(NSString *)cancelCaption
                    placeholder:(NSString *)placeholder
                        handler:(void(^)(NSString *result))handler {
    
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:title
                                          message:message
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = placeholder;
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelCaption
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    UIAlertAction *doneAction = [UIAlertAction actionWithTitle:confirmCaption
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action) {
                                                           UITextField *confirmCode = alertController.textFields.firstObject;
                                                           if (handler)
                                                               handler(confirmCode.text);
                                                       }];
    [alertController addAction:cancelAction];
    [alertController addAction:doneAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)alertInputIntWithTitle:(NSString *)title
                       message:(NSString *)message
                confirmCaption:(NSString *)confirmCaption
                 cancelCaption:(NSString *)cancelCaption
                   placeholder:(NSString *)placeholder
                       handler:(void(^)(NSInteger result))handler {
    
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:title
                                          message:message
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = placeholder;
        textField.keyboardType = UIKeyboardTypeDecimalPad;
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelCaption
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    UIAlertAction *doneAction = [UIAlertAction actionWithTitle:confirmCaption
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action) {
                                                           UITextField *confirmCode = alertController.textFields.firstObject;
                                                           if (handler)
                                                               handler([confirmCode.text integerValue]);
                                                       }];
    [alertController addAction:cancelAction];
    [alertController addAction:doneAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
