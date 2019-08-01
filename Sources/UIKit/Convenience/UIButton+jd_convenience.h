//
//  UIButton+jd_convenience.h
//  
//
//  Created by JD on 14-11-5.
//  Copyright (c) 2014年 JD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ButtonLayoutStyle) {
    ButtonLayoutDefault, // image在左，label在右
    ButtonLayoutImageTop, // image在上，label在下
    ButtonLayoutImageBottom, // image在下，label在上
    ButtonLayoutImageRight // image在右，label在左
};

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (jd_convenience)


/*!
 *  button.title
 */
@property (nonatomic, copy) NSString *title;


- (void)layoutStyle:(ButtonLayoutStyle)style space:(CGFloat)space;

/**
 点击事件

 @param tapBlock 点击回调block
 */
- (void)addTapClick:(void(^)(id sender))tapBlock;

@end

NS_ASSUME_NONNULL_END
