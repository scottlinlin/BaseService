Pod::Spec.new do |s|

  s.name         = "CPAES256"
  s.version      = "0.0.1"
  s.summary      = "CPAES256"
  s.description  = <<-DESC
                   CPAES256
                   DESC
  s.homepage     = "https://github.com/scottlinlin/BaseService"
  s.license      = "汇付保密协议"
  s.author             = { "chunying.jia" => "chunying.jia@chinapnr.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :svn => "https://github.com/scottlinlin/BaseService", :tag => s.version.to_s, :submodules => true }
  s.source_files  = "CPAES256/*.{h,m}"
  s.public_header_files = "CPAES256/*.h"
  s.requires_arc = true
  s.dependency 'CPBase64', '0.0.1'

end
