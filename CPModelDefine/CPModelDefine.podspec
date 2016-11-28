Pod::Spec.new do |s|

  s.name         = "CPModelDefine"
  s.version      = "0.0.1"
  s.summary      = "CPModelDefine"
  s.description  = <<-DESC
                   CPModelDefine
                   DESC
  s.homepage     = "http://192.168.0.178/svn/InfoCenter/系统/移动应用/CPCocoaPods/CPModelDefine"
  s.license      = "汇付保密协议"
  s.author             = { "chunying.jia" => "chunying.jia@chinapnr.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :svn => "http://192.168.0.178/svn/InfoCenter/系统/移动应用/CPCocoaPods/CPModelDefine", :tag => s.version.to_s, :submodules => true }
  s.source_files  = "CPModelDefine/*.{h,m}"
  s.public_header_files = "CPModelDefine/*.h"
  s.requires_arc = true
  s.dependency 'CPCXSignal', '0.0.1'
end
