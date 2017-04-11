//
//  TestPaynetServer.m
//  PaynetEasyTransfer
//
//  Created by Sergey Anisiforov on 04/04/17.
//  Copyright © 2017 payneteasy. All rights reserved.
//

#import "TestPaynetServer.h"
#import "NSMutableDictionary+Values.h"

@implementation TestPaynetServer {
    NSString *lastStatus;
}

static NSString *paynetServerPath = @"transfer";

- (NSURL *)paynetURL {
    return [self.serverHost URLByAppendingPathComponent:paynetServerPath];
}

- (void)initWebServer:(GCDWebServer *)webServer {
    [webServer removeAllHandlers];

    [webServer addHandlerForMethod:@"POST"
                         pathRegex:[NSString stringWithFormat:@"/%@/(.+)/(.+)", paynetServerPath]
                      requestClass:[GCDWebServerDataRequest class]
                      processBlock:^GCDWebServerResponse *(GCDWebServerRequest* request) {

                          NSDictionary *input = [NSJSONSerialization JSONObjectWithData:[(GCDWebServerDataRequest *)request data]
                                                                                options:kNilOptions error:nil];

                          input = [self addParams:@[@"endpointId", @"invoiceId"] fromRequest:request toDict:input];

                          // request
                          NSLog(@"Input: %@", input);
                          
                          @try {
                              [self testStringValueForPath:@"endpointId" dict:input];
                              [self testStringValueForPath:@"invoiceId" dict:input];
                              
                              [self testStringValueForPath:@"consumer.device.serialNumber" dict:input];
                              
                              [self testStringValueForPath:@"session.accessToken" dict:input];
                              [self testStringValueForPath:@"session.nonce" dict:input];
                              [self testStringValueForPath:@"session.signature" dict:input];
                              
                              [self testIntegerValueForPath:@"transaction.amountCentis" dict:input];
                              [self testStringValueForPath:@"transaction.currency" dict:input];
                              
                              [self testStringValueForPath:@"sourceOfFunds.card.number" dict:input];
                              [self testStringValueForPath:@"sourceOfFunds.card.securityCode" dict:input];
                              [self testIntegerValueForPath:@"sourceOfFunds.card.expiry.month" dict:input];
                              [self testIntegerValueForPath:@"sourceOfFunds.card.expiry.year" dict:input];
                              [self testStringValueForPath:@"sourceOfFunds.card.holder.printedName" dict:input];
                              
                              [self testStringValueForPath:@"destinationOfFunds.card.number" dict:input];
                          } @catch (NSException *exception) {
                              NSLog(@"%@", exception);
                              return nil;
                          }
                          
                          // response
                          NSMutableDictionary *output = [NSMutableDictionary dictionary];
                          [output set_Object:@"11111111-1111-1111-1111-111111111111" forPath:@"session.token"];
                          
                          NSLog(@"Output: %@", output);
                                 
                          return [GCDWebServerDataResponse responseWithJSONObject:output];
                      }];
    
    [webServer addHandlerForMethod:@"POST"
                         pathRegex:[NSString stringWithFormat:@"/%@/(.+)/(.+)/status", paynetServerPath]
                      requestClass:[GCDWebServerDataRequest class]
                      processBlock:^GCDWebServerResponse *(GCDWebServerRequest* request) {
                          
                          NSDictionary *input = [NSJSONSerialization JSONObjectWithData:[(GCDWebServerDataRequest *)request data]
                                                                                options:kNilOptions error:nil];
                          
                          input = [self addParams:@[@"endpointId", @"invoiceId"] fromRequest:request toDict:input];
                          
                          NSArray *urlParams = [request attributeForKey:GCDWebServerRequestAttribute_RegexCaptures];
                          if (urlParams.count == 2) {
                              NSMutableDictionary *dictParams = [NSMutableDictionary dictionaryWithObjects:urlParams
                                                                                                   forKeys:@[@"endpointId", @"invoiceId"]];
                              [dictParams addEntriesFromDictionary:input];
                              input = [dictParams copy];
                          }
                          
                          // request
                          NSLog(@"Input: %@", input);
                          
                          NSString *sessionToken;
                          @try {
                              [self testStringValueForPath:@"endpointId" dict:input];
                              [self testStringValueForPath:@"invoiceId" dict:input];
                              
                              [self testStringValueForPath:@"session.accessToken" dict:input];
                              sessionToken = [self testStringValueForPath:@"session.token" dict:input];
                          } @catch (NSException *exception) {
                              NSLog(@"%@", exception);
                              return nil;
                          }
                          
                          if ([lastStatus isEqualToString:@"PROCESSING"]) {
                              lastStatus = @"APPROVED";
                          } else
                              lastStatus = @"PROCESSING";

                          // response
                          NSMutableDictionary *output = [NSMutableDictionary dictionary];
                          [output set_Object:sessionToken forPath:@"session.token"];
                          [output set_Object:lastStatus forPath:@"state"];
                          [output set_Object:@"10000000-0000-0000-0000-000000000001" forPath:@"bankOrderId"];
                          
                          NSLog(@"Output: %@", output);
                          
                          return [GCDWebServerDataResponse responseWithJSONObject:output];
                      }];
}

- (NSDictionary *)addParams:(NSArray *)names fromRequest:(GCDWebServerRequest *)request toDict:(NSDictionary *)dict {
    NSArray *arrayParams = [request attributeForKey:GCDWebServerRequestAttribute_RegexCaptures];
    if (arrayParams.count == names.count) {
        NSMutableDictionary *dictParams = [NSMutableDictionary dictionaryWithObjects:arrayParams forKeys:names];
        [dictParams addEntriesFromDictionary:dict];
        dict = [dictParams copy];
    }
    return dict;
}

@end
