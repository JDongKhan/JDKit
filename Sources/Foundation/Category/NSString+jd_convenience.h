//
//  NSString+jd_convenience.h
//
//
//  Created by jd on 14-4-19.
//  Copyright (c) 2014年 jd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface NSString (jd_convenience)


/*!
 MD5加密
 */
@property (nonatomic, readonly, copy) NSString *md5String;

/**
 sha1加密
 */
@property (nonatomic, readonly, copy) NSString *sha1String;

/**
 string 转 base64 Data
 */
@property (nonatomic, readonly, copy) NSData *base64Data;

/**
 base64转码
 */
@property (nonatomic, nullable, readonly, copy) NSString *base64Encoded;

/**
 URLEncoded
 */
@property (nonatomic, readonly, copy) NSString *URLEncoded;

/**
 string decoded解码
 */
@property (nonatomic, readonly, copy) NSString *URLDecoded;

/*!
 首字母大写 其他保持不变  capitalizedString是首字母大写，其他都变成小写了
 **/
@property (nonatomic, readonly, copy) NSString *toCapitalizedString;

/*!
 UTF8编码
 */
@property (nonatomic, readonly, copy) NSString *UTF8Encoding;

/**
 16进制字符串转为二进制数组
 */
@property (nonatomic, readonly, strong) NSData *stringToHexData;

/*!
 将整形字符串处理成decimal格式 如 1234567-》1,234,567
 */
@property (nonatomic, readonly, copy) NSString *decimalString;

/*!
 string转NSAttributedString
 */
- (NSAttributedString *)attributedString NS_AVAILABLE(10_0, 7_0);
+ (NSAttributedString *)attributedStringFromString:(NSString *)string NS_AVAILABLE(10_0, 7_0);

/**
 版本字符串比较
 
 @param string 版本号
 @return 升序、降序、相等
 */
- (NSComparisonResult)versionNumberCompare:(NSString *)string;

/*!
 处理nill null等不符合的 返回@""

 @param string 字符串
 */
+ (NSString *)toTrimNill:(NSString *)string;
+ (NSString *)toTrimNill:(NSString *)string default:(NSString *)defaultString;

/********************** date操作  *************************/

/*!
 从老的日期格式转换成新的日期格式

 @param format_old 老的格式
 @param format_new 新的格式
 */
- (NSString *)stringOldFormat:(NSString*)format_old toNewFormat:(NSString*)format_new;

/*!
 将字符串日期格式化

 @param format_new 新格式
 */
- (NSString *)stringToNewFormat:(NSString*)format_new;

/*!
 string转date

 @param format 格式
 */
- (NSDate *)stringToDate:(NSString *)format;


/********************** url操作   *************************/

/*!
 打开url
 */
- (BOOL)stringOpenURL;

/*!
 能否打开
 */
- (BOOL)stringCanOpenURL;

/*!
 是否能打电话
 */
- (BOOL)stringCanTelPhone;

/*!
 打电话
 */
- (BOOL)stringTelPhone;

/*!
 string转NSUrl
 */
- (NSURL *)stringToURL;

/********************** 格式处理  *************************/

/*!
 按银行家算法将float保留2位

 @param value double类型的值
 */
+ (NSString *)double2ToString:(double)value;

/*!
 去掉float后面多余的0

 @param stringFloat 字符串类型的float数字
 */
+ (NSString *)trimZeroOfFloat:(NSString *)stringFloat ;

/*!
 将stringJson转换为对象
 */
- (id)JSONValue;


/********************** validation *************************/

/**
 是不是含有表情
 */
@property (nonatomic, readonly) BOOL containsEmoji;

/**
 是否是中文字符
 */
@property (nonatomic, readonly) BOOL isChineseCharacter;


/********************** Regex  *************************/
/*!
 验证手机号码
 */
@property (nonatomic, readonly, assign) BOOL isValidMobilePhone;

/*!
 验证邮件格式
 */
@property (nonatomic, readonly, assign) BOOL isValidEmail;

/*!
 身份证号
 */
@property (nonatomic, readonly, assign) BOOL isValidIdentityCard;

/*!
 从身份证上判断性别 NO为女  YES为男
 
 @param identityCard 身份证
 */
+ (BOOL)sexInfo:(NSString *)identityCard;

/********************** size *************************/

/**
 根据font计算size
 
 @param font 字体
 @return 计算好的size
 */
- (CGSize)sizeWithSingleLineFont:(UIFont *)font;


/**
 计算字符串size
 
 @param font 字体
 @param maxWidth 最大宽度
 @param maxLineCount 最大行数
 @return 计算好的size
 */
- (CGSize)sizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)maxWidth lineCount:(NSUInteger)maxLineCount;

/**
 计算字符串size
 
 @param font 字体
 @param maxWidth 最大宽度
 @param maxLineCount 最大行数
 @param constrained 是否受限制
 @return 计算好的size
 */
- (CGSize)sizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)maxWidth lineCount:(NSUInteger)maxLineCount constrained:(BOOL *)constrained;

/**
 计算字符串height
 
 @param font 字体
 @param maxWidth 最大宽
 @param maxLineCount 最大行数
 @return 计算好的height
 */
- (CGFloat)heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)maxWidth lineCount:(NSUInteger)maxLineCount;

/**
 计算字符串height
 
 @param font 字体
 @param maxWidth 最大宽
 @param maxLineCount 最大行数
 @param constrained 是否受限制
 @return 计算好的height
 */
- (CGFloat)heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)maxWidth lineCount:(NSUInteger)maxLineCount constrained:(BOOL *)constrained;

/**
 计算字符串size
 
 @param font 字体
 @param maxHeight 最大高
 @param maxLineCount 最大行数
 @return 计算好的size
 */
- (CGSize)sizeWithFont:(UIFont *)font constrainedToHeight:(CGFloat)maxHeight lineCount:(NSUInteger)maxLineCount;

- (CGSize)sizeWithFont:(UIFont *)font constrainedToHeight:(CGFloat)maxheight lineCount:(NSUInteger)maxLineCount constrained:(BOOL *)constrained;

- (CGFloat)widthWithFont:(UIFont *)font constrainedToHeight:(CGFloat)maxHeight lineCount:(NSUInteger)maxLineCount;



@end

NS_ASSUME_NONNULL_END
