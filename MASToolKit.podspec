
Pod::Spec.new do |spec|

  spec.name         = "MASToolKit"
  spec.version      = "0.0.2"
  spec.summary      = "MASToolKit是一个工具类库，集成一些常用的第三方工具代码，让程序可以实现组件化提供方案"

  spec.description  = <<-DESC
                   MASToolKit是一个工具类库，集成一些常用的第三方工具代码，让程序可以实现组件化提供方案。
                   1.集成设备工具方法；
                   2.集成网络方法；
                   3.集成分类方法；
                   DESC

  spec.homepage     = "https://github.com/other170/MASToolKit.git"
  spec.license      = "MIT"
  spec.author       = { "panjq" => "1024607182@qq.com" }
  spec.platform     = :ios, "11.0"

  spec.source       = { :git => "https://github.com/other170/MASToolKit.git", :tag => "#{spec.version}" }
  
  
  
  # 建立库下文件层级
  spec.subspec 'Device' do |ss|
    ss.source_files = 'MASToolKit/Device/*.{h,m}'
  end
  
  # 建立库下文件层级
  spec.subspec 'Date' do |ss|
    ss.source_files = 'MASToolKit/Date/*.{h,m}'
  end
  
  
  
  
  
  
  
  # 依赖的系统库
  spec.framework  = "UIKit"
  
  # 是否使用ARC
  spec.requires_arc = true
  
  
  
  
  # spec.public_header_files = "Classes/**/*.h"
  # spec.resource  = "icon.png"
  # spec.resources = "Resources/*.png"
  # spec.preserve_paths = "FilesToSave", "MoreFilesToSave"

end
