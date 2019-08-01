//
//  UIButton+jd_convenience.m
//  
//
//  Created by JD on 14-11-5.
//  Copyright (c) 2014年 JD. All rights reserved.
//

#import "UIButton+jd_convenience.h"
#import <objc/runtime.h>

static const void *kTapClickKey = &kTapClickKey;


@implementation UIButton (jd_convenience)

- (void)setTitle:(NSString *)title {
    [self setTitle:title forState:UIControlStateNormal];
}

- (NSString *)title {
    return [self titleForState:UIControlStateNormal];
}

- (void)addTapClick:(void(^)(id sender))tapBlock {
    objc_setAssociatedObject(self, kTapClickKey, tapBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(clickSelector:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickSelector:(id)sender {
    void(^tapBlock)(id sender)  = objc_getAssociatedObject(self, kTapClickKey);
    if (tapBlock) {
        tapBlock(sender);
    }
}

- (void)layoutStyle:(ButtonLayoutStyle)style space:(CGFloat)space {
    CGFloat imageWith = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // iOS8中titleLabel的size为0
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
    } else {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    switch (style) {
            case ButtonLayoutImageTop: {
                imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/2.0, 0, 0, -labelWidth);
                labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-space/2.0, 0);
            }
            break;
            case ButtonLayoutDefault: {
                imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
                labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
            }
            break;
            case ButtonLayoutImageBottom: {
                imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth);
                labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space/2.0, -imageWith, 0, 0);
            }
            break;
            case ButtonLayoutImageRight: {
                imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space/2.0, 0, -labelWidth-space/2.0);
                labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-space/2.0, 0, imageWith+space/2.0);
            }
            break;
        default:
            break;
    }
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}

@end
