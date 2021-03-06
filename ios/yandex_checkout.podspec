#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint yandex_checkout.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'yandex_checkout'
  s.version          = '0.0.1'
  s.summary          = 'Implementation Yandex Checkout SDK for platforms'
  s.description      = <<-DESC
Implementation Yandex Checkout SDK for platforms
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '8.0'

  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
  s.swift_version = '5.0'
end
