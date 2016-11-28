Pod::Spec.new do |s|

  s.name         = "CPCXSignal"
  s.version      = "0.0.1"
  s.summary      = "CPCXSignal"
  s.description  = <<-DESC
                   CPCXSignal
                   DESC
  s.homepage     = "http://192.168.0.178/svn/InfoCenter/系统/移动应用/CPCocoaPods/CPCXSignal"
  s.license      = "汇付保密协议"
  s.author             = { "chunying.jia" => "chunying.jia@chinapnr.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :svn => "http://192.168.0.178/svn/InfoCenter/系统/移动应用/CPCocoaPods/CPCXSignal", :tag => s.version.to_s, :submodules => true }
  s.source_files  = "CPCXSignal/*.{h,m}"
  s.public_header_files = "CPCXSignal/*.h"
  s.requires_arc = true

end
