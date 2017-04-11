//
//  LocalMerchantServer.m
//  PaynetEasyTransfer
//
//  Created by Sergey Anisiforov on 05/04/17.
//  Copyright © 2017 payneteasy. All rights reserved.
//

#import "TestMerchantServer.h"
#import "NSDictionary+Values.h"
#import "NSMutableDictionary+Values.h"

@implementation TestMerchantServer {

}

static NSString *merchantAuthPath = @"auth/request-access-token";
static NSString *merchantTransferRatePath = @"transfer/get-rate";
static NSString *merchantTransferInitPath = @"transfer/initiate-transfer";

- (NSURL *)merchantAuthURL {
    return [self.serverHost URLByAppendingPathComponent:merchantAuthPath];
}

- (NSURL *)merchantTransferRateURL {
    return [self.serverHost URLByAppendingPathComponent:merchantTransferRatePath];
}

- (NSURL *)merchantTransferInitURL {
    return [self.serverHost URLByAppendingPathComponent:merchantTransferInitPath];
}

- (void)initWebServer:(GCDWebServer *)webServer {
    [webServer removeAllHandlers];

    [webServer addHandlerForMethod:@"GET"
                              path:[NSString stringWithFormat:@"/%@", merchantAuthPath]
                      requestClass:[GCDWebServerDataRequest class]
                      processBlock:^GCDWebServerResponse *(GCDWebServerRequest* request) {
                          
                          // response
                          NSMutableDictionary *output = [NSMutableDictionary dictionary];
                          [output set_Object:@"11111111-1111-1111-1111-111111111111" forPath:@"session.accessToken"];
                          
                          NSLog(@"Output: %@", output);
                          
                          return [GCDWebServerDataResponse responseWithJSONObject:output];
                      }];

    [webServer addHandlerForMethod:@"POST"
                              path:[NSString stringWithFormat:@"/%@", merchantTransferRatePath]
                      requestClass:[GCDWebServerDataRequest class]
                      processBlock:^GCDWebServerResponse *(GCDWebServerRequest* request) {
                          
                          // response
                          NSMutableDictionary *output = [NSMutableDictionary dictionary];
                          [output set_Object:@1.5 forPath:@"rateInterest"];
                          [output set_Object:@35 forPath:@"rateMin"];
                          [output set_Object:@50 forPath:@"limitMin"];
                          [output set_Object:@75000 forPath:@"limitMax"];
                          
                          NSLog(@"Output: %@", output);
                          
                          return [GCDWebServerDataResponse responseWithJSONObject:output];
                      }];
    
    [webServer addHandlerForMethod:@"POST"
                              path:[NSString stringWithFormat:@"/%@", merchantTransferInitPath]
                      requestClass:[GCDWebServerDataRequest class]
                      processBlock:^GCDWebServerResponse *(GCDWebServerRequest* request) {
                          
                          NSDictionary *input = [NSJSONSerialization JSONObjectWithData:[(GCDWebServerDataRequest *)request data]
                                                                                options:kNilOptions error:nil];
                          
                          // request
                          NSLog(@"Input: %@", input);
                          
                          @try {
                              [self testStringValueForPath:@"consumer.device.serialNumber" dict:input];
                              [self testStringValueForPath:@"session.accessToken" dict:input];
                              [self testStringValueForPath:@"transaction.fromBin" dict:input];
                              [self testStringValueForPath:@"transaction.toBin" dict:input];
                              [self testIntegerValueForPath:@"transaction.amountCentis" dict:input];
                              [self testStringValueForPath:@"transaction.currency" dict:input];
                          } @catch (NSException *exception) {
                              NSLog(@"%@", exception);
                              return nil;
                          }

                          // signature
                          NSString *endpointId = @"1111";
                          NSString *sessionNonce = @"22222222-2222-2222-2222-222222222222";
                          NSString *invoiceId = @"33333333-3333-3333-3333-333333333333";
                          NSString *signature = @"1234567890987654321";
                          
                          NSMutableDictionary *output = [NSMutableDictionary dictionary];
                          [output set_Object:endpointId forPath:@"endpointId"];
                          [output set_Object:invoiceId forPath:@"invoiceId"];
                          [output set_Object:@50 forPath:@"rates.min"];
                          [output set_Object:@1500 forPath:@"rates.max"];
                          [output set_Object:sessionNonce forPath:@"session.nonce"];
                          [output set_Object:signature forPath:@"session.signature"];
                          
                          NSLog(@"Output: %@", output);

                          return [GCDWebServerDataResponse responseWithJSONObject:output];
                      }];
}

@end
