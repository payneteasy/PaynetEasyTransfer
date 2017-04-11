//
//  TestServer.m
//  PaynetEasyTransfer
//
//  Created by Sergey Anisiforov on 04/04/17.
//  Copyright © 2017 payneteasy. All rights reserved.
//

#import "TestServer.h"
#import "NSDictionary+Values.h"

@interface TestServer ()

@property (nonatomic, strong) GCDWebServer *webServer;

@end

@implementation TestServer {
    NSUInteger _port;
}

- (instancetype)initWithPort:(NSUInteger)port {
    self = [super init];
    if (self) {
        _webServer = [[GCDWebServer alloc] init];
        _port = port;
        [self initWebServer:_webServer];
    }
    return self;
}

- (NSURL *)serverHost {
    return _webServer.serverURL;
}

- (void)initWebServer:(GCDWebServer *)webServer {
}

- (void)start {
    [_webServer startWithPort:_port bonjourName:nil];
}

- (void)stop {
    [_webServer stop];
}

- (NSString *)testStringValueForPath:(NSString *)path dict:(NSDictionary *)dict {
    NSString *fieldValue = [dict get_StringForPath:path];
    [self testIsTrue:(fieldValue.length>0) fieldName:path];
    return fieldValue;
}

- (NSInteger)testIntegerValueForPath:(NSString *)path dict:(NSDictionary *)dict {
    NSInteger fieldValue = [dict get_IntegerForPath:path];
    [self testIsTrue:(fieldValue>0) fieldName:path];
    return fieldValue;
}

- (void)testIsTrue:(BOOL)value fieldName:(NSString *)fieldName {
    if (!value)
        [NSException raise:@"INVALID_REQUEST" format:@"%@ may not be empty", fieldName];
}

@end
