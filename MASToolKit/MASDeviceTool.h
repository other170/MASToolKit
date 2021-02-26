//
//  MASDeviceTool.h
//  MASToolKitDemo
//
//  Created by py on 2021/2/26.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MASDeviceTool : NSObject

//======================================= 设备相关 =============================================
+ (NSString *)deviceInfo;            ///< 手机机型 （x86_64/ipod2,1/ipad3,2/iphone3,1）
+ (NSString *)appVersion;            ///< 对应：CFBundleShortVersionString (指info中version)
+ (NSString *)appBuildVersion;       ///< 对应：CFBundleVersion (指info中build)
+ (NSString *)screenPixel;           ///< 屏幕像素（750x1336, 460x960）
+ (NSString *)systemVersion;         ///< 手机系统版本号（13.2.3）
//AppIcon60x60
+ (UIImage *)appIcon;
//当前系统的bundleID plist的CFBundleIdentifier字段 (显示为 Bundle identifier)
+ (NSString *)appBundleID;
+ (NSString *)appName;

@end

NS_ASSUME_NONNULL_END
