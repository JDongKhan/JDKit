//
//  UITextView+jd_convenience.h
//
//
//  Created by wjd on 13-11-25.
//  Copyright (c) 2013年 wjd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (jd_convenience)

@property (nonatomic,assign) CGSize textSize;       //得到文本size
@property (nonatomic,assign) CGFloat minHeight;     //最小高
@property (nonatomic,assign) CGFloat maxHeight;     //最大高

//设置attributedText
- (void)setAttributedTextFromString:(NSString *)text;

//类方法计算文本size
+ (CGSize)textSize:(NSString *)string font:(UIFont *)font width:(CGFloat)width;

//不能为空
@property (nonatomic,assign) BOOL validEmpty;
@property (nonatomic,strong) NSString *regex;

//验证
- (BOOL)isValidate;


@end
