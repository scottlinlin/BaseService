Pod::Spec.new do |s|

  s.name         = "CPHUD"
  s.version      = "0.0.1"
  s.summary      = "CPHUD"
  s.description  = <<-DESC
                   CPHUD
                   DESC
  s.homepage     = "http://192.168.0.178/svn/InfoCenter/系统/移动应用/CPCocoaPods/CPHUD"
  s.license      = "汇付保密协议"
  s.author             = { "chunying.jia" => "chunying.jia@chinapnr.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :svn => "http://192.168.0.178/svn/InfoCenter/系统/移动应用/CPCocoaPods/CPHUD", :tag => s.version.to_s, :submodules => true }
  s.source_files  = "CPHUD/*.{h,m}"
  s.public_header_files = "CPHUD/*.h"
  s.requires_arc = true
	s.dependency 'MBProgressHUD',   '0.9.1'
end
