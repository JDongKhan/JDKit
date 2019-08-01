//
//  JDAppInfo.m
//  JDUIKit
//
//  Created by JD on 2019/7/31.
//  Copyright © 2019 JD. All rights reserved.
//

#import "JDAppInfo.h"
#import <UIKit/UIDevice.h>

@implementation JDAppInfo

#pragma mark -------------- app基本功能 --------------
+ (NSString *)appName {
    NSDictionary *plistDic = [[NSBundle mainBundle] infoDictionary];    //获取info-plist；
    NSString *appName = plistDic[@"CFBundleName"];               //获取CFBundleName
    return appName;
}

//可以获取appversion 1.0.1
+ (NSString *)appVersion{
    NSDictionary *plistDic = [[NSBundle mainBundle] infoDictionary];    //获取inof-plist；
    NSString *appVersion = plistDic[@"CFBundleShortVersionString"];     //获取CFBundleShortVersionString
    return appVersion;
}

//可以获取appBuild 1.0
+ (NSString *)appBuild{
    NSDictionary *plistDic = [[NSBundle mainBundle] infoDictionary];    //获取inof-plist；
    NSString *appVersion = plistDic[@"CFBundleVersion"];                //获取CFBundleVersion
    return appVersion;
}

//可以获取BundleIdentifier
+ (NSString *)bundleIdentifier {
    NSDictionary *dic    =   [[NSBundle mainBundle] infoDictionary];
    NSString *appId  =   [dic objectForKey:@"CFBundleIdentifier"];
    return appId;
}

+ (NSDictionary *)appInfo{
    // NSString *deviceID   =   [[UIApplication sharedApplication] uuid];
    NSString *systemVersion   =   [[UIDevice currentDevice] systemVersion];     //系统版本
    NSString *systemModel    =   [[UIDevice currentDevice] model];              //是iphone 还是 ipad
    NSDictionary *dic    =   [[NSBundle mainBundle] infoDictionary];            //获取info－plist
    NSString *appId  =   [dic objectForKey:@"CFBundleIdentifier"];              //获取Bundle identifier
    NSString *appName  =   [dic objectForKey:@"CFBundleDisplayName"];           //获取CFBundleDisplayName
    NSString *appVersion   =   [dic valueForKey:@"CFBundleVersion"];            //获取Bundle Version
    NSDictionary *userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:
                              systemVersion, @"systemVersion",
                              systemModel, @"systemModel",
                              appName, @"appName",
                              appId,@"appId",
                              appVersion, @"appVersion",nil];
    return userInfo;
}

@end
