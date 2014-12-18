Pod::Spec.new do |s|
  s.name         = "ZLUtil"
  s.version      = "0.0.1"
  s.summary      = "ZLUtil provide common used function. For personal project use."
  s.homepage     = "https://github.com/ZouLinling/ZLUtil"
  
  s.author             = { "ZouLinling" => "stampmi@163.com" }
  
  s.source       = { :git => "https://github.com/ZouLinling/ZLUtil.git", :tag => "0.0.1" }


  s.source_files  = "Util", "Category"
  #s.exclude_files = 

  # s.public_header_files = "Classes/**/*.h"


  #s.resources = "ZLUtil/*.png"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"

  s.platform     = :ios


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # s.framework  = "SomeFramework"
  s.frameworks = "CoreTelephony.framework"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"


  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  s.dependency 'MBProgressHUD', '~> 0.8'

end
