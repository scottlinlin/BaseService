Pod::Spec.new do |s|

  s.name         = "UIViewController_Chinapnr"
  s.version      = "0.0.1"
  s.summary      = "UIViewController_Chinapnr"
  s.description  = <<-DESC
                   UIViewController_Chinapnr
                   DESC
  s.homepage     = "http://192.168.0.178/svn/InfoCenter/系统/移动应用/CPCocoaPods/UIViewController_Chinapnr"
  s.license      = "汇付保密协议"
  s.author             = { "chunying.jia" => "chunying.jia@chinapnr.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :svn => "http://192.168.0.178/svn/InfoCenter/系统/移动应用/CPCocoaPods/UIViewController_Chinapnr", :tag => s.version.to_s, :submodules => true }
  s.source_files  = "UIViewController_Chinapnr/*.{h,m}"
  s.public_header_files = "UIViewController_Chinapnr/*.h"
  s.requires_arc = true

end
