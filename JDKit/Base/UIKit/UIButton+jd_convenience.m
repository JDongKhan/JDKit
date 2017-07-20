//
//  UIButton+jd_convenience.m
//  
//
//  Created by 王金东 on 14-11-5.
//  Copyright (c) 2014年 王金东. All rights reserved.
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

@end
