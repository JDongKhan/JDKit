//
//  UIColor+jd_convenience.m
//
//
//  Created by wjd on 14-6-13.
//  Copyright (c) 2014年 wjd. All rights reserved.
//

#import "UIColor+jd_convenience.h"

@implementation UIColor (jd_convenience)

+ (instancetype) colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    hexString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    
    [scanner scanHexInt:&rgbValue];
    return [[self class] colorFromHex:rgbValue];
}

+ (instancetype) colorFromHex:(int)hex{
    return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:1.0];
}

- (instancetype) blackOrWhiteContrastingColor {
    NSArray *rgbaArray = [self rgbaArray];
    double a = 1 - ((0.299 * [rgbaArray[0] doubleValue]) + (0.587 * [rgbaArray[1] doubleValue]) + (0.114 * [rgbaArray[2] doubleValue]));
    return a < 0.5 ? [[self class] blackColor] : [[self class] whiteColor];
}

- (NSString *) hexString {
    NSArray *colorArray	= [self rgbaArray];
    int r = [colorArray[0] floatValue] * 255;
    int g = [colorArray[1] floatValue] * 255;
    int b = [colorArray[2] floatValue] * 255;
    NSString *red = [NSString stringWithFormat:@"%02x", r];
    NSString *green = [NSString stringWithFormat:@"%02x", g];
    NSString *blue = [NSString stringWithFormat:@"%02x", b];
    
    return [NSString stringWithFormat:@"#%@%@%@", red, green, blue];
}

- (NSArray *) rgbaArray {
    // Takes a [self class] and returns R,G,B,A values in NSNumber form
    CGFloat r = 0;
    CGFloat g = 0;
    CGFloat b = 0;
    CGFloat a = 0;
    
    if ([self respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        [self getRed:&r green:&g blue:&b alpha:&a];
    }
    else {
        const CGFloat *components = CGColorGetComponents(self.CGColor);
        r = components[0];
        g = components[1];
        b = components[2];
        a = components[3];
    }
    return @[@(r), @(g), @(b), @(a)];
}

- (CGFloat)r {
    return [[self rgbaArray][0] floatValue];
}

- (CGFloat)g {
      return [[self rgbaArray][1] floatValue];
}

- (CGFloat)b {
     return [[self rgbaArray][2] floatValue];
}

- (CGFloat)a {
      return [[self rgbaArray][3] floatValue];
}

//反色
- (instancetype)inverseColor {
    CGFloat r = self.r;
    CGFloat g = self.g;
    CGFloat b = self.b;
    CGFloat a = self.a;
    return [UIColor colorWithRed:1.0f-r green:1.0f-g blue:1.0f-b alpha:a];
}

//淡化颜色
- (instancetype)thinColor {
    CGFloat r = self.r/2.0f;
    CGFloat g = self.g/2.0f;
    CGFloat b = self.b/2.0f;
    CGFloat a = self.a;
    if(r == g && g == b){
        if(a == 0.0f){//黑色
            r = 0.5f;
            g = 0.5f;
            b = 0.5f;
        }else{
            a = a/2.0f;
        }
    }
    return [UIColor colorWithRed:r green:g blue:b alpha:a];
}

@end
