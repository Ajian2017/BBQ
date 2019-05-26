#
#  Be sure to run `pod spec lint BBQ.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "BBQ"
  s.version      = "0.0.1"
  s.summary      = "simplify the layout of iOS"
  s.description  = <<-DESC
                    Swift
                    iOS
                    layout
                   DESC

  s.homepage     = "https://github.com/Ajian2017/BBQ"
  s.license      = "MIT"
  s.author             = { "qinzj" => "qzjian@gmail.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/Ajian2017/BBQ", :tag => "#{s.version}" }
  s.source_files  = "BBQ/*.swift"
  s.framework  = "UIKit"
  s.requires_arc = true
end
