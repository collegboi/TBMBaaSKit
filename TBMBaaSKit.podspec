#
# Be sure to run `pod lib lint MBaaSKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html


Pod::Spec.new do |s|
  s.name             = 'TBMBaaSKit'
  s.version          = '0.1.0.15'
  s.summary          = 'TBMBaaSKit is a framework for connecting to TBMBaaSKit Sever.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
This framework provides tools to handle sending and retrieving objects from the MBaaSKit Server
                       DESC

  s.homepage         = 'https://github.com/collegboi/TBMBaaSKit.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'collegboi' => 'timothy.barnard@mydit.ie' }
  s.source           = { :git => 'https://github.com/collegboi/TBMBaaSKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0' 
  s.watchos.deployment_target = '3.0'
  s.tvos.deployment_target = '9.0'
  #s.osx.deployment_target  = '10.10'
  #s.source_files = 'Sources/**/*.{h,swift}'

  s.source_files       = 'Sources/Shared/*.swift'
  s.ios.source_files   = 'Sources/iOS/*.swift'
  s.watchos.source_files   = 'Sources/watchOS/*.swift'
  s.tvos.source_files   = 'Sources/tvOS/*.swift'
  #s.osx.source_files   = 'Sources/osx/*.swift'
  
  #s.framework      = ''

  s.ios.framework  = 'UIKit', 'SystemConfiguration'
  s.watchos.framework = 'WatchKit'
  s.osx.framework  = 'AppKit'

  # s.resource_bundles = {
  #   'MBaaSKit' => ['MBaaSKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
