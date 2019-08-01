//
//  JDDeviceInfo.h
//  JDFoundation
//
//  Created by jd on 2015/03/04.
//  Copyright © 2015 jd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger,JDDevicePlatform) {
    JDDeviceUnknown,
    JDDeviceiPhoneSimulator,
    JDDeviceiPhoneSimulatoriPhone,
    JDDeviceiPhoneSimulatoriPad,
    JDDevice1GiPhone,
    JDDevice3GiPhone,
    JDDevice3GSiPhone,
    JDDevice4iPhone,
    JDDevice5iPhone,
    JDDevice1GiPod,
    JDDevice2GiPod,
    JDDevice3GiPod,
    JDDevice4GiPod,
    JDDevice1GiPad,
    JDDevice2GiPad,
    JDDeviceAppleTV2,
    JDDeviceUnknowniPhone,
    JDDeviceUnknowniPod,
    JDDeviceUnknowniPad,
    JDDeviceIFPGA,
};

NS_ASSUME_NONNULL_BEGIN


@interface SPTDeviceInfo : NSObject

/**
 iPhone 7 Plus is D11AP, iPhone 4s is N94AP
 */
@property (nonatomic, class, nullable, readonly, copy) NSString *hardwareModel;

/**
 iPhone1,1、iPhone5,1、
 */
@property (nonatomic, class, nullable, readonly, copy) NSString *machineModel;

/**
 iPhone 8、iPhone X等
 */
@property (nonatomic, class, nullable, readonly, copy) NSString *machineModelName;

/**
 iph\ipd
 */
@property (nonatomic, class, nullable, readonly, copy) NSString *shortPlatformName;

/**
 系统版本号 8.0、10.0
 */
@property (nonatomic, class, readonly, copy) NSString *systemVersion;

/**
 系统版本号是否大于9.0
 */
@property (nonatomic, class, readonly) BOOL systemVersionReachesIOS9;

/**
 系统版本号是否大于10.0
 */
@property (nonatomic, class, readonly) BOOL systemVersionReachesIOS10;

/**
 平台类型 UIDevicePlatform
 */
@property (nonatomic, class, readonly) JDDevicePlatform platformType;

/**
 语言
 */
@property (nonatomic, class, nullable, readonly, copy) NSString *prefferedLanguage;

/**
 国家编码
 */
@property (nonatomic, class, nullable, readonly, copy) NSString *currentLocaleIdentifier;

/**
 运营商名称
 */
@property (nonatomic, class, nullable, readonly, copy) NSString *carrier;

/**
 IMSI
 */
@property (nonatomic, class, nullable, readonly, copy) NSString *IMSI;

/**
 SSID
 */
@property (nonatomic, class, nullable, readonly, copy) NSString *SSID;

/**
 CPU数量
 */
@property (nonatomic, class, readonly) NSUInteger numberOfCPUs;

/**
 CPU频率
 */
@property (nonatomic, class, readonly) NSUInteger cpuFrequency;

/**
 Bus 频率
 */
@property (nonatomic, class, readonly) NSUInteger busFrequency;

/**
 总共内存
 */
@property (nonatomic, class, readonly) NSUInteger totalMemory;

/**
 用户内存
 */
@property (nonatomic, class, readonly) NSUInteger userMemory;

/**
 开机时间
 */
@property (nonatomic, class, nullable, readonly, copy) NSString *bootTime;

/**
 物理内存，单位是M
 */
@property (nonatomic, class, readonly) CGFloat physicalMemory;

/**
 NSHomeDirectory下 所有硬盘空间
 */
@property (nonatomic, class, readonly) CGFloat totalDiskSpace;

/**
 NSHomeDirectory下 剩余空间
 */
@property (nonatomic, class, readonly) CGFloat freeDiskSpace;

/**
 mac地址
 */
@property (nonatomic, class, nullable, readonly, copy) NSString *macAddress;

/**
 ip地址
 */
@property (nonatomic, class, nullable, readonly, copy) NSString *ip;

/**
 设备是否是越狱
 */
@property (nonatomic, class, readonly) BOOL iOSDeviceJailbroken;

/**
 屏幕分辨率
 */
@property (nonatomic, class, nullable, readonly, copy) NSString *screenResolutionString;

/**
 UUID
 */
@property (nonatomic, class, readonly, copy) NSString *openUDID;

/**
 设备唯一标识
 */
@property (nonatomic, class, readonly, copy) NSString *IDFA;

/**
 设备唯一标识 建议使用IDFA
 */
@property (nonatomic, class, readonly, copy) NSString *uniqueDeviceIdentifier;

/**
 是否是iPhone
 */
@property (nonatomic, class, readonly) BOOL idiomIsPhone;

/**
 是否是iPad
 */
@property (nonatomic, class, readonly) BOOL idiomIsPad;

@end


@interface UIDevice (JDDeviceID)

/**
 设备唯一标示
 */
+ (NSString *)deviceID;

@end


NS_ASSUME_NONNULL_END
