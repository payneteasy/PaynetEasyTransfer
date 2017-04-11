xcodebuild clean build test \
    -workspace PaynetEasyTransfer.xcworkspace \
    -scheme TransferAPI \
    -sdk iphonesimulator \
    -destination 'platform=iOS Simulator,name=iPhone 6s'
