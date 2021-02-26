//
//  MASDeviceTool.m
//  MASToolKitDemo
//
//  Created by py on 2021/2/26.
//

#import "MASDeviceTool.h"
#import <sys/sysctl.h>

@implementation MASDeviceTool

+ (NSString*)deviceInfo
{
    size_t size = 0;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char*)malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return platform;
}

+ (NSString *)appVersion
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

+ (NSString *)appBuildVersion
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
}

+ (NSString *)screenPixel
{
    CGFloat scale = [UIScreen mainScreen].scale;
    
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    CGFloat screenX = screenSize.width * scale;
    CGFloat screenY = screenSize.height * scale;
    
    NSString *screenX_Pixel = [[NSNumber numberWithFloat:screenX] stringValue];
    NSString *screenY_Pixel = [[NSNumber numberWithFloat:screenY] stringValue];
     
    NSString *screenPixel = [NSString stringWithFormat:@"%@x%@", screenX_Pixel, screenY_Pixel];
    return screenPixel;
}

+ (NSString *)systemVersion
{
    return [[UIDevice currentDevice] systemVersion];
}

+ (UIImage *)appIcon {
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSArray *iconsArr = infoDict[@"CFBundleIcons"][@"CFBundlePrimaryIcon"][@"CFBundleIconFiles"];
    return [UIImage imageNamed:[iconsArr lastObject]];
}

+ (NSString *)appBundleID{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
}

+ (NSString *)appName {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
}

@end
