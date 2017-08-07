//
//  BaseTransferAPI.h
//  PaynetEasyTransfer
//
//  Created by Sergey Anisiforov on 04/07/2017.
//
//

#import <Foundation/Foundation.h>

@protocol RestServer <NSObject>
- (NSURL *)baseURL;
- (void)getWithUrl:(NSURL *)url completion:(void(^)(id result, NSError *error))completion;
- (void)postWithUrl:(NSURL *)url body:(NSDictionary *)body completion:(void(^)(id result, NSError *error))completion;
@end


@interface BaseTransferAPI : NSObject <RestServer>

- (instancetype)initWithAddress:(NSString *)address;
- (void)setTimeoutInterval:(NSTimeInterval)interval;

@end
