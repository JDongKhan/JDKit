//
//  NSString+jd_convenience.m
//  
//
//  Created by jd on 14-4-19.
//  Copyright (c) 2014年 jd. All rights reserved.
//

#import "NSString+jd_convenience.h"
#import <objc/runtime.h>
#import <CommonCrypto/CommonDigest.h>

static const void *JDAttributedStringKey = &JDAttributedStringKey;

@implementation NSString (jd_convenience)


- (NSString *)md5String {
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)(strlen(cStr)), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}


- (NSString *)sha1String {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}


- (NSData *)base64Data {
    NSMutableData *mutableData = nil;
    
    unsigned long ixtext = 0;
    unsigned long lentext = 0;
    unsigned char ch = 0;
    unsigned char inbuf[4] = {0};
    unsigned char outbuf[3] = {0};
    short i = 0;
    short ixinbuf = 0;
    BOOL flignore = NO;
    BOOL flendtext = NO;
    NSData *base64Data = nil;
    const unsigned char *base64Bytes = nil;
    
    // Convert the string to ASCII data.
    base64Data = [self dataUsingEncoding:NSASCIIStringEncoding];
    base64Bytes = [base64Data bytes];
    mutableData = [NSMutableData dataWithCapacity:base64Data.length];
    lentext = base64Data.length;
    
    while (YES) {
        if (ixtext >= lentext) {
            break;
        }
        
        ch = base64Bytes[ixtext++];
        flignore = NO;
        
        if ((ch >= 'A') && (ch <= 'Z')) {
            ch = ch - 'A';
        } else if ((ch >= 'a') && (ch <= 'z')) {
            ch = ch - 'a' + 26;
        } else if ((ch >= '0') && (ch <= '9')) {
            ch = ch - '0' + 52;
        } else if (ch == '+') {
            ch = 62;
        } else if (ch == '=') {
            flendtext = YES;
        } else if (ch == '/') {
            ch = 63;
        } else {
            flignore = YES;
        }
        
        if (!flignore) {
            short ctcharsinbuf = 3;
            BOOL flbreak = NO;
            
            if (flendtext) {
                if (!ixinbuf) {
                    break;
                }
                if ((ixinbuf == 1) || (ixinbuf == 2)) {
                    ctcharsinbuf = 1;
                } else {
                    ctcharsinbuf = 2;
                }
                ixinbuf = 3;
                flbreak = YES;
            }
            
            inbuf[ixinbuf++] = ch;
            
            if (ixinbuf == 4) {
                ixinbuf = 0;
                outbuf[0] = (inbuf[0] << 2) | ((inbuf[1] & 0x30) >> 4);
                outbuf[1] = ((inbuf[1] & 0x0F) << 4) | ((inbuf[2] & 0x3C) >> 2);
                outbuf[2] = ((inbuf[2] & 0x03) << 6) | (inbuf[3] & 0x3F);
                
                for (i = 0; i < ctcharsinbuf; i++) {
                    [mutableData appendBytes:&outbuf[i] length:1];
                }
            }
            
            if (flbreak) {
                break;
            }
        }
    }
    
    NSData *data = [[NSData alloc] initWithData:mutableData];
    return data;
}


- (NSString *)base64Encoded {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:(NSDataBase64EncodingOptions)0];
}

- (NSString *)URLEncoded {
    static NSString * const SPTCharactersGeneralDelimitersToEncode = @":#[]@"; // does not include "?" or "/" due to RFC 3986 - Section 3.4
    static NSString * const SPTCharactersSubDelimitersToEncode = @"!$&'()*+,;=";
    
    NSMutableCharacterSet *allowedCharacterSet = [[NSCharacterSet URLQueryAllowedCharacterSet] mutableCopy];
    [allowedCharacterSet removeCharactersInString:[SPTCharactersGeneralDelimitersToEncode stringByAppendingString:SPTCharactersSubDelimitersToEncode]];
    
    // FIXME: https://github.com/AFNetworking/AFNetworking/pull/3028
    // return [string stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];
    
    static NSUInteger const batchSize = 50;
    
    NSUInteger index = 0;
    NSMutableString *escaped = @"".mutableCopy;
    
    while (index < self.length) {
        NSUInteger length = MIN(self.length - index, batchSize);
        NSRange range = NSMakeRange(index, length);
        
        // To avoid breaking up character sequences such as 👴🏻👮🏽
        range = [self rangeOfComposedCharacterSequencesForRange:range];
        
        NSString *substring = [self substringWithRange:range];
        NSString *encoded = [substring stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];
        [escaped appendString:encoded];
        
        index += range.length;
    }
    
    return escaped;
}

- (NSString *)URLDecoded {
    return [self stringByRemovingPercentEncoding];
}


- (NSAttributedString *)attributedString {
    // 用HTML创建attributed String
    NSAttributedString *attrStr = objc_getAssociatedObject(self, JDAttributedStringKey);
    if (attrStr == nil) {
        NSData *data = [self dataUsingEncoding:NSUTF16StringEncoding];
        attrStr = [[NSAttributedString alloc] initWithData:data options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
        objc_setAssociatedObject(self, JDAttributedStringKey, attrStr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return attrStr;
}

+ (NSAttributedString *)attributedStringFromString:(NSString *)string NS_AVAILABLE(10_0, 7_0) {
    if (string.length > 0) {
        return string.attributedString;
    }
    return nil;
}

- (NSComparisonResult)versionNumberCompare:(NSString *)string {
    NSCharacterSet *numberAndDotCharacterSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
    NSString *trimmedSelf = [self stringByTrimmingCharactersInSet:numberAndDotCharacterSet];
    NSString *trimmedString = [string stringByTrimmingCharactersInSet:numberAndDotCharacterSet];
    NSArray *selfComponents = [trimmedSelf componentsSeparatedByString:@"."];
    NSArray *stringComponents = [trimmedString componentsSeparatedByString:@"."];
    NSUInteger selfComponentsCount = [selfComponents count];
    NSUInteger stringComponentsCount = [stringComponents count];
    NSUInteger comparableComponentsCount = MIN(selfComponentsCount, stringComponentsCount);
    
    for (NSUInteger i = 0; i < comparableComponentsCount; i++) {
        NSString *aSelfComponent = selfComponents[i];
        NSString *aStringComponent = stringComponents[i];
        NSComparisonResult result = [aSelfComponent compare:aStringComponent options:NSNumericSearch];
        if (result != NSOrderedSame) {
            return result;
        }
    }
    
    NSComparisonResult result = [@(selfComponentsCount) compare:@(stringComponentsCount)];
    return result;
}

//不符合的 返回@""
+ (NSString *)toTrimNill:(NSString *)string {
    return [NSString toTrimNill:string default:@""];
}
+ (NSString *)toTrimNill:(NSString *)string default:(NSString *)defaultString {
    if (string == nil || string == NULL || (NSNull *)string == [NSNull null]) {
        return defaultString;
    }
    return string;
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
    if (dateString.length > format.length) {
        dateString = [self substringToIndex:format.length];
    } else if(format.length > dateString.length) {
        if (dateString.length == 10) {
            dateString = [NSString stringWithFormat:@"%@ 00:00:00",dateString];
        } else if (dateString.length == 13) {
            dateString = [NSString stringWithFormat:@"%@:00:00",dateString];
        } else if (dateString.length == 16) {
            dateString = [NSString stringWithFormat:@"%@:00",dateString];
        }
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter dateFromString:dateString];
}

#pragma mark -------- Application --------

- (BOOL)openURL:(NSURL *)URL {
    UIApplication *application = [UIApplication sharedApplication];
    if ([application canOpenURL:URL]) {
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:URL options:@{UIApplicationOpenURLOptionUniversalLinksOnly:@(NO)} completionHandler:^(BOOL success) {
            }];
            return YES;
        } else {
            return [[UIApplication sharedApplication] openURL:URL];
        }
    }
    return NO;
}

- (BOOL)stringOpenURL {
    NSString *utf8Str = [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
	return [self openURL:[NSURL URLWithString:utf8Str]];
}


- (BOOL)stringCanOpenURL {
    NSString *utf8Str = [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
	return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:utf8Str]];
}

#pragma mark 是否能打电话
- (BOOL)stringCanTelPhone {
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel:"]];
}

//打电话
- (BOOL)stringTelPhone {
    if ([self stringCanTelPhone]) {
        return [self openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self]]];
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
    if (self.length <= 1) {
        return [self uppercaseString];
    }
    NSString *firstChar = [[self substringToIndex:1] uppercaseString];
    NSString *otherChar = [self substringFromIndex:1];
    return [firstChar stringByAppendingString:otherChar];
}

- (NSString*)UTF8Encoding {
	return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

- (NSData *)stringToHexData{
    NSUInteger len = [self length] / 2;    // Target length
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
    free(buf);
    return data;
}

+ (NSString *)trimZeroOfFloat:(NSString *)stringFloat {
    const char *floatChars = [stringFloat UTF8String];
    NSUInteger length = [stringFloat length];
    int i = (int)length-1;
    for (; i>=0; i--) {
        if (floatChars[i] == '0') {
        } else {
            if (floatChars[i] == '.')
                i--;
            break;
        }
    }
    NSString *returnString;
    if (i == -1) {
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
    CGRect rec = [self boundingRectWithSize:size
                                        options:options
                                     attributes:@{NSFontAttributeName:font}
                                        context:nil];
    CGSize labelsize=CGSizeMake(ceil(rec.size.width), ceil(rec.size.height));
    return labelsize;
}

//按银行家算法将float保留2位
+ (NSString *)double2ToString:(double)value {
    value = roundf((value+0.001)*100)/100;
    return [NSString trimZeroOfFloat:[NSString stringWithFormat:@"%.2f",value]];
}

//将stringJson转换为对象
- (id)JSONValue {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}


/******************** validation *************************/

- (BOOL)containsEmoji {
    __block BOOL containsEmoji = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         const unichar hs = [substring characterAtIndex:0];
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     containsEmoji = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 containsEmoji = YES;
             }
         } else {
             if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                 containsEmoji = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 containsEmoji = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 containsEmoji = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 containsEmoji = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a) {
                 containsEmoji = YES;
             }
         }
     }];
    return containsEmoji;
}

- (BOOL)isChineseCharacter {
    NSString *regex = @"^[\u4E00-\u9FA5]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

- (BOOL)isValidMobilePhone{
    NSString *regex = @"^1[3456789]([0-9]){9}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    if (!isMatch) {
        return NO;
    }
    return YES;
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
    if (identityCard.length == 15) {
        sex = [[identityCard substringFromIndex:14] integerValue];
    } else if (identityCard.length == 18) {
        sex = [[identityCard substringWithRange:NSMakeRange(16, 1)] integerValue];
    }
    return sex %2 == 0?NO:YES;
}

#pragma mark  ------ size -------


- (CGSize)sizeWithSingleLineFont:(UIFont *)font {
    NSStringDrawingOptions options = 0;
    NSDictionary *attributes = @{NSFontAttributeName: font};
    CGSize size = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
                                     options:options
                                  attributes:attributes
                                     context:nil].size;
    return CGSizeMake(ceilf(size.width), ceilf(size.height));
}

- (CGSize)sizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)maxWidth lineCount:(NSUInteger)maxLineCount {
    BOOL anyBoolValue;
    return [self sizeWithFont:font constrainedToWidth:maxWidth lineCount:maxLineCount constrained:&anyBoolValue];
}


- (CGSize)sizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)maxWidth lineCount:(NSUInteger)maxLineCount constrained:(BOOL *)constrained {
    CGFloat width = 0.0f;
    CGFloat height = 0.0f;
    
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin;
    NSDictionary *attributes = @{NSFontAttributeName: font};
    if (maxLineCount == 0) {
        CGSize size = [self boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX)
                                         options:options
                                      attributes:attributes
                                         context:nil].size;
        width = size.width;
        height = size.height;
        if (constrained != nil) {
            *constrained = NO;
        }
    } else {
        NSMutableString *testString = [NSMutableString stringWithString:@"X"];
        for (NSInteger i = 0; i < maxLineCount - 1; i++) {
            [testString appendString:@"\nX"];
        }
        
        CGSize maxSize = [testString boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX)
                                                  options:options
                                               attributes:attributes
                                                  context:nil].size;
        CGSize textSize = [self boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX)
                                             options:options
                                          attributes:attributes
                                             context:nil].size;
        width = textSize.width;
        if (maxSize.height < textSize.height) {
            if (constrained != nil) {
                *constrained = YES;
            }
            height = maxSize.height;
        } else {
            if (constrained != nil) {
                *constrained = NO;
            }
            height = textSize.height;
        }
    }
    width = ceilf(width);
    height = ceilf(height);
    return CGSizeMake(width, height);
}


- (CGFloat)heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)maxWidth lineCount:(NSUInteger)maxLineCount {
    return [self sizeWithFont:font constrainedToWidth:maxWidth lineCount:maxLineCount].height;
}


- (CGFloat)heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)maxWidth lineCount:(NSUInteger)maxLineCount constrained:(BOOL *)constrained {
    return [self sizeWithFont:font constrainedToWidth:maxWidth lineCount:maxLineCount constrained:constrained].height;
}


- (CGSize)sizeWithFont:(UIFont *)font constrainedToHeight:(CGFloat)maxHeight lineCount:(NSUInteger)maxLineCount {
    BOOL anyBoolValue;
    return [self sizeWithFont:font constrainedToHeight:maxHeight lineCount:maxLineCount constrained:&anyBoolValue];
}


- (CGSize)sizeWithFont:(UIFont *)font constrainedToHeight:(CGFloat)maxheight lineCount:(NSUInteger)maxLineCount constrained:(BOOL *)constrained {
    CGFloat width = 0.0f;
    CGFloat height = 0.0f;
    
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin;
    NSDictionary *attributes = @{NSFontAttributeName: font};
    if (maxLineCount == 0) {
        CGSize size = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, maxheight)
                                         options:options
                                      attributes:attributes
                                         context:nil].size;
        width = size.width;
        height = size.height;
        if (constrained != nil) {
            *constrained = NO;
        }
    } else {
        NSMutableString *testString = [NSMutableString stringWithString:@"X"];
        for (NSInteger i = 0; i < maxLineCount - 1; i++) {
            [testString appendString:@"\nX"];
        }
        
        CGSize maxSize = [testString boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, maxheight)
                                                  options:options
                                               attributes:attributes
                                                  context:nil].size;
        CGSize textSize = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, maxheight)
                                             options:options
                                          attributes:attributes
                                             context:nil].size;
        width = textSize.width;
        if (maxSize.height < textSize.height) {
            if (constrained != nil) {
                *constrained = YES;
            }
            height = maxSize.height;
        } else {
            if (constrained != nil) {
                *constrained = NO;
            }
            height = textSize.height;
        }
    }
    width = ceilf(width);
    height = ceilf(height);
    return CGSizeMake(width, height);
}


- (CGFloat)widthWithFont:(UIFont *)font constrainedToHeight:(CGFloat)maxHeight lineCount:(NSUInteger)maxLineCount {
    return [self sizeWithFont:font constrainedToHeight:maxHeight lineCount:maxLineCount].width;
}


@end
