//
//  NSData+jd_convenience.m
//  Core
//
//  Created by 王金东 on 16/7/8.
//  Copyright © 2016年 王金东. All rights reserved.
//

#import "NSData+jd_convenience.h"

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

@end
