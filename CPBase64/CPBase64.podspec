Pod::Spec.new do |s|

  s.name         = "CPBase64"
  s.version      = "0.0.1"
  s.summary      = "Base64"
  s.description  = <<-DESC
                   Base64
                   DESC
  s.homepage     = "http://192.168.0.178/svn/InfoCenter/系统/移动应用/CPCocoaPods/CPBase64"
  s.license      = "汇付保密协议"
  s.author             = { "chunying.jia" => "chunying.jia@chinapnr.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :svn => "http://192.168.0.178/svn/InfoCenter/系统/移动应用/CPCocoaPods/CPBase64", :tag => s.version.to_s, :submodules => true }
  s.source_files  = "CPBase64/*.{h,m}"
  s.public_header_files = "CPBase64/*.h"
  s.requires_arc = true

end
