# PaynetEasyTransfer SDK for iOS

PaynetEasyTransfer SDK provides money transfer between cards Visa/MasterCard in iOS app.

## Setup

Add to your Podfile
```
pod "PaynetEasyTransfer"
```

## Sample Code

### Create ans setup TransferAPI instance

```obj-c
TransferAPI *transferApi = [[TransferAPI alloc] init];
transferApi.paynetURL = paynet_server_url;
transferApi.merchantAuthURL = merchant_auth_server_url;
transferApi.merchantTransferRateURL = merchant_rate_server_url;
transferApi.merchantTransferInitURL = merchant_init_server_url;
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
sourceCard.securityCode = @"123";
sourceCard.cardHolder = @"TEST";

// destination card    
Card *destCard = [[Card alloc] init];
destCard.number = @"5555666644441111";

// consumer info
Consumer *consumer = [[Consumer alloc] init];
consumer.deviceNumber = your_device_number;

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
                                    *stop = YES;
                                }
                                completeBlock:^(BOOL result, NSError *error) {
                                    NSLog(@"TransferApi.transferMoney result: %@.", result ? @"approved" : @"declined");
                                }];
                } else {
                    NSLog(@"TransferApi.initiateTransfer error: %@", error);
                }
            }];
        } else {
            NSLog(@"TransferApi.requestAccessToken error: %@", error);
        }
    }];
}
```