Pod::Spec.new do |s|

s.name         = 'MojoAuthSDK'
s.version      = '1.0.0'
s.summary      = 'Official MojoAuth SDK for iOS to integrate User Passwordless Authentication or Social Login in your app.'

s.description  = <<-DESC
MojoAuth is A Complete Passwordless Authentication Solution that simplifies user registration and social login while securing data.

The SDK provides the following

* Passwordless User Registration and Login services.
* Native Social login with facebook, google, apple provides.

DESC

s.homepage     = 'https://github.com/mojoauth/ios-sdk/'
s.license      = 'MIT'
s.authors             = { 'MojoAuth' => 'support@mojoauth.com'}
s.social_media_url   = 'https://twitter.com/MojoAuth'


s.ios.deployment_target = '11.0'
s.static_framework = true

s.source       = { :git => 'https://github.com/mojoauth/ios-sdk.git', :tag => "#{s.version}" }

s.source_files = ['Sources/**/*.{h,m}']

s.dependency 'FBSDKLoginKit', '~> 9.0'

s.ios.frameworks = 'Foundation', 'UIKit', 'SystemConfiguration', 'Social', 'Accounts', 'SafariServices'

end
