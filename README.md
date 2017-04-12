# PaynetEasyTransfer SDK for iOS

PaynetEasyTransfer SDK provides money transfer between cards Visa/MasterCard in iOS app.

## Setup

Add to your Podfile
```
pod "PaynetEasyTransfer", :git => 'git://github.com/payneteasy/PaynetEasyTransfer.git'
```

## Sample Code

### Import PaynetEasyTransferAPI module

```obj-c
#import "PaynetEasyTransferAPI.h"
```

### Create and setup PaynetEasyTransferAPI instance

```obj-c
PaynetEasyTransferAPI *transferApi = [[PaynetEasyTransferAPI alloc] init];
transferApi.paynetURL = [NSURL URLWithString:kPaynetAddress];
transferApi.merchantAuthURL = [NSURL URLWithString:kMerchantAuthAddress];
transferApi.merchantTransferRateURL = [NSURL URLWithString:kMerchantTransferRateAddress];
transferApi.merchantTransferInitURL = [NSURL URLWithString:kMerchantTransferInitAddress];
```

### Implement models classes
Examples implementation are in a folder Models.
```obj-c
@interface Card : NSObject <CardProtocol>

@property (nonatomic, strong) NSString *number;
@property (nonatomic, strong) NSString *securityCode;
@property (nonatomic, strong) NSNumber *expiryMonth;
@property (nonatomic, strong) NSNumber *expiryYear;
@property (nonatomic, strong) NSString *cardHolder;

@end
```

### Get transfer rate (optional)

```obj-c
Rate *rate = [[Rate alloc] init];
[transferApi requestTransferRate:rate completeBlock:^(BOOL result, NSError *error) {
    if (result) {
        // calc and show comission in UI
    }
}];
```

### Transfer money

```obj-c
// source card
Card *sourceCard = [[Card alloc] init];
sourceCard.number = @"4444555566661111";
sourceCard.expiryMonth = @1;
sourceCard.expiryYear = @2020;
sourceCard.securityCode = @"111";
sourceCard.cardHolder = @"TEST";

// destination card
Card *destCard = [[Card alloc] init];
destCard.number = @"5555666644441111";

// consumer info
Consumer *consumer = [[Consumer alloc] init];
consumer.deviceNumber = @"consumer_mobile_device_number";

double amount = 200.0;
NSString *currency = @"RUB";

// get accessToken from Merchant Auth Server
Session *session = [[Session alloc] init];
[transferApi requestAccessToken:session completeBlock:^(BOOL result, NSError *error) {
    if (result) {
        // set transaction info
        Transaction *transaction = [[Transaction alloc] init];
        transaction.fromBin = [sourceCard.number substringToIndex:6];
        transaction.toBin = [destCard.number substringToIndex:6];
        transaction.amountCentis = @(round(amount * 100));
        transaction.currency = currency;
        
        // initiate transfer request
        [transferApi initiateTransfer:session transaction:transaction consumer:consumer completeBlock:^(BOOL result, NSError *error) {
            if (result) {
                // transfer money
                [transferApi tranferMoney:transaction
                                  session:session
                               sourceCard:sourceCard
                                 destCard:destCard
                                 consumer:consumer
                            redirectBlock:^(NSString *redirectUrl) {
                                // open redirectUrl in webView
                            }
                            continueBlock:^(BOOL *stop) {
                                // set YES if you'd like to break the transaction
                                // *stop = YES;
                            }
                            completeBlock:^(BOOL result, NSError *error) {
                                NSLog(@"PaynetEasyTransferAPI.transferMoney result: %@.", result ? @"approved" : @"declined");
                            }];
            } else {
                NSLog(@"PaynetEasyTransferAPI.initiateTransfer error: %@", error);
            }
        }];
    } else {
        NSLog(@"PaynetEasyTransferAPI.requestAccessToken error: %@", error);
    }
}];
```