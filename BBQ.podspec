Pod::Spec.new do |s|
  s.name         = "BBQ"
  s.version      = "0.3.3"
  s.summary      = "simplify the develop of iOS"
  s.description  = <<-DESC
                    Swift
                    iOS
                    layout
                   DESC

  s.homepage     = "https://github.com/Ajian2017/BBQ"
  s.license      = "MIT"
  s.author             = { "qinzj" => "qzjian@gmail.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/Ajian2017/BBQ.git", :tag => "#{s.version}" }
  s.swift_version = "4.2"
  s.source_files  = "BBQ/**/*.swift"
  s.framework  = "UIKit"
  s.requires_arc = true
end
