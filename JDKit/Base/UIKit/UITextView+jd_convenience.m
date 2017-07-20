//
//  UITextView+jd_convenience.m
//
//
//  Created by wjd on 13-11-25.
//  Copyright (c) 2013年 wjd. All rights reserved.
//

#import "UITextView+jd_convenience.h"
#import <objc/runtime.h>
#import "NSString+jd_convenience.h"

static const void *tminHeight = &tminHeight;
static const void *tmaxHeight = &tmaxHeight;

static const void *textViewInvalidEmpty = &textViewInvalidEmpty;
static const void *textViewRegex = &textViewRegex;
static const void *textViewMaxLenght = &textViewMaxLenght;

@implementation UITextView (jd_convenience)
@dynamic textSize;

//类方法计算文本size
+ (CGSize)textSize:(NSString *)string font:(UIFont *)font width:(CGFloat)width {
    if(string.length == 0){
        return CGSizeZero;
    }
    CGSize maxSize = CGSizeMake(width-16, MAXFLOAT);
    CGSize size= [string textSizeOfFont:font inSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading];
    CGSize textSize = CGSizeMake(size.width, size.height+16);
    return textSize;
}

- (CGSize)textSize {
    CGFloat minHeight = self.minHeight;
    CGFloat maxHeight = self.maxHeight;
    if(maxHeight == 0 ){
        maxHeight = MAXFLOAT;
    }
    if(minHeight <= 0 && (self.text.length == 0 || self.text == nil)){
        return CGSizeZero ;
    }
    //计算文本size
    CGSize size = [UITextView textSize:self.text font:self.font width:self.bounds.size.width];
    CGSize textsize = CGSizeMake(size.width, size.height);
    //处理文本siz以满足设定条件
    if(size.height <= minHeight){
        if(minHeight == 0){
            textsize.height = 0;
        }else{
            textsize.height = minHeight+16;
        }
    }else if(size.height >= maxHeight){
        textsize.height = maxHeight+16;
    }
    return textsize;    
}

- (void)setMinHeight:(CGFloat)minHeight{
    objc_setAssociatedObject(self, tminHeight, [NSNumber numberWithFloat:minHeight], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)minHeight{
    NSNumber *height = objc_getAssociatedObject(self, tminHeight);
    return [height floatValue];
}

- (void)setMaxHeight:(CGFloat)maxHeight{
    objc_setAssociatedObject(self, tmaxHeight, [NSNumber numberWithFloat:maxHeight], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)maxHeight{
    NSNumber *height = objc_getAssociatedObject(self, tmaxHeight);
    return [height floatValue];
}




- (void)setValidEmpty:(BOOL)invalidEmpty {
    objc_setAssociatedObject(self, textViewInvalidEmpty, [NSNumber numberWithBool:invalidEmpty], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)validEmpty {
    return [objc_getAssociatedObject(self, textViewInvalidEmpty) boolValue];
}
- (void)setRegex:(NSString *)regex {
    objc_setAssociatedObject(self, textViewRegex, regex, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)regex {
    return objc_getAssociatedObject(self, textViewRegex);
}

- (BOOL)isValidate {
    BOOL isValidate = YES;
    if (self.validEmpty && self.text.length == 0) {
        isValidate = NO;
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", self.regex];
    isValidate = [predicate evaluateWithObject:self.text];
    
    return isValidate;
}

//设置attributedText
- (void)setAttributedTextFromString:(NSString *)text {
    self.attributedText = [text attributedString];
}

@end
