//
//  UIAlertView+jd_convenience.h
//
//
//  Created by JD on 14-6-13.
//  Copyright (c) 2014年 JD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^UIAlertView_block_self_index)(UIAlertView *alertView, NSInteger btnIndex);
typedef void(^UIAlertView_block_self)(UIAlertView *alertView);
typedef BOOL(^UIAlertView_block_shouldEnableFirstOtherButton)(UIAlertView *alertView);

@interface UIAlertView (jd_convenience)

// 选中功能按钮
- (void)handlerClickedButton:(UIAlertView_block_self_index)aBlock;

// 选中取消按钮
- (void)handlerCancel:(UIAlertView_block_self)aBlock;

// view即将出现
- (void)handlerWillPresent:(UIAlertView_block_self)aBlock;

// view已经出现
- (void)handlerDidPresent:(UIAlertView_block_self)aBlock;

// view即将消失
- (void)handlerWillDismiss:(UIAlertView_block_self_index)aBlock;

// view已经消失
- (void)handlerDidDismiss:(UIAlertView_block_self_index)aBlock;

// 点击第一个otherButton
- (void)handlerShouldEnableFirstOtherButton:(UIAlertView_block_shouldEnableFirstOtherButton)aBlock;

+ (void)show:(NSString *)title
     message:(NSString *)message
handlerClickedButton:(UIAlertView_block_self_index)aBlock;

+ (void)show:(NSString *)title
     message:(NSString *)message
     okTitle:(NSString *)okTitle
handlerClickedButton:(UIAlertView_block_self_index)aBlock;

+ (void)show:(NSString *)title
     message:(NSString *)message
     okTitle:(NSString *)okTitle
 cancelTitle:(NSString *)cancelTitle
handlerClickedButton:(UIAlertView_block_self_index)aBlock;

@end

NS_ASSUME_NONNULL_END
