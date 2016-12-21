Pod::Spec.new do |s|

  s.name         = "HLNavigationController"
  s.version      = "1.0.0"
  s.summary      = "A Sophisticated NavigationController"

  s.homepage     = "https://github.com/henvyluk/HLNavigationController"

  s.license      = "MIT"

  s.author       = { "henvyluk" => "henvyluk@163.com" }

  s.social_media_url ="http://www.jianshu.com/users/296956170537/latest_articles"

  s.platform     = :ios, "7.0"

  s.source       = { :git => "https://github.com/henvyluk/HLNavigationController.git", :tag => s.version }

  s.source_files  = "HLNavigationController/Classes/*.{h,m}"

  s.resources = "HLNavigationController/Assets/*.{png}"

  s.framework = "UIKit"  

  s.requires_arc = true

end