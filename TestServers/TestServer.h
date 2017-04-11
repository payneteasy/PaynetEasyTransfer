//
//  TestServer.h
//  PaynetEasyTransfer
//
//  Created by Sergey Anisiforov on 04/04/17.
//  Copyright © 2017 payneteasy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDWebServer.h"
#import "GCDWebServerDataRequest.h"
#import "GCDWebServerDataResponse.h"

@interface TestServer : NSObject

- (instancetype)initWithPort:(NSUInteger)port;

- (void)start;
- (void)stop;

- (NSURL *)serverHost;

- (NSString *)testStringValueForPath:(NSString *)path dict:(NSDictionary *)dict;
- (NSInteger)testIntegerValueForPath:(NSString *)path dict:(NSDictionary *)dict;

@end
