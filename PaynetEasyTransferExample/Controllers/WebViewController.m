//
//  WebViewController.m
//
//  Created by Sergey Anisiforov on 01.08.16.
//  Copyright © 2016 Sergey Anisiforov. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController () {
    BOOL inProgress;
    __weak IBOutlet UIWebView *webView;
}

@end

@implementation WebViewController {
    NSString *_content;
    NSURL *_url;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Отмена"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(onBackAction)];
    webView.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateWebContent];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self doHideProgress];
}

- (void)loadResourceFile:(NSString *)filename {
    _url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:filename.stringByDeletingPathExtension ofType:filename.pathExtension]];
    [self updateWebContent];
}

- (void)loadAddress:(NSString *)address {
    _url = [NSURL URLWithString:address];
    [self updateWebContent];
}

- (void)loadContent:(NSString *)content {
    _content = content;
    [self updateWebContent];
}

- (void)updateWebContent {
    if (webView) {
        if (_content) {
            [self doShowProgress];
            [webView loadHTMLString:_content baseURL:nil];
            _content = nil;
        } else if (_url) {
            [self doShowProgress];
            [webView loadRequest:[NSURLRequest requestWithURL:_url]];
            _url = nil;
        }
    }
}

- (void)doShowProgress {
    if (!inProgress) {
        inProgress = YES;
    }
}

- (void)doHideProgress {
    if (inProgress) {
        inProgress = NO;
    }
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self doHideProgress];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self doHideProgress];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

#pragma mark - Actions

- (void)onBackAction {
    [_delegate webControllerDidClose:self];
}

@end
