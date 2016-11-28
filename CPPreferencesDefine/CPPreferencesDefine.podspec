Pod::Spec.new do |s|

  s.name         = "CPPreferencesDefine"
  s.version      = "0.0.1"
  s.summary      = "CPPreferencesDefine"
  s.description  = <<-DESC
                   CPPreferencesDefine
                   DESC
  s.homepage     = "http://192.168.0.178/svn/InfoCenter/系统/移动应用/CPCocoaPods/CPPreferencesDefine"
  s.license      = "汇付保密协议"
  s.author             = { "chunying.jia" => "chunying.jia@chinapnr.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :svn => "http://192.168.0.178/svn/InfoCenter/系统/移动应用/CPCocoaPods/CPPreferencesDefine", :tag => s.version.to_s, :submodules => true }
  s.source_files  = "CPPreferencesDefine/*.{h,m}"
  s.public_header_files = "CPPreferencesDefine/*.h"
  s.requires_arc = true

end
