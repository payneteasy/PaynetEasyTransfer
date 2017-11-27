# PaynetEasyTransfer SDK for iOS

PaynetEasyTransfer SDK provides money transfer between cards Visa/MasterCard in iOS app.

## Setup

Add to your Podfile
```
pod "PaynetEasyTransfer", :git => 'git://github.com/payneteasy/PaynetEasyTransfer.git'
```

## Sample Code

### Import PaynetEasyTransferAPI modules

```obj-c
#import "PaynetEasyAPI.h"
#import "MerchantAPI.h"
```

### Create PaynetEasyAPI instance

```obj-c
PaynetEasyAPI *transferApi = [[PaynetEasyAPI alloc] initWithAddress:kPaynetAddress];
```

### Create MerchantAPI instance

```obj-c
MerchantAPI *merchantApi = [[MerchantAPI alloc] initWithAddress:kMerchantAddress];
```

### Implement models classes
Examples implementation are in a folder Models.
```obj-c
#import "CardProtocol.h"

@interface Card : NSObject <CardProtocol>

@property (nonatomic, strong) NSString *number;
@property (nonatomic, strong) NSString *securityCode;
@property (nonatomic, strong) NSNumber *expiryMonth;
@property (nonatomic, strong) NSNumber *expiryYear;
@property (nonatomic, strong) NSString *cardHolder;

@end
```

### Transfer money

```obj-c
// source card
Card *sourceCard = [[Card alloc] init];
sourceCard.number = @"4444555566661111";
sourceCard.expiryMonth = @1;
sourceCard.expiryYear = @2020;
sourceCard.securityCode = @"111";
sourceCard.cardHolder = @"CARDHOLDER";

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
        transaction.amountCentis = @(round(amount * 100));
        transaction.currency = currency;

        Receipt *receipt = [[Receipt alloc] init];
        
        // initiate transfer request
        [transferApi initiateTransfer:session
                          transaction:transaction
                             consumer:consumer
                           sourceCard:sourceCard
                             destCard:destCard
                        completeBlock:^(BOOL result, NSError *error) {
            if (result) {
                // transfer money
                [transferApi tranferMoney:session
                              transaction:transaction
                                 consumer:consumer
                               sourceCard:sourceCard
                                 destCard:destCard
                                  receipt:receipt
                            redirectBlock:^(NSString *redirectUrl) {
                                // open redirectUrl in webView
                            }
                            continueBlock:^(BOOL *stop) {
                                // set YES if want to break the transaction
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
