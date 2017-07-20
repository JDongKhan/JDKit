//
//  UIView+jd_hidenConstraints.h
//
//  Created by wjd on 15/8/20.
//  Copyright (c) 2015年 wjd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (jd_hidenConstraints)

- (void)hideView:(BOOL)hidden byAttributes:(NSLayoutAttribute)attributes,...NS_REQUIRES_NIL_TERMINATION;

//height or width == 0 则隐藏控件，如果不知道width或height则负值-1，则不做更改
- (void)hiddenWithWidthConstraint:(CGFloat)width;
- (void)hiddenWithHeightConstraint:(CGFloat)height;
- (void)hiddenWithWidthConstraint:(CGFloat)width height:(CGFloat)height;


@end
