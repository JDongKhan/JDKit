//
//  UILabel+jd_convenience.h
//
//
//  Created by JD on 13-12-26.
//  Copyright (c) 2013年 JD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,JDUILabelResizeType) {
    JDUILabelResizeType_constantHeight = 1,   //固定高度
    JDUILabelResizeType_constantWidth,        //固定宽度
};

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (jd_convenience)

@property (nonatomic) CGSize viewSize;              //得到该控件文本的size  不能用textSize字段
@property (nonatomic,assign) NSInteger maxLines;    //最大行数
@property (nonatomic,assign) CGFloat maxWidth;      //最大宽度

/**
 设置attributedText

 @param text 富文本
 */
- (void)setAttributedTextFromString:(NSString *)text;

/**
 自动调整frame
 */
- (void)autoReSizeFrame;

/**
 调整UILabel尺寸

 @param type JDUILabelResizeType
 */
- (void)resize:(JDUILabelResizeType)type;

/**
 返回估计的尺寸

 @param height 固定height
 */
- (CGSize)estimateUISizeByHeight:(CGFloat)height;

/**
 返回估计的尺寸

 @param width 固定width
 */
- (CGSize)estimateUISizeByWidth:(CGFloat)width;

/**
 类方法计算文本size

 @param string 文本
 @param font 字体
 @param width 宽度
 */
+ (CGSize)textSize:(NSString *)string font:(UIFont *)font width:(CGFloat)width;

@end

NS_ASSUME_NONNULL_END
