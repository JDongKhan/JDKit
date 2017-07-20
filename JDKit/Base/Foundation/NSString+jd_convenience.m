//
//  NSString+hs_convenience.m
//  
//
//  Created by wjd on 14-4-19.
//  Copyright (c) 2014年 wjd. All rights reserved.
//

#import "NSString+jd_convenience.h"
#import <objc/runtime.h>

static const void *attributedStringKey = &attributedStringKey;

@implementation NSString (jd_convenience)
////手机号码验证 此方法有误，
//- (BOOL)isValidMobilePhone{
//    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//    BOOL isMatch = [pred evaluateWithObject:self];
//    if (!isMatch) {
//        return NO;
//    }
//    return YES;
//}

- (NSAttributedString *)attributedString {
    // 用HTML创建attributed String
    NSAttributedString *attrStr = objc_getAssociatedObject(self, attributedStringKey);
    if (attrStr == nil) {
        NSData *data = [self dataUsingEncoding:NSUTF16StringEncoding];
        attrStr = [[NSAttributedString alloc] initWithData:data options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
        objc_setAssociatedObject(self, attributedStringKey, attrStr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return attrStr;
}

+ (NSAttributedString *)attributedStringFromString:(NSString *)string NS_AVAILABLE(10_0, 7_0) {
    if(string.length > 0){
        return string.attributedString;
    }
    return nil;
}

//不符合的 返回@""
+ (NSString *)toTrimNill:(NSString *)string {
    return [NSString toTrimNill:string default:@""];
}
+ (NSString *)toTrimNill:(NSString *)string default:(NSString *)defaultString {
    if(string == nil || string == NULL || (NSNull *)string == [NSNull null]){
        return defaultString;
    }
    return string;
}
//邮箱
- (BOOL)isValidEmail {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}
//身份证号
- (BOOL)isValidIdentityCard {
    BOOL flag;
    if (self.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:self];
}

//从身份证上判断性别
+ (BOOL)sexInfo:(NSString *)identityCard {
    NSInteger sex = 0;
    if(identityCard.length == 15){
        sex = [[identityCard substringFromIndex:14] integerValue];
    }else if(identityCard.length == 18){
        sex = [[identityCard substringWithRange:NSMakeRange(16, 1)] integerValue];
    }
    return sex %2 == 0?NO:YES;
}

//将整形字符串处理成decimal格式 如 1234567-》1,234,567
- (NSString *)decimalString {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    return [formatter stringFromNumber:[NSNumber numberWithDouble:[self doubleValue]]];
}
#pragma mark Time & Date
- (NSString*)stringOldFormat:(NSString*)format_old toNewFormat:(NSString*)format_new {
	NSString* dateStr = self;
	//	Convert string to date object
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:format_old];
	NSDate *date = [dateFormat dateFromString:dateStr];
	//	Convert date object to desired output format
	[dateFormat setDateFormat:format_new];
	dateStr = [dateFormat stringFromDate:date];    
	return dateStr;
}

- (NSString *)stringToNewFormat:(NSString*)format_new {
    NSString *dateString = self;
    NSString *oldFormat = @"yyyy-MM-dd HH:mm:ss";
    return  [dateString stringOldFormat:[oldFormat substringToIndex:dateString.length] toNewFormat:format_new];
}



- (NSDate *)stringToDate:(NSString *)format {
    NSString *dateString = self;
    if(dateString.length > format.length){
        dateString = [self substringToIndex:format.length];
    }else if(format.length > dateString.length){
        if(dateString.length == 10){
            dateString = [NSString stringWithFormat:@"%@ 00:00:00",dateString];
        }else if(dateString.length == 13){
            dateString = [NSString stringWithFormat:@"%@:00:00",dateString];
        }else if(dateString.length == 16){
            dateString = [NSString stringWithFormat:@"%@:00",dateString];
        }
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter dateFromString:dateString];
}

#pragma mark Application

- (BOOL)stringOpenURL {
	NSString* s = [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:s]];
}

- (BOOL)stringCanOpenURL {
	NSString* s = [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:s]];
}

#pragma mark 是否能打电话
- (BOOL)stringCanTelPhone {
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel:"]];
}
//打电话
- (BOOL)stringTelPhone {
    if([self stringCanTelPhone]){
        return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self]]];
    }
    return NO;
}

#pragma mark URL
- (NSURL *)stringToURL {
    return [NSURL URLWithString:self];
}

/**
 ** 首字母大写 其他保持不变  capitalizedString是首字母大写，其他都变成小写了
 **/
- (NSString *)toCapitalizedString {
    if(self.length <= 1){
        return [self uppercaseString];
    }
    NSString *firstChar = [[self substringToIndex:1] uppercaseString];
    NSString *otherChar = [self substringFromIndex:1];
    return [firstChar stringByAppendingString:otherChar];
}

- (NSString*)UTF8Encoding {
	return [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSData *)stringToHexData{
    int len = [self length] / 2;    // Target length
    unsigned char *buf = malloc(len);
    unsigned char *whole_byte = buf;
    char byte_chars[3] = {'\0','\0','\0'};
    
    int i;
    for (i=0; i < [self length] / 2; i++) {
        byte_chars[0] = [self characterAtIndex:i*2];
        byte_chars[1] = [self characterAtIndex:i*2+1];
        *whole_byte = strtol(byte_chars, NULL, 16);
        whole_byte++;
    }
    
    NSData *data = [NSData dataWithBytes:buf length:len];
    free( buf );
    return data;
}

+ (NSString *)trimZeroOfFloat:(NSString *)stringFloat {
    const char *floatChars = [stringFloat UTF8String];
    NSUInteger length = [stringFloat length];
    int i = (int)length-1;
    for(; i>=0; i--)
    {
        if(floatChars[i] == '0') {
        } else {
            if(floatChars[i] == '.')
                i--;
            break;
        }
    }
    NSString *returnString;
    if(i == -1) {
        returnString = @"0";
    } else {
        returnString = [stringFloat substringToIndex:i+1];
    }
    return returnString;
}

//获得字符串实际尺寸
- (CGSize)textSizeOfFont:(UIFont *)font inSize:(CGSize)size {
    return [self textSizeOfFont:font inSize:size options:NSStringDrawingUsesLineFragmentOrigin];
}

- (CGSize)textSizeOfFont:(UIFont *)font inSize:(CGSize)size options:(NSStringDrawingOptions)options {
    //计算实际frame大小，并将label的frame变成实际大小
    CGSize labelsize;
    BOOL IOS7ORLate = [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ;
    if (IOS7ORLate)
    {
        CGRect rec = [self boundingRectWithSize:size
                                        options:options
                                     attributes:@{NSFontAttributeName:font}
                                        context:nil];
        labelsize=CGSizeMake(ceil(rec.size.width), ceil(rec.size.height));
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        labelsize= [self sizeWithFont:font constrainedToSize:size lineBreakMode:0];
#pragma clang diagnostic pop
    }
    return labelsize;
}

//按银行家算法将float保留2位
+ (NSString *)double2ToString:(double)value {
    value = roundf((value+0.001)*100)/100;
    return [NSString trimZeroOfFloat:[NSString stringWithFormat:@"%.2f",value]];
}

//将stringJson转换为对象
- (id)JSONValue {
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

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

//操作系统版本号
+ (CGFloat )systemVersion{
   return  [[[UIDevice currentDevice] systemVersion] floatValue];
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
