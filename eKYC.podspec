Pod::Spec.new do |spec|
  spec.name    = 'eKYC'
  spec.version = '1.0.0'
  spec.license = {
      :type => 'commercial',
      :text => <<-LICENSE
               © 2016-2021 NiliN Ltd. All rights reserved.
              LICENSE
  }
  spec.homepage      = 'https://nilin.co'
  spec.authors       = {
     'NiliN' => 'info@nilin.co',
     'Mahdi Mahjoobi' => 'mahdi.m@email.com'
  }
  spec.summary       = 'SDK for card scanning and liveness detection. Contains native iOS SDK, code samples and documentation.'
  spec.source        = { :git => 'https://github.com/nilinco/eKYC-iOS.git', :tag => 'v1.0.0' }
  spec.module_name   = 'eKYC'
  spec.swift_version = '5.0'
  spec.platform      = :ios
  spec.ios.deployment_target  = '12.0'

  spec.ios.framework  = 'UIKit'
  spec.ios.vendored_frameworks = 'eKYC.xcframework'
end
