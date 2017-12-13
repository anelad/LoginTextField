#
# Be sure to run `pod lib lint LoginTextField.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LoginTextField'
  s.version          = '1.0.3'
  s.summary          = 'A tiny UITextField subclass to use in login / registration forms.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
LogintextField is a tiny subclas of UITextField. It's designed to fulfill almost any needs of a small forms like login or registration. 
                       DESC

  s.homepage         = 'https://github.com/anelad/LoginTextField'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Arda Oğul Üçpınar' => 'info@ardaucpinar.com' }
  s.source           = { :git => 'https://github.com/anelad/LoginTextField.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'LoginTextField/Classes/**/*'
  
  s.resource_bundles = {
    'LoginTextField' => ['LoginTextField/Assets/**/*.xcassets']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
