#
# Be sure to run `pod lib lint DDQKit_swift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DDQKit_swift'
  s.version          = '0.1.0'
  s.summary          = 'DDQKit swift version.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Swift coding repository
                       DESC

  s.homepage         = 'https://github.com/MyNameDDQ/DDQKit_swift'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'MyNameDDQ' => 'ddq107038@163.com' }
  s.source           = { :git => 'https://github.com/MyNameDDQ/DDQKit_swift.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.swift_version = '4.2'

  s.source_files = 'DDQKit_swift/Classes/**/*'
  
  # s.resource_bundles = {
  #   'DDQKit_swift' => ['DDQKit_swift/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'SwiftyJSON'
  s.dependency 'HandyJSON'
  s.dependency 'IQKeyboardManagerSwift'
  s.dependency 'SwiftLint'
  s.dependency 'YYKit'
  s.dependency 'MBProgressHUD'
  s.dependency 'SAMKeychain'
  s.dependency 'SDWebImage'
  s.dependency 'MJRefresh'
  s.dependency 'AFNetworking'
  s.dependency 'FDFullscreenPopGesture'
  s.dependency 'SnapKit'
end
