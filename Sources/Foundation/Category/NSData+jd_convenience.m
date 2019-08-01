//
//  NSData+jd_convenience.m
//  JdCore
//
//  Created by jd on 16/7/8.
//  Copyright © 2016年 jd. All rights reserved.
//

#import "NSData+jd_convenience.h"
#include <CommonCrypto/CommonCrypto.h>

@implementation NSData (jd_convenience)


//2进制data转16进制
- (NSString *)dataToHexString {
    NSUInteger          len = [self length];
    char *              chars = (char *)[self bytes];
    NSMutableString *   hexString = [[NSMutableString alloc] init];
    
    for(NSUInteger i = 0; i < len; i++ ){
        [hexString appendString:[NSString stringWithFormat:@"%0.2hhx", chars[i]]];
    }
    return hexString;
}

- (NSData *)md5Data {
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(self.bytes, (CC_LONG)self.length, result);
    return [NSData dataWithBytes:result length:CC_MD5_DIGEST_LENGTH];
}


@end
