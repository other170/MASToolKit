
Pod::Spec.new do |spec|

  spec.name         = "MASToolKit"
  spec.version      = "0.0.1"
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
  
  # why要
  # spec.source_files = "MASToolKit/Classes/*"
  
  spec.subspec 'Device' do |ss|
    ss.source_files = 'MASToolKit/Classes/Device/*'
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
