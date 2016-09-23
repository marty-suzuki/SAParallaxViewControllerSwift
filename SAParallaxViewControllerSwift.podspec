#
# Be sure to run `pod lib lint SAParallaxViewControllerSwift.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "SAParallaxViewControllerSwift"
  s.version          = "2.0.0"
  s.summary          = "SAParallaxViewControllerSwift realizes parallax scrolling with blur effect. In addition, it realizes seamless opening transition."
  s.homepage         = "https://github.com/marty-suzuki/SAParallaxViewControllerSwift"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Taiki Suzuki" => "s1180183@gmail.com" }
  s.source           = { :git => "https://github.com/marty-suzuki/SAParallaxViewControllerSwift.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/marty_suzuki'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'SAParallaxViewControllerSwift/*.{swift}'
  # s.resource_bundles = {
  #   'SAParallaxViewControllerSwift' => ['Pod/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'SABlurImageView'
  s.dependency 'MisterFusion'
end
