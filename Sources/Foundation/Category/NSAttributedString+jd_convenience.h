//
//  NSAttributedString+jd_convenience.h
//  JDFoundation
//
//  Created by JD on 2018/4/26.
//  Copyright © 2018年 JD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface NSAttributedString (jd_convenience)

- (instancetype)initWithString:(NSString *)string font:(UIFont *)font foregroundColor:(UIColor *)foregroundColor lineSpacing:(CGFloat)lineSpacing;


- (CGFloat)heightConstrainedToWidth:(CGFloat)maxWidth;

    /**
     计算AttributedString的高度
     
     @param font 字体
     @param lineSpacing 行间距
     @param maxWidth 最大宽
     @param maxLineCount 最大行数
     @return 返回AttributedString的高度
     */
- (CGFloat)heightWithFont:(UIFont *)font lineSpacing:(CGFloat)lineSpacing constrainedToWidth:(CGFloat)maxWidth lineCount:(NSUInteger)maxLineCount;
    
- (CGFloat)heightWithFont:(UIFont *)font lineSpacing:(CGFloat)lineSpacing firstLineHeadIndent:(CGFloat)firstLineHeadIndent constrainedToWidth:(CGFloat)maxWidth lineCount:(NSUInteger)maxLineCount;

@end


NS_ASSUME_NONNULL_END
