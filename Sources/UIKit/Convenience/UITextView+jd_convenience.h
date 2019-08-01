//
//  UITextView+jd_convenience.h
//
//
//  Created by JD on 13-11-25.
//  Copyright (c) 2013年 JD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (jd_convenience)

@property (nonatomic,assign) CGSize textSize;       //得到文本size
@property (nonatomic,assign) CGFloat minHeight;     //最小高
@property (nonatomic,assign) CGFloat maxHeight;     //最大高

/**
 设置attributedText

 @param text 富文本
 */
- (void)setAttributedTextFromString:(NSString *)text;

/**
 类方法计算文本size

 @param string 文本
 @param font 字体
 @param width 宽度
 */
+ (CGSize)textSize:(NSString *)string font:(UIFont *)font width:(CGFloat)width;

/**
 验证：不能为空
 */
@property (nonatomic,assign) BOOL validEmpty;

/**
 正则表达式，符合该正则的才能输入
 */
@property (nonatomic,strong) NSString *regex;

/**
 验证，配合validEmpty和regex使用
 */
- (BOOL)isValidate;

@end

NS_ASSUME_NONNULL_END
