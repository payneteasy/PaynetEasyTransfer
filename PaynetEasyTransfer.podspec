Pod::Spec.new do |s|
  s.name                  = 'PaynetEasyTransfer'
  s.version               = '0.0.1'
  s.summary               = 'PaynetEasyTransfer is API for provides money transfer between payment cards in iOS apps.'
  s.license               = { :type => 'APACHE', :file => 'LICENSE' }
  s.homepage              = 'https://www.payneteasy.com'
  s.authors               = { 'Sergey Anisiforov' => 'sa@payneteasy.com' }
  s.source                = { :git => 'https://github.com/payneteasy/PaynetEasyTransfer.git', :tag => s.version.to_s }
  s.frameworks            = 'Foundation'
  s.requires_arc          = true
  s.platform              = :ios
  s.ios.deployment_target = '8.0'
  s.public_header_files   = 'PaynetEasyTransfer/TransferAPI/*.h'
  s.source_files          = 'PaynetEasyTransfer/TransferAPI/*.{h,m}'
  s.subspec 'Protocols' do |ss|
    ss.public_header_files = 'PaynetEasyTransfer/Protocols/*.h'
    ss.source_files = 'PaynetEasyTransfer/Protocols/*.{h,m}'
  end
  s.subspec 'Categories' do |ss|
    ss.public_header_files = 'PaynetEasyTransfer/Categories/*.h'
    ss.source_files = 'PaynetEasyTransfer/Categories/*.{h,m}'
  end
end
