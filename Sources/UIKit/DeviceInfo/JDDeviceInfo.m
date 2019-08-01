//
//  JDDeviceInfo.m
//  JDFoundation
//
//  Created by jd on 2015/03/04.
//  Copyright © 2015 jd. All rights reserved.
//

#import "JDDeviceInfo.h"
#import "JDKeychain.h"
#import "JDOpenUDID.h"
#import <AdSupport/AdSupport.h>
#import <CommonCrypto/CommonDigest.h>
#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <ifaddrs.h>
#include <arpa/inet.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import "NSString+jd_convenience.h"


@implementation SPTDeviceInfo


+ (NSString *)hardwareModel {
    static dispatch_once_t one;
    static NSString *model;
    dispatch_once(&one, ^{
        size_t size;
        sysctlbyname("hw.model", NULL, &size, NULL, 0);
        char *machine = malloc(size);
        sysctlbyname("hw.model", machine, &size, NULL, 0);
        model = [NSString stringWithUTF8String:machine];
        free(machine);
    });
    return model;
}


+ (NSString *)machineModel {
    static dispatch_once_t one;
    static NSString *model;
    dispatch_once(&one, ^{
        size_t size;
        sysctlbyname("hw.machine", NULL, &size, NULL, 0);
        char *machine = malloc(size);
        sysctlbyname("hw.machine", machine, &size, NULL, 0);
        model = [NSString stringWithUTF8String:machine];
        free(machine);
    });
    return model;
}


+ (NSString *)shortPlatformName {
    static NSString *shortPlatformName = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shortPlatformName = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? @"ipd" : @"iph";
    });
    return shortPlatformName;
}

+ (NSString *)machineModelName {
    static dispatch_once_t one;
    static NSString *name;
    dispatch_once(&one, ^{
        NSString *model = [self machineModel];
        if (model == nil) {
            return;
        }
        
        // reference to https://www.theiphonewiki.com
        NSDictionary *dictionary = @{
                                     @"Watch1,1" : @"Apple Watch 38mm",
                                     @"Watch1,2" : @"Apple Watch 42mm",
                                     @"Watch2,3" : @"Apple Watch Series 2 38mm",
                                     @"Watch2,4" : @"Apple Watch Series 2 42mm",
                                     @"Watch2,6" : @"Apple Watch Series 1 38mm",
                                     @"Watch2,7" : @"Apple Watch Series 1 42mm",
                                     @"Watch3,1" : @"Apple Watch Series 3 38mm Cellular",
                                     @"Watch3,2" : @"Apple Watch Series 3 42mm Cellular",
                                     @"Watch3,3" : @"Apple Watch Series 3 38mm",
                                     @"Watch3,4" : @"Apple Watch Series 3 42mm",
                                     @"Watch4,1" : @"Apple Watch Series 4 40mm",
                                     @"Watch4,2" : @"Apple Watch Series 4 44mm",
                                     @"Watch4,3" : @"Apple Watch Series 4 40mm Cellular",
                                     @"Watch4,4" : @"Apple Watch Series 4 44mm Cellular",

                                     @"AirPods1,1" : @"AirPods",
                                     
                                     @"AudioAccessory1,1" : @"HomePod",
                                     @"AudioAccessory1,2" : @"HomePod",
                                     
                                     @"iPod1,1" : @"iPod touch 1",
                                     @"iPod2,1" : @"iPod touch 2",
                                     @"iPod3,1" : @"iPod touch 3",
                                     @"iPod4,1" : @"iPod touch 4",
                                     @"iPod5,1" : @"iPod touch 5",
                                     @"iPod7,1" : @"iPod touch 6",
                                     
                                     @"iPhone1,1" : @"iPhone",
                                     @"iPhone1,2" : @"iPhone 3G",
                                     @"iPhone2,1" : @"iPhone 3GS",
                                     @"iPhone3,1" : @"iPhone 4 (GSM)",
                                     @"iPhone3,2" : @"iPhone 4",
                                     @"iPhone3,3" : @"iPhone 4 (CDMA)",
                                     @"iPhone4,1" : @"iPhone 4S",
                                     @"iPhone5,1" : @"iPhone 5",
                                     @"iPhone5,2" : @"iPhone 5",
                                     @"iPhone5,3" : @"iPhone 5c",
                                     @"iPhone5,4" : @"iPhone 5c",
                                     @"iPhone6,1" : @"iPhone 5s",
                                     @"iPhone6,2" : @"iPhone 5s",
                                     @"iPhone7,1" : @"iPhone 6 Plus",
                                     @"iPhone7,2" : @"iPhone 6",
                                     @"iPhone8,1" : @"iPhone 6s",
                                     @"iPhone8,2" : @"iPhone 6s Plus",
                                     @"iPhone8,4" : @"iPhone SE",
                                     @"iPhone9,1" : @"iPhone 7",
                                     @"iPhone9,2" : @"iPhone 7 Plus",
                                     @"iPhone9,3" : @"iPhone 7",
                                     @"iPhone9,4" : @"iPhone 7 Plus",
                                     @"iPhone10,1" : @"iPhone 8",
                                     @"iPhone10,4" : @"iPhone 8",
                                     @"iPhone10,2" : @"iPhone 8 Plus",
                                     @"iPhone10,5" : @"iPhone 8 Plus",
                                     @"iPhone10,3" : @"iPhone X",
                                     @"iPhone10,6" : @"iPhone X",
                                     @"iPhone11,8" : @"iPhone XR",
                                     @"iPhone11,2" : @"iPhone XS",
                                     @"iPhone11,4" : @"iPhone XS Max",
                                     @"iPhone11,6" : @"iPhone XS Max",
                                     
                                     @"iPad1,1" : @"iPad 1",
                                     @"iPad2,1" : @"iPad 2 (WiFi)",
                                     @"iPad2,2" : @"iPad 2 (GSM)",
                                     @"iPad2,3" : @"iPad 2 (CDMA)",
                                     @"iPad2,4" : @"iPad 2",
                                     @"iPad2,5" : @"iPad mini 1",
                                     @"iPad2,6" : @"iPad mini 1",
                                     @"iPad2,7" : @"iPad mini 1",
                                     @"iPad3,1" : @"iPad 3 (WiFi)",
                                     @"iPad3,2" : @"iPad 3 (4G)",
                                     @"iPad3,3" : @"iPad 3 (4G)",
                                     @"iPad3,4" : @"iPad 4",
                                     @"iPad3,5" : @"iPad 4",
                                     @"iPad3,6" : @"iPad 4",
                                     @"iPad4,1" : @"iPad Air",
                                     @"iPad4,2" : @"iPad Air",
                                     @"iPad4,3" : @"iPad Air",
                                     @"iPad4,4" : @"iPad mini 2",
                                     @"iPad4,5" : @"iPad mini 2",
                                     @"iPad4,6" : @"iPad mini 2",
                                     @"iPad4,7" : @"iPad mini 3",
                                     @"iPad4,8" : @"iPad mini 3",
                                     @"iPad4,9" : @"iPad mini 3",
                                     @"iPad5,1" : @"iPad mini 4",
                                     @"iPad5,2" : @"iPad mini 4",
                                     @"iPad5,3" : @"iPad Air 2",
                                     @"iPad5,4" : @"iPad Air 2",
                                     @"iPad6,3" : @"iPad Pro (9.7 inch)",
                                     @"iPad6,4" : @"iPad Pro (9.7 inch)",
                                     @"iPad6,7" : @"iPad Pro (12.9 inch)",
                                     @"iPad6,8" : @"iPad Pro (12.9 inch)",
                                     @"iPad6,11" : @"iPad (5th generation)",
                                     @"iPad6,12" : @"iPad (5th generation)",
                                     @"iPad7,1" : @"iPad Pro (12.9 inch, 2nd generation)",
                                     @"iPad7,2" : @"iPad Pro (12.9 inch, 2nd generation)",
                                     @"iPad7,3" : @"iPad Pro (10.5 inch)",
                                     @"iPad7,4" : @"iPad Pro (10.5 inch)",
                                     @"iPad7,5" : @"iPad 6",
                                     @"iPad7,6" : @"iPad 6",

                                     @"AppleTV2,1" : @"Apple TV 2",
                                     @"AppleTV3,1" : @"Apple TV 3",
                                     @"AppleTV3,2" : @"Apple TV 3",
                                     @"AppleTV5,3" : @"Apple TV 4",
                                     @"AppleTV6,2" : @"Apple TV 4K",
                                     
                                     @"i386" : @"Simulator x86",
                                     @"x86_64" : @"Simulator x64",
                                     };
        name = dictionary[model];
        if (name == nil) {
            name = model;
        }
    });
    return name;
}

+ (NSString *)systemVersion {
    return UIDevice.currentDevice.systemVersion;
}

+ (BOOL)systemVersionReachesIOS9 {
#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
    return ([UIDevice.currentDevice.systemVersion floatValue] >= 9.0);
#endif
    return NO;
}


+ (BOOL)systemVersionReachesIOS10 {
#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
    return ([UIDevice.currentDevice.systemVersion floatValue] >= 10.0);
#endif
    return NO;
}

+ (JDDevicePlatform)platformType {
    NSString *platform = self.machineModel;
    
    if ([platform isEqualToString:@"iFPGA"])        return JDDeviceIFPGA;
    
    if ([platform isEqualToString:@"iPhone1,1"])    return JDDevice1GiPhone;
    if ([platform isEqualToString:@"iPhone1,2"])    return JDDevice3GiPhone;
    if ([platform hasPrefix:@"iPhone2"])    return JDDevice3GSiPhone;
    if ([platform hasPrefix:@"iPhone3"])            return JDDevice4iPhone;
    if ([platform hasPrefix:@"iPhone4"])            return JDDevice5iPhone;
    
    if ([platform isEqualToString:@"iPod1,1"])   return JDDevice1GiPod;
    if ([platform isEqualToString:@"iPod2,1"])   return JDDevice2GiPod;
    if ([platform isEqualToString:@"iPod3,1"])   return JDDevice3GiPod;
    if ([platform isEqualToString:@"iPod4,1"])   return JDDevice4GiPod;
    
    if ([platform isEqualToString:@"iPad1,1"])   return JDDevice1GiPad;
    if ([platform isEqualToString:@"iPad2,1"])   return JDDevice2GiPad;
    
    if ([platform isEqualToString:@"AppleTV2,1"])    return JDDeviceAppleTV2;
    
    /*
     MISSING A SOLUTION HERE TO DATE TO DIFFERENTIATE iPAD and iPAD 3G.... SORRY!
     */
    
    if ([platform hasPrefix:@"iPhone"]) return JDDeviceUnknowniPhone;
    if ([platform hasPrefix:@"iPod"]) return JDDeviceUnknowniPod;
    if ([platform hasPrefix:@"iPad"]) return JDDeviceUnknowniPad;
    
    if ([platform hasSuffix:@"86"] || [platform isEqual:@"x86_64"]) {
        if (MIN(([UIScreen.mainScreen bounds].size.width), ([UIScreen.mainScreen bounds].size.height)) < 768)
            return JDDeviceiPhoneSimulatoriPhone;
        else
            return JDDeviceiPhoneSimulatoriPad;
        
        return JDDeviceiPhoneSimulator;
    }
    return JDDeviceUnknown;
}


+ (NSString *)prefferedLanguage {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
    NSString *currentLanguage = languages.firstObject;
    return currentLanguage;
}

+ (NSString *)currentLocaleIdentifier {
    NSLocale *locale = [NSLocale currentLocale];
    NSString *country = [locale localeIdentifier];
    
    return country;
}


+ (NSString *)carrier {
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    if (info == nil) {
        return nil;
    }
    
    CTCarrier *carrier = [info subscriberCellularProvider];
    if (carrier == nil) {
        return nil;
    }
    
    return [carrier carrierName];
}


+ (NSString *)IMSI {
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    if (carrier == nil) {
        return nil;
    }
    NSString *mcc = [carrier mobileCountryCode];
    NSString *mnc = [carrier mobileNetworkCode];
    NSMutableString *imsi = [[NSMutableString alloc] init];
    if (mcc.length != 0) {
        [imsi appendString:mcc];
    }
    if (mnc.length != 0) {
        [imsi appendString:mnc];
    }

    return imsi;
}


+ (NSString *)SSID {
    NSArray *ifs = CFBridgingRelease((__bridge CFTypeRef)((__bridge id)CNCopySupportedInterfaces()));
    id info = nil;
    for (NSString *ifnam in ifs) {
        info = CFBridgingRelease((__bridge CFTypeRef)((__bridge id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam)));
        if (info && [info count]) {
            NSString *ssid = [info objectForKey:(__bridge NSString *)kCNNetworkInfoKeySSID];
            //NSString *bssid=[info objectForKey:(__bridge NSString *)kCNNetworkInfoKeyBSSID];
            //NSLog(@"interfaceName:%@ ssid:%@ bssid:%@",ifnam,ssid,bssid);
            return ssid;
        }
    }
    return nil;
}


+ (NSUInteger)systemInfoFor:(uint)typeSpecifier {
    size_t size = sizeof(int);
    int results;
    int mib[2] = {CTL_HW, typeSpecifier};
    sysctl(mib, 2, &results, &size, NULL, 0);
    return (NSUInteger)results;
}


+ (NSUInteger)numberOfCPUs {
    return [self systemInfoFor:HW_NCPU];
}


+ (NSUInteger)cpuFrequency {
    return [self systemInfoFor:HW_CPU_FREQ];
}


+ (NSUInteger)busFrequency {
    return [self systemInfoFor:HW_BUS_FREQ];
}


+ (NSUInteger)totalMemory {
    return [self systemInfoFor:HW_PHYSMEM];
}


+ (NSUInteger)userMemory {
    return [self systemInfoFor:HW_USERMEM];
}


+ (NSString *)bootTime {
    NSString *proc_useTime;
    //指定名字参数，按照顺序第一个元素指定本请求定向到内核的哪个子系统，第二个及其后元素依次细化指定该系统的某个部分。
    //CTL_KERN，KERN_PROC,KERN_PROC_ALL 正在运行的所有进程
    int mib[4] = {CTL_KERN, KERN_PROC, KERN_PROC_PID, 0};
    u_int miblen = 4;
    //值-结果参数：函数被调用时，size指向的值指定该缓冲区的大小；函数返回时，该值给出内核存放在该缓冲区中的数据量
    //如果这个缓冲不够大，函数就返回ENOMEM错误
    size_t size;
    //返回0，成功；返回-1，失败
    int st = sysctl(mib, miblen, NULL, &size, NULL, 0);
    
    struct kinfo_proc * process = NULL;
    struct kinfo_proc * newprocess = NULL;
    do {
        size += size / 10;
        newprocess = realloc(process, size);
        if (!newprocess) {
            if (process) {
                free(process);
                process = NULL;
            }
            return @"";
        }
        process = newprocess;
        st = sysctl(mib, miblen, process, &size, NULL, 0);
    }
    while (st == -1 && errno == ENOMEM);
    if (st == 0) {
        if (size % sizeof(struct kinfo_proc) == 0) {
            int nprocess = (int) (size / sizeof(struct kinfo_proc));
            if (nprocess) {
                for (int i = nprocess - 1; i >= 0; i--) {
                    @autoreleasepool{
                        //the process duration
                        double t = process->kp_proc.p_un.__p_starttime.tv_sec;
                        double mmt=process->kp_proc.p_un.__p_starttime.tv_usec;
                        
//                        proc_useTime = [self getDateStrFromTimeStep:t];
                        NSDate *timestepDate = [NSDate dateWithTimeIntervalSince1970:t];
                        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                        NSTimeZone* timeZone = [NSTimeZone systemTimeZone];
                        [formatter setTimeZone:timeZone];
                        [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
                        proc_useTime = [formatter stringFromDate:timestepDate];
                        proc_useTime = [proc_useTime stringByAppendingString:[NSString stringWithFormat:@".%d",(int)mmt/1000]];
                    }
                }
                free(process);
                process = NULL;
                return proc_useTime;
            }
        }
    }
    return nil;
}


+ (CGFloat)physicalMemory {
    unsigned long long bytesValue = [NSProcessInfo processInfo].physicalMemory;
    return bytesValue / 1024.0f / 1024.0f;
}


+ (NSUInteger)maxSocketBufferSize {
    return [self systemInfoFor:KIPC_MAXSOCKBUF];
}


+ (CGFloat)totalDiskSpace {
    NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    return [attributes[NSFileSystemSize] unsignedLongLongValue] / 1024.0f / 1024.0f;
}


+ (CGFloat)freeDiskSpace {
    NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    return [attributes[NSFileSystemFreeSize] unsignedLongLongValue] / 1024.0f / 1024.0f;
}


+ (NSString *)macAddress {
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return nil;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return nil;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return nil;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        free(buf);
        return nil;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *result = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                        *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    result = [result stringByReplacingOccurrencesOfString:@":" withString:@""];
    return result;
}


+ (NSString *)ip {
    NSString *address = @"127.0.0.1";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if (temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    // Free memory
    freeifaddrs(interfaces);
    
    return address;
}


+ (BOOL)iOSDevideJailbroken {
    return self.iOSDeviceJailbroken;
}


+ (BOOL)iOSDeviceJailbroken {
    NSString *cydiaPath = @"/Applications/Cydia.app";
    NSString *aptPath = @"/private/var/lib/apt/";
    if ([[NSFileManager defaultManager] fileExistsAtPath:cydiaPath]) {
        return YES;
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:aptPath]) {
        return YES;
    }
    return NO;
}


+ (NSString *)screenResolutionString {
    CGFloat width = MIN(([UIScreen.mainScreen bounds].size.width), ([UIScreen.mainScreen bounds].size.height)) * [UIScreen.mainScreen scale];
    CGFloat height = MAX(([UIScreen.mainScreen bounds].size.width), ([UIScreen.mainScreen bounds].size.height)) * [UIScreen.mainScreen scale];
    
    return [NSString stringWithFormat:@"%ldx%ld", (long)width, (long)height];
}


+ (NSString *)openUDID {
    NSString *string = [JDKeychain dataForKey:@"com.jd.udid"];
    if ([string isKindOfClass:[NSString class]]) {
        return string;
    }
    
    NSString *udid = [JDOpenUDID value];
    if (udid != nil) {
        [JDKeychain saveData:udid forKey:@"com.jd.udid"];
        return udid;
    }
    
    return @"";
}


+ (NSString *)uniqueDeviceIdentifier {
    NSString *openUDID = self.openUDID;
    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    
    NSString *stringToHash = [NSString stringWithFormat:@"%@%@", openUDID, bundleIdentifier];
//    NSString *uniqueIdentifier = stringToHash.spt_md5;
    
    const char *cStr = [stringToHash UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)(strlen(cStr)), result); // This is the md5 call
    NSString *uniqueIdentifier = [NSString stringWithFormat:
                                  @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                                  result[0], result[1], result[2], result[3],
                                  result[4], result[5], result[6], result[7],
                                  result[8], result[9], result[10], result[11],
                                  result[12], result[13], result[14], result[15]
                                  ];

    
    return uniqueIdentifier;
}


+ (BOOL)idiomIsPhone {
#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone);
#endif
    return NO;
}


+ (BOOL)idiomIsPad {
#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
#endif
    return NO;
}


+ (NSString *)IDFA {
    NSString *string = [JDKeychain dataForKey:@"com.jd.idfaOrIdfv"];
    if (string != nil) {
        return string;
    }
    NSString *uuid = [ASIdentifierManager sharedManager].advertisingIdentifier.UUIDString;
    NSString *uuid2 = [[uuid stringByReplacingOccurrencesOfString:@"-" withString:@""] stringByReplacingOccurrencesOfString:@"0" withString:@""];
    if (uuid2.length == 0) {
        NSString *idfv = [UIDevice currentDevice].identifierForVendor.UUIDString;
        if (idfv != nil) {
            [JDKeychain saveData:idfv forKey:@"com.jd.idfaOrIdfv"];
            return idfv;
        }
        NSString *openUDIDString = [[self openUDID] md5String];
        if (openUDIDString.length == 0) {
            return @"00000000-0000-0000-0000-000000000000";
        }
        if (openUDIDString.length >= 20) {
            NSArray *strings = @[
                                 [openUDIDString substringWithRange:NSMakeRange(0, 7)],
                                 [openUDIDString substringWithRange:NSMakeRange(7, 4)],
                                 [openUDIDString substringWithRange:NSMakeRange(11, 4)],
                                 [openUDIDString substringWithRange:NSMakeRange(15, 4)],
                                 ];
            NSString *lastString = [openUDIDString substringFromIndex:19];
            openUDIDString = [NSString stringWithFormat:@"%@-%@", [strings componentsJoinedByString:@"-"],lastString];
        }
        openUDIDString = [openUDIDString uppercaseString];
        [JDKeychain saveData:openUDIDString forKey:@"com.jd.idfaOrIdfv"];
        return openUDIDString;
    } else {
        [JDKeychain saveData:uuid forKey:@"com.jd.idfaOrIdfv"];
        return uuid;
    }
}


@end


@implementation UIDevice (JDDeviceID)


+ (NSString *)deviceID {
    static NSString *SPTKeychainDeviceID = @"com.jd.keychain.deviceid";
    
    NSString *deviceID = (NSString *)[JDKeychain dataForKey:SPTKeychainDeviceID];
    if (deviceID.length != 0) {
        return deviceID;
    }
    
    NSUUID *identifierForVendor = [[UIDevice currentDevice] identifierForVendor];
    if (identifierForVendor) {
        deviceID = [[identifierForVendor UUIDString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
        [JDKeychain saveData:deviceID forKey:SPTKeychainDeviceID];
        return deviceID;
    }
    
    return @"";
}


@end
