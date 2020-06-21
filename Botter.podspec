#
#  Be sure to run `pod spec lint Botter.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  

  spec.name         = "Botter"
  spec.version      = "1.0.1"
  spec.summary      = "Botter is an integration with Botter Chatbot"

  spec.homepage     = "https://github.com/NoraSayed135/Botter"
  
  spec.license      = "MIT"
  # spec.license      = { :type => "MIT", :file => "FILE_LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the authors of the library, with email addresses. Email addresses
  #  of the authors are extracted from the SCM log. E.g. $ git log. CocoaPods also
  #  accepts just a name if you'd rather not provide an email address.
  #
  #  Specify a social_media_url where others can refer to, for example a twitter
  #  profile URL.
  #

  spec.author             = { "Nora" => "nora.sayed@bluecrunch.com" }
  # Or just: spec.author    = "Nora"
  # spec.authors            = { "Nora" => "nora.sayed@bluecrunch.com" }
  # spec.social_media_url   = "https://twitter.com/Nora"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If this Pod runs only on iOS or OS X, then specify the platform and
  #  the deployment target. You can optionally include the target after the platform.
  #

  
  spec.platform     = :ios, "11.0"
  spec.ios.framework  = 'WebKit' , 'AVKit' , 'AVFoundation'
  spec.dependency 'SoundManager'
  spec.dependency 'LazyImage' 



 #:path => '/Users/bluecrunch/Desktop/Projects/Native/BotterSDK'
#:git => 'https://github.com/NoraSayed135/Botter.git', :tag => spec.version

  spec.source       = { :path => '/Users/bluecrunch/Desktop/Projects/Native/BotterSDK' }

  spec.source_files  = "**/*.{swift,h,m}"
  spec.resource_bundles = {
    'Botter' => ['**/*.{xib,storyboard,xcassets,}']
}
  spec.exclude_files = "Botter/BotterSample/*.{xib,storyboard,xcassets,}"
#['Botter/BotterSample/Base.lproj/Main.storyboard' , 'Botter/BotterSample/Base.lproj/#LaunchScreen.storyboard' , 'Botter/BotterSample/Assets.xcassets']


  spec.swift_version = "4.2" 
  spec.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.2' }


end
