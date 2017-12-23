Pod::Spec.new do |s|
  s.name             = 'LoginTextField'
  s.version          = '1.1.0'
  s.summary          = 'A tiny UITextField subclass to use in login / registration forms.'

  s.description      = <<-DESC
LogintextField is a tiny subclas of UITextField. It's designed to fulfill almost any needs of a small forms like login or registration. 
                       DESC

  s.homepage         = 'https://github.com/anelad/LoginTextField'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Arda Oğul Üçpınar' => 'info@ardaucpinar.com' }
  s.source           = { :git => 'https://github.com/anelad/LoginTextField.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/ArdaUcpinar'

  s.ios.deployment_target = '10.0'
  s.platform = :ios, '10.0'

  s.source_files = 'LoginTextField/Classes/**/*'
  
  s.resources = ['LoginTextField/Assets/**/*.xcassets']
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.0' }
  s.test_spec 'Test' do |test_spec|
    test_spec.source_files = ['LoginTextField/Tests/**/*', 'LoginTextField/Classes/**/*']
    test_spec.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.0' }
  end
end
