Pod::Spec.new do |s|

  s.name         = "CPAES256"
  s.version      = "0.0.1"
  s.summary      = "CPAES256"
  s.description  = <<-DESC
                   CPAES256
                   DESC
  s.homepage     = "http://192.168.0.178/svn/InfoCenter/系统/移动应用/CPCocoaPods/CPAES256"
  s.license      = "汇付保密协议"
  s.author             = { "chunying.jia" => "chunying.jia@chinapnr.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :svn => "http://192.168.0.178/svn/InfoCenter/系统/移动应用/CPCocoaPods/CPAES256", :tag => s.version.to_s, :submodules => true }
  s.source_files  = "CPAES256/*.{h,m}"
  s.public_header_files = "CPAES256/*.h"
  s.requires_arc = true

end