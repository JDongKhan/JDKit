//
//  UIView+jd_animal.h
//  
//
//  Created by 王金东 on 14-8-4.
//  Copyright (c) 2014年 王金东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+jd_convenience.h"

/**
 * 动画
 **/
 
@interface UIView (jd_animal)

#pragma mark - --------------------------animation--------------------------
// 淡入淡出
- (void) animationCrossfadeWithDuration:(NSTimeInterval)duration;
- (void) animationCrossfadeWithDuration:(NSTimeInterval)duration completion:(UIViewCategoryAnimationBlock)completion;

/** 立方体翻转
 *kCATransitionFromRight, kCATransitionFromLeft, kCATransitionFromTop, kCATransitionFromBottom
 */
- (void) animationCubeWithDuration:(NSTimeInterval)duration direction:(NSString *)direction;
- (void) animationCubeWithDuration:(NSTimeInterval)duration direction:(NSString *)direction completion:(UIViewCategoryAnimationBlock)completion;

/** 翻转
 *kCATransitionFromRight, kCATransitionFromLeft, kCATransitionFromTop, kCATransitionFromBottom
 */
- (void) animationOglFlipWithDuration:(NSTimeInterval)duration direction:(NSString *)direction;
- (void) animationOglFlipWithDuration:(NSTimeInterval)duration direction:(NSString *)direction completion:(UIViewCategoryAnimationBlock)completion;

/** 覆盖
 *kCATransitionFromRight, kCATransitionFromLeft, kCATransitionFromTop, kCATransitionFromBottom
 */
- (void) animationMoveInWithDuration:(NSTimeInterval)duration direction:(NSString *)direction;
- (void) animationMoveInWithDuration:(NSTimeInterval)duration direction:(NSString *)direction completion:(UIViewCategoryAnimationBlock)completion;

// 抖动
- (void) animationShake;

//动画Z轴旋转
- (void) animationZRotate:(NSString *)key;

- (void) removeAnimation:(NSString *)key;




- (void)showAnimationType:(NSString *)type withSubType:(NSString *)subType duration:(CFTimeInterval)duration timingFunction:(NSString *)timingFunction view:(UIView *)theView;

// reveal
- (void)animationRevealFromBottom;
- (void)animationRevealFromTop;
- (void)animationRevealFromLeft;
- (void)animationRevealFromRight;

// 渐隐渐消
- (void)animationEaseIn;
- (void)animationEaseOut;

// 翻转
- (void)animationFlipFromLeft;
- (void)animationFlipFromRigh;

// 翻页
- (void)animationCurlUp;
- (void)animationCurlDown;

// push
- (void)animationPushUp;
- (void)animationPushDown;
- (void)animationPushLeft;
- (void)animationPushRight;

// move
- (void)animationMoveUpWithDuration:(CFTimeInterval)duration;
- (void)animationMoveDownWithDuration:(CFTimeInterval)duration;
- (void)animationMoveLeftWithDuration:(CFTimeInterval)duration;
- (void)animationMoveRightWithDuration:(CFTimeInterval)duration;

//flip
-(void)animationFlipFromTop;
- (void)animationFlipFromBottom;
- (void)animationCubeFromLeft;
- (void)animationCubeFromRight;

//cube
- (void)animationCubeFromTop;
- (void)animationCubeFromBottom;

- (void)animationSuckEffect;
- (void)animationRippleEffect;
- (void)animationCameraOpen;
- (void)animationCameraClose;

// 旋转缩放

// 旋转同时缩小放大效果
- (void)animationRotateAndScaleDownUp;

@end
