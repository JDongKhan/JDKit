//
//  UIColor+jd_convenience.h
//
//
//  Created by wjd on 14-6-13.
//  Copyright (c) 2014年 wjd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (jd_convenience)

@property (nonatomic,assign,readonly) CGFloat r;

@property (nonatomic,assign,readonly) CGFloat g;

@property (nonatomic,assign,readonly) CGFloat b;

@property (nonatomic,assign,readonly) CGFloat a;

// 根据自己的颜色,返回黑色或者白色
- (instancetype) blackOrWhiteContrastingColor;

// 返回一个十六进制表示的颜色: @"FF0000" or @"#FF0000"
+ (instancetype) colorFromHexString:(NSString *)hexString;

// 返回一个十六进制表示的颜色: 0xFF0000
+ (instancetype) colorFromHex:(int)hex;

// 返回颜色的十六进制string
- (NSString *) hexString;

/**
 Creates an array of 4 NSNumbers representing the float values of r, g, b, a in that order.
 @return    NSArray
 */
- (NSArray *) rgbaArray;

/**
 * 反色 跟自己的颜色相反
 **/
- (instancetype)inverseColor;

/**
 * 淡化颜色
 **/
- (instancetype)thinColor;


@end
