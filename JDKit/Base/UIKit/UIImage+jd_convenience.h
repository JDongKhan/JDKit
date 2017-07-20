//
//  UIImage+jd_convenience.h
//  
//
//  Created by wjd on 14-4-19.
//  Copyright (c) 2014年 wjd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ArrowsDirection){
    ArrowsDirectionUp,      //三角朝上
    ArrowsDirectionDown,    //三角朝下
    ArrowsDirectionLeft,    //三角朝左
    ArrowsDirectionRight,   //三角朝右
};

@interface UIImage (jd_convenience)

/**
 *  缩放大小
 *
 *  @param size size的尺寸
 *
 *  @return 缩放后的UIImage
 */
- (UIImage *)scaleToSize:(CGSize )size;

/**
 *从图片中按指定的位置大小截取图片的一部分
 * CGRect rect 要截取的区域
 */
- (UIImage *)imageInRect:(CGRect)rect;

//缩放倍数
- (UIImage *)scaleMultiple:(CGFloat )multiple;

//改变图片颜色 对于纯色用该方法
- (UIImage *)imageWithTintColor:(UIColor *)color;

//保留灰度信息 对于非纯色用该方法
- (UIImage *) imageWithGradientTintColor:(UIColor *)tintColor;

//保留透明度信息
- (UIImage *) imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode;

/**
 *	@brief	生成image中出现最多的颜色
 *	@return
 */
- (UIColor*)mostColor;

/*
 1.白色,参数:
 透明度 0~1,  0为白,   1为深灰色
 半径:默认30,推荐值 3   半径值越大越模糊 ,值越小越清楚
 色彩饱和度(浓度)因子:  0是黑白灰, 9是浓彩色, 1是原色  默认1.8
 “彩度”，英文是称Saturation，即饱和度。将无彩色的黑白灰定为0，最鲜艳定为9s，这样大致分成十阶段，让数值和人的感官直觉一致。
 */
- (UIImage *)imageBluredWithLightAlpha:(CGFloat)alpha radius:(CGFloat)radius colorSaturationFactor:(CGFloat)colorSaturationFactor;

//模糊图片
- (UIImage *)imageBlured;
- (UIImage *)imageBluredWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;


- (UIImage *)imageWithBlurLevel:(CGFloat)level;
#pragma mark -----------------我是分割线----------
// 根据颜色生成uiimage
+ (UIImage *)createImageWithColor:(UIColor*)color;
// 根据颜色生成uiimage 并指定大小
+ (UIImage *)createImageWithColor:(UIColor *)color size:(CGSize)size;

//创建虚线
+ (UIImage *)createDashImage:(UIColor *)color;

//画椭圆
+ (UIImage *)createEllipseImage:(UIColor *)color inSize:(CGSize)size;

//画圆角矩形
+ (UIImage *)createCornerArc:(UIColor *)color radius:(CGFloat)radius  inSize:(CGSize)size;

//创建三角指示器
+ (UIImage *)createArrowsImage:(UIColor *)color direction:(ArrowsDirection)direction inSize:(CGSize)size;


@end
