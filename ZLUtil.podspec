Pod::Spec.new do |s|
  s.name         = "ZLUtil"
  s.version      = "0.0.4"
  s.summary      = "ZLUtil provide common used function. For personal project use."
  s.homepage     = "https://github.com/ZouLinling/ZLUtil"

  s.license      = "MIT"  
  s.author             = { "ZouLinling" => "stampmi@163.com" }
  
  s.source       = { :git => "https://github.com/ZouLinling/ZLUtil.git", :tag => s.version }


  s.source_files  = "Util", "Category","CoreDataManager","Views","NetWork/XMLParser"
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

  s.framework  = "CoreTelephony"
  #s.frameworks = "CoreTelephony"

  #s.library   = "z"
  s.libraries = "z", "xml2"
	
  s.subspec 'JSONKit' do |spec|
    spec.requires_arc = false
    spec.source_files = 'JSONKit/*.{h,m}'
  end
  s.subspec 'ZLGTMBase64' do |spec|
    spec.requires_arc = false
    spec.source_files = 'Base64/*.{h,m}'
  end

  s.requires_arc = true

  s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  s.dependency 'MBProgressHUD', '~> 0.8'

end
