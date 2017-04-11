//
//  WebViewController.h
//
//  Created by Sergey Anisiforov on 01.08.16.
//  Copyright © 2016 Sergey Anisiforov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WebViewController;

@protocol WebViewControllerDelegate
- (void)webControllerDidClose:(WebViewController *)controller;
@end

@interface WebViewController : UIViewController <UIWebViewDelegate>

- (void)loadResourceFile:(NSString *)filename;
- (void)loadAddress:(NSString *)address;
- (void)loadContent:(NSString *)content;

@property (nonatomic, weak) id<WebViewControllerDelegate> delegate;

@end
