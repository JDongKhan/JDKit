//
//  NSString+jd_convenience.h
//
//
//  Created by wjd on 14-4-19.
//  Copyright (c) 2014年 wjd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (jd_convenience)

#pragma mark -------------- 字符串处理 -----------------
////验证手机号码 此方法有误，
//- (BOOL)isValidMobilePhone;

//
- (NSAttributedString *)attributedString NS_AVAILABLE(10_0, 7_0);
+ (NSAttributedString *)attributedStringFromString:(NSString *)string NS_AVAILABLE(10_0, 7_0);

//验证邮件格式
- (BOOL)isValidEmail;

//身份证号
- (BOOL)isValidIdentityCard;

//从身份证上判断性别 NO为女  YES为男
+ (BOOL)sexInfo:(NSString *)identityCard;

//将整形字符串处理成decimal格式 如 1234567-》1,234,567
- (NSString *)decimalString;

//处理nill null等不符合的 返回@""
+ (NSString *)toTrimNill:(NSString *)string;

+ (NSString *)toTrimNill:(NSString *)string default:(NSString *)defaultString;

#pragma mark  --------------	date操作   --------------
//从老的日期格式转换成新的日期格式
- (NSString *)stringOldFormat:(NSString*)format_old toNewFormat:(NSString*)format_new;

- (NSString *)stringToNewFormat:(NSString*)format_new;

//string转date
- (NSDate *)stringToDate:(NSString *)format;
#pragma mark  --------------	url操作   --------------
//	application
- (BOOL)stringOpenURL;//打开url

- (BOOL)stringCanOpenURL;//能否打开

- (BOOL)stringCanTelPhone;//是否能打电话

- (BOOL)stringTelPhone;//打电话
//	url操作
- (NSURL *)stringToURL;

#pragma mark -------------- 格式处理 --------------

/**
 ** 首字母大写 其他保持不变  capitalizedString是首字母大写，其他都变成小写了
 **/
- (NSString *)toCapitalizedString;

- (NSString *)UTF8Encoding;

//16进制字符串转为二进制数组
- (NSData *)stringToHexData;

//获得字符串实际尺寸
- (CGSize)textSizeOfFont:(UIFont *)font inSize:(CGSize)size;

//获得字符串实际尺寸
- (CGSize)textSizeOfFont:(UIFont *)font inSize:(CGSize)size options:(NSStringDrawingOptions)options;

//按银行家算法将float保留2位 
+ (NSString *)double2ToString:(double)value;
//去掉float后面多余的0
+ (NSString *)trimZeroOfFloat:(NSString *)stringFloat ;

//将stringJson转换为对象
- (id)JSONValue;

#pragma mark -------------- app基本功能 --------------
//可以获取appname CFBundleName
+ (NSString *)appName;

//可以获取appversion CFBundleShortVersionString
+ (NSString *)appVersion;

//操作系统版本号
+ (CGFloat )systemVersion;

//可以获取appBuild CFBundleVersion
+ (NSString *)appBuild;

//可以获取BundleIdentifier CFBundleIdentifier
+ (NSString *)bundleIdentifier;

//获取app信息
+ (NSDictionary *)appInfo;


@end
