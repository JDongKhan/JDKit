//
//  UIButton+jd_layout.h
//  JDKit
//
//  Created by 王金东 on 2016/7/19.
//  Copyright © 2016年 王金东. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ButtonLayoutStyle) {
    ButtonLayoutDefault, // image在左，label在右
    ButtonLayoutImageTop, // image在上，label在下
    ButtonLayoutImageBottom, // image在下，label在上
    ButtonLayoutImageRight // image在右，label在左
};


@interface UIButton (jd_layout)

@property (nonatomic,assign) ButtonLayoutStyle layoutStyle;

- (void)layoutStyle:(ButtonLayoutStyle)style space:(CGFloat)space;

@end
