//
//  UIView+jd_animal.h
//  
//
//  Created by JD on 14-8-4.
//  Copyright (c) 2014年 JD. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

typedef void(^UIViewCategoryAnimationBlock)(void);  //动画block

@interface UIView (jd_animal)

#pragma mark - --------------------------animation--------------------------

/**
 淡入淡出

 @param duration 动画时长
 */
- (void)animationCrossfadeWithDuration:(NSTimeInterval)duration;
- (void)animationCrossfadeWithDuration:(NSTimeInterval)duration completion:(UIViewCategoryAnimationBlock)completion;

/**
 立方体翻转
 
 @param duration 动画时长
 @param direction  kCATransitionFromRight, kCATransitionFromLeft, kCATransitionFromTop, kCATransitionFromBottom
 */
- (void)animationCubeWithDuration:(NSTimeInterval)duration direction:(NSString *)direction;
- (void)animationCubeWithDuration:(NSTimeInterval)duration direction:(NSString *)direction completion:(UIViewCategoryAnimationBlock)completion;

/**
 翻转
 @param duration 动画时长
 @param direction kCATransitionFromRight, kCATransitionFromLeft, kCATransitionFromTop, kCATransitionFromBottom
 */
- (void)animationOglFlipWithDuration:(NSTimeInterval)duration direction:(NSString *)direction;
- (void)animationOglFlipWithDuration:(NSTimeInterval)duration direction:(NSString *)direction completion:(UIViewCategoryAnimationBlock)completion;

/**
 覆盖
 @param duration 动画时长
 @param direction kCATransitionFromRight, kCATransitionFromLeft, kCATransitionFromTop, kCATransitionFromBottom
 */
- (void)animationMoveInWithDuration:(NSTimeInterval)duration direction:(NSString *)direction;
- (void)animationMoveInWithDuration:(NSTimeInterval)duration direction:(NSString *)direction completion:(UIViewCategoryAnimationBlock)completion;

/**
 抖动
 */
- (void)animationShake;

/**
 动画Z轴旋转

 @param key key
 */
- (void)animationZRotate:(NSString *)key;

/**
 移除动画

 @param key key
 */
- (void)removeAnimation:(NSString *)key;

/**
 type
 
   各种动画效果  其中除了'fade', `moveIn', `push' , `reveal' ,其他属于私有的API(我是这么认为的,可以点进去看下注释).
   ↑↑↑上面四个可以分别使用'kCATransitionFade', 'kCATransitionMoveIn', 'kCATransitionPush', 'kCATransitionReveal'来调用.
   @"cube"                     立方体翻滚效果
   @"moveIn"                   新视图移到旧视图上面
   @"reveal"                   显露效果(将旧视图移开,显示下面的新视图)
   @"fade"                     交叉淡化过渡(不支持过渡方向)             (默认为此效果)
   @"pageCurl"                 向上翻一页
   @"pageUnCurl"               向下翻一页
   @"suckEffect"               收缩效果，类似系统最小化窗口时的神奇效果(不支持过渡方向)
   @"rippleEffect"             滴水效果,(不支持过渡方向)
   @"oglFlip"                  上下左右翻转效果
   @"rotate"                   旋转效果
   @"push"
   @"cameraIrisHollowOpen"     相机镜头打开效果(不支持过渡方向)
   @"cameraIrisHollowClose"    相机镜头关上效果(不支持过渡方向)

   kCATransitionFade            交叉淡化过渡
   kCATransitionMoveIn          新视图移到旧视图上面
   kCATransitionPush            新视图把旧视图推出去
   kCATransitionReveal          将旧视图移开,显示下面的新视图
 */

/**
  subtype
 
   各种动画方向
   kCATransitionFromRight;      同字面意思(下同)
   kCATransitionFromLeft;
   kCATransitionFromTop;
   kCATransitionFromBottom;

   当type为@"rotate"(旋转)的时候,它也有几个对应的subtype,分别为:
   90cw    逆时针旋转90°
   90ccw   顺时针旋转90°
   180cw   逆时针旋转180°
   180ccw  顺时针旋转180°
 
   type与subtype的对应关系(必看),如果对应错误,动画不会显现.
   animation.subtype = subType;
   所有核心动画和特效都是基于CAAnimation,而CAAnimation是作用于CALayer的.所以把动画添加到layer上.
   forKey  可以是任意字符串.
*/

/**
 完整的动画方法
 
 @param type 动画类型 CATransitionType
 @param subType 动画子类型 CATransitionSubtype
 @param duration 时长 CFTimeInterval
 @param timingFunction CAMediaTimingFunction
 */

- (void)showAnimationInView:(UIView *)theView
                       type:(CATransitionType)type
                    subType:(CATransitionSubtype)subType
                   duration:(CFTimeInterval)duration
             timingFunction:(CAMediaTimingFunction *)timingFunction ;

/**
 reveal
 */
- (void)animationRevealFromBottom;
- (void)animationRevealFromTop;
- (void)animationRevealFromLeft;
- (void)animationRevealFromRight;

/**
 渐隐渐消
 */
- (void)animationEaseIn;
- (void)animationEaseOut;

/**
 翻转
 */
- (void)animationFlipFromLeft;
- (void)animationFlipFromRigh;

/**
 翻页
 */
- (void)animationCurlUp;
- (void)animationCurlDown;

/**
 push
 */
- (void)animationPushUp;
- (void)animationPushDown;
- (void)animationPushLeft;
- (void)animationPushRight;

/**
 move

 @param duration 时长
 */
- (void)animationMoveUpWithDuration:(CFTimeInterval)duration;
- (void)animationMoveDownWithDuration:(CFTimeInterval)duration;
- (void)animationMoveLeftWithDuration:(CFTimeInterval)duration;
- (void)animationMoveRightWithDuration:(CFTimeInterval)duration;

/**
 flip
 */
- (void)animationFlipFromTop;
- (void)animationFlipFromBottom;
- (void)animationCubeFromLeft;
- (void)animationCubeFromRight;

/**
 cube
 */
- (void)animationCubeFromTop;
- (void)animationCubeFromBottom;

- (void)animationSuckEffect;
- (void)animationRippleEffect;
- (void)animationCameraOpen;
- (void)animationCameraClose;

/**
 旋转同时缩小放大效果
 */
- (void)animationRotateAndScaleDownUp;

@end

NS_ASSUME_NONNULL_END
