//
//  UIView+jd_animal.m
//  
//
//  Created by 王金东 on 14-8-4.
//  Copyright (c) 2014年 王金东. All rights reserved.
//

#import "UIView+jd_animal.h"

@implementation UIView (jd_animal)

#pragma mark - animation
- (void) animationCrossfadeWithDuration:(NSTimeInterval)duration {
    CAAnimation *animation = [NSClassFromString(@"CATransition") animation];
    [animation setValue:@"kCATransitionFade" forKey:@"type"];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    animation.duration = duration;
    [self.layer addAnimation:animation forKey:nil];
}

- (void) animationCrossfadeWithDuration:(NSTimeInterval)duration completion:(UIViewCategoryAnimationBlock)completion {
    [self animationCrossfadeWithDuration:duration];
    if (completion) {
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC));
        dispatch_after(time, dispatch_get_main_queue(), completion);
    }
}

- (void) animationCubeWithDuration:(NSTimeInterval)duration direction:(NSString *)direction {
    CATransition *transtion = [CATransition animation];
    transtion.duration = duration;
    [transtion setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [transtion setType:@"cube"];
    [transtion setSubtype:direction];
    [self.layer addAnimation:transtion forKey:@"transtionKey"];
}

- (void) animationCubeWithDuration:(NSTimeInterval)duration direction:(NSString *)direction completion:(UIViewCategoryAnimationBlock)completion {
    [self animationCubeWithDuration:duration direction:direction];
    if (completion) {
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC));
        dispatch_after(time, dispatch_get_main_queue(), completion);
    }
}

- (void) animationOglFlipWithDuration:(NSTimeInterval)duration direction:(NSString *)direction {
    CATransition *transtion = [CATransition animation];
    transtion.duration = duration;
    [transtion setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [transtion setType:@"oglFlip"];
    [transtion setSubtype:direction];
    [self.layer addAnimation:transtion forKey:@"transtionKey"];
}

- (void) animationOglFlipWithDuration:(NSTimeInterval)duration direction:(NSString *)direction completion:(void (^)(void))completion {
    [self animationOglFlipWithDuration:duration direction:direction];
    if (completion) {
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC));
        dispatch_after(time, dispatch_get_main_queue(), completion);
    }
}

- (void) animationMoveInWithDuration:(NSTimeInterval)duration direction:(NSString *)direction {
    CATransition *transtion = [CATransition animation];
    transtion.duration = duration;
    [transtion setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [transtion setType:kCATransitionMoveIn];
    [transtion setSubtype:direction];
    [self.layer addAnimation:transtion forKey:@"transtionKey"];
}

- (void) animationMoveInWithDuration:(NSTimeInterval)duration direction:(NSString *)direction completion:(UIViewCategoryAnimationBlock)completion {
    [self animationMoveInWithDuration:duration direction:direction];
    if (completion) {
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC));
        dispatch_after(time, dispatch_get_main_queue(), completion);
    }
}

- (void) animationShake {
    CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //设置抖动幅度
    shake.fromValue = [NSNumber numberWithFloat:-0.1];
    shake.toValue = [NSNumber numberWithFloat:+0.1];
    shake.duration = 0.06;
    shake.autoreverses = YES; //是否重复
    shake.repeatCount = 3;
    [self.layer addAnimation:shake forKey:@"XYShake"];
}

//动画Z轴旋转
- (void) animationZRotate:(NSString *)key {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    // 设定动画选项
    animation.duration = 1.5; // 持续时间
    animation.repeatCount = MAXFLOAT; // 重复次数
    // 设定旋转角度
    animation.fromValue = [NSNumber numberWithFloat:0.0]; // 起始角度
    animation.toValue = [NSNumber numberWithFloat:2 * M_PI]; // 终止角度
    // 添加动画
    [self.layer addAnimation:animation forKey:key];
}

- (void) removeAnimation:(NSString *)key {
    [self.layer removeAnimationForKey:key];
}

- (void)showAnimationType:(NSString *)type withSubType:(NSString *)subType duration:(CFTimeInterval)duration timingFunction:(NSString *)timingFunction view:(UIView *)theView {
    /* CATransition
     *
     */
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = duration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:timingFunction];
    animation.fillMode = kCAFillModeForwards;
    // animation.removedOnCompletion = NO;
    /** type
    *
    *  各种动画效果  其中除了'fade', `moveIn', `push' , `reveal' ,其他属于私有的API(我是这么认为的,可以点进去看下注释).
    *  ↑↑↑上面四个可以分别使用'kCATransitionFade', 'kCATransitionMoveIn', 'kCATransitionPush', 'kCATransitionReveal'来调用.
    *  @"cube"                     立方体翻滚效果
    *  @"moveIn"                   新视图移到旧视图上面
    *  @"reveal"                   显露效果(将旧视图移开,显示下面的新视图)
    *  @"fade"                     交叉淡化过渡(不支持过渡方向)             (默认为此效果)
    *  @"pageCurl"                 向上翻一页
    *  @"pageUnCurl"               向下翻一页
    *  @"suckEffect"               收缩效果，类似系统最小化窗口时的神奇效果(不支持过渡方向)
    *  @"rippleEffect"             滴水效果,(不支持过渡方向)
    *  @"oglFlip"                  上下左右翻转效果
    *  @"rotate"                   旋转效果
    *  @"push"
    *  @"cameraIrisHollowOpen"     相机镜头打开效果(不支持过渡方向)
    *  @"cameraIrisHollowClose"    相机镜头关上效果(不支持过渡方向)
    *
    
    ** type
    *
    *  kCATransitionFade            交叉淡化过渡
    *  kCATransitionMoveIn          新视图移到旧视图上面
    *  kCATransitionPush            新视图把旧视图推出去
    *  kCATransitionReveal          将旧视图移开,显示下面的新视图
    */
    animation.type = type;
    /** subtype
    *
    *  各种动画方向
    *
    *  kCATransitionFromRight;      同字面意思(下同)
    *  kCATransitionFromLeft;
    *  kCATransitionFromTop;
    *  kCATransitionFromBottom;
    *
    ** subtype
    *
    *  当type为@"rotate"(旋转)的时候,它也有几个对应的subtype,分别为:
    *  90cw    逆时针旋转90°
    *  90ccw   顺时针旋转90°
    *  180cw   逆时针旋转180°
    *  180ccw  顺时针旋转180°
    *
    
    **
    *  type与subtype的对应关系(必看),如果对应错误,动画不会显现.
    
    animation.subtype = subType;
    
    **
    *  所有核心动画和特效都是基于CAAnimation,而CAAnimation是作用于CALayer的.所以把动画添加到layer上.
    *  forKey  可以是任意字符串.
    */
    
    [theView.layer addAnimation:animation forKey:nil];
}

//pragma mark - Preset Animation
- (void)animationRevealFromBottom {
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.35f];
    [animation setType:kCATransitionReveal];
    [animation setSubtype:kCATransitionFromBottom];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    
    [self.layer addAnimation:animation forKey:nil];
}

- (void)animationRevealFromTop {
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.35f];
    [animation setType:kCATransitionReveal];
    [animation setSubtype:kCATransitionFromTop];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    
    [self.layer addAnimation:animation forKey:nil];
}

- (void)animationRevealFromLeft {
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.35f];
    [animation setType:kCATransitionReveal];
    [animation setSubtype:kCATransitionFromLeft];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [self.layer addAnimation:animation forKey:nil];
}

- (void)animationRevealFromRight {
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.35f];
    [animation setType:kCATransitionReveal];
    [animation setSubtype:kCATransitionFromRight];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [self.layer addAnimation:animation forKey:nil];
}

- (void)animationEaseIn {
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.35f];
    [animation setType:kCATransitionFade];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    
    [self.layer addAnimation:animation forKey:nil];
}

- (void)animationEaseOut {
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.35f];
    [animation setType:kCATransitionFade];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    
    [self.layer addAnimation:animation forKey:nil];
}



- (void)animationFlipFromLeft {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.35f];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self cache:NO];
    [UIView commitAnimations];
}

- (void)animationFlipFromRigh {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.35f];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self cache:NO];
    [UIView commitAnimations];
}

- (void)animationCurlUp {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:0.35f];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self cache:NO];
    [UIView commitAnimations];
}

- (void)animationCurlDown {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.35f];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self cache:NO];
    [UIView commitAnimations];
}

- (void)animationPushUp {
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.35f];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromTop];
    
    [self.layer addAnimation:animation forKey:nil];
}

- (void)animationPushDown {
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.35f];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromBottom];
    
    [self.layer addAnimation:animation forKey:nil];
}

- (void)animationPushLeft {
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.35f];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromLeft];
    
    [self.layer addAnimation:animation forKey:nil];
}

- (void)animationPushRight {
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.35f];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromRight];
    
    [self.layer addAnimation:animation forKey:nil];
}

// presentModalViewController
- (void)animationMoveUpWithDuration:(CFTimeInterval)duration {
    CATransition *animation = [CATransition animation];
    [animation setDuration:duration];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setType:kCATransitionMoveIn];
    [animation setSubtype:kCATransitionFromTop];
    [self.layer addAnimation:animation forKey:nil];
}

// dissModalViewController
- (void)animationMoveDownWithDuration:(CFTimeInterval)duration {
    CATransition *transition = [CATransition animation];
    transition.duration = duration;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromBottom;
    [self.layer addAnimation:transition forKey:nil];
}

- (void)animationMoveLeftWithDuration:(CFTimeInterval)duration {
    CATransition *animation = [CATransition animation];
    [animation setDuration:duration];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:kCATransitionMoveIn];
    [animation setSubtype:kCATransitionFromLeft];
    
    [self.layer addAnimation:animation forKey:nil];
}

- (void)animationMoveRightWithDuration:(CFTimeInterval)duration {
    CATransition *animation = [CATransition animation];
    [animation setDuration:duration];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:kCATransitionMoveIn];
    [animation setSubtype:kCATransitionFromRight];
    
    [self.layer addAnimation:animation forKey:nil];
}
- (void)animationRotateAndScaleDownUp {
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:(2 * M_PI) * 2];
    rotationAnimation.duration = 0.35f;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.toValue = [NSNumber numberWithFloat:0.0];
    scaleAnimation.duration = 0.35f;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = 0.35f;
    animationGroup.autoreverses = YES;
    animationGroup.repeatCount = 1;
    animationGroup.animations =[NSArray arrayWithObjects:rotationAnimation, scaleAnimation, nil];
    [self.layer addAnimation:animationGroup forKey:@"animationGroup"];
}


-(void)animationFlipFromTop {
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.35f];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"oglFlip"];
    [animation setSubtype:@"fromTop"];
    
    [self.layer addAnimation:animation forKey:nil];
}

- (void)animationFlipFromBottom {
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.35f];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"oglFlip"];
    [animation setSubtype:@"fromBottom"];
    
    [self.layer addAnimation:animation forKey:nil];
}

- (void)animationCubeFromLeft {
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.35f];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"cube"];
    [animation setSubtype:@"fromLeft"];
    
    [self.layer addAnimation:animation forKey:nil];
}

- (void)animationCubeFromRight {
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.35f];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"cube"];
    [animation setSubtype:@"fromRight"];
    
    [self.layer addAnimation:animation forKey:nil];
}

- (void)animationCubeFromTop {
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.35f];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"cube"];
    [animation setSubtype:@"fromTop"];
    
    [self.layer addAnimation:animation forKey:nil];
}

- (void)animationCubeFromBottom {
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.35f];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"cube"];
    [animation setSubtype:@"fromBottom"];
    
    [self.layer addAnimation:animation forKey:nil];
}

- (void)animationSuckEffect {
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.35f];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"suckEffect"];
    
    [self.layer addAnimation:animation forKey:nil];
}

- (void)animationRippleEffect {
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.35f];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"rippleEffect"];
    
    [self.layer addAnimation:animation forKey:nil];
}

- (void)animationCameraOpen {
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.35f];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"cameraIrisHollowOpen"];
    [animation setSubtype:@"fromRight"];
    [self.layer addAnimation:animation forKey:nil];
}

- (void)animationCameraClose {
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.35f];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"cameraIrisHollowClose"];
    [animation setSubtype:@"fromRight"];
    
    [self.layer addAnimation:animation forKey:nil];
}

@end
