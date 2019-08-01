//
//  UIImage+jd_convenience.h
//  
//
//  Created by JD on 14-4-19.
//  Copyright (c) 2014年 JD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ArrowsDirection){
    ArrowsDirectionUp,      //三角朝上
    ArrowsDirectionDown,    //三角朝下
    ArrowsDirectionLeft,    //三角朝左
    ArrowsDirectionRight,   //三角朝右
};

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (jd_convenience)

/**
 缩放大小
 
@param size size的尺寸
@return 缩放后的UIImage
*/
- (UIImage *)scaleToSize:(CGSize )size;

/**
 缩放倍数
 
 @param multiple 缩放倍数
 */
- (UIImage *)scaleMultiple:(CGFloat )multiple;

/**
 从图片中按指定的位置大小截取图片的一部分
 
 @param rect 要截取的区域
 */
- (UIImage *)imageInRect:(CGRect)rect;

/**
 改变图片颜色 对于纯色用该方法

 @param color 着色的颜色
 */
- (UIImage *)imageWithTintColor:(UIColor *)color;


/**
 保留灰度信息 对于非纯色用该方法

 @param tintColor 灰度颜色
 */
- (UIImage *)imageWithGradientTintColor:(UIColor *)tintColor;

/**
 保留透明度信息

 @param tintColor  着色的颜色
 @param blendMode CGBlendMode
 */
- (UIImage *)imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode;

/**
生成image中出现最多的颜色
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


/**
 模糊图片
 */
- (UIImage *)imageBlured;
- (UIImage *)imageBluredWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage * _Nullable )maskImage;


/**
 模糊图片

 @param level 模糊的级别 0-1
 */
- (UIImage *)imageWithBlurLevel:(CGFloat)level;

/**
 根据颜色生成uiimage

 @param color 颜色
 */
+ (UIImage *)createImageWithColor:(UIColor*)color;

/**
 根据颜色生成uiimage 并指定大小

 @param color 颜色
 @param size 尺寸
 */
+ (UIImage *)createImageWithColor:(UIColor *)color size:(CGSize)size;

/**
 创建虚线

 @param color 颜色
 */
+ (UIImage *)createDashImage:(UIColor *)color;

/**
 画椭圆

 @param color 颜色
 @param size 尺寸
 */
+ (UIImage *)createEllipseImage:(UIColor *)color inSize:(CGSize)size;

/**
 画圆角矩形

 @param color 颜色
 @param radius 圆角
 @param size 尺寸
 */
+ (UIImage *)createCornerArc:(UIColor *)color radius:(CGFloat)radius  inSize:(CGSize)size;

/**
 创建三角指示器

 @param color 颜色
 @param direction 方向
 @param size 尺寸
 */
+ (UIImage *)createArrowsImage:(UIColor *)color direction:(ArrowsDirection)direction inSize:(CGSize)size;


@end

NS_ASSUME_NONNULL_END
