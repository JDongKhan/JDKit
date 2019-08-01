//
//  UIView+jd_convenience.h
//
//  Created by JD on 12/1/11.
//  Copyright (c) 2011 JD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger,JDViewAlignment) {
    JDViewAlignmentNoe = 0,             //子view位置默认
    JDViewAlignmentTop = 1 << 0,        //子view居上
    JDViewAlignmentBottom = 1 << 1,     //子view居底
    JDViewAlignmentCenter = 1 << 2,     //子view居中
    JDViewAlignmentLeft = 1 << 3,       //子view居左
    JDViewAlignmentRight = 1 << 4,      //子view居右
} ;

NS_ASSUME_NONNULL_BEGIN

@interface UIView (jd_convenience)

/**
 获取该view所在的顶层VC
 */
@property (nonatomic,strong,readonly) UIViewController *topViewController;


#pragma mark --------------------------touch--------------------------

/**
 增加点击手势

 @param target target
 @param action action
 */
- (void)addTapGesture:(id)target action:(SEL)action;
- (void)addTapGesture:(void(^)(id sender))tapBlock;

/**
 增加长按手势

 @param target target
 @param action action
 */
- (void)addLongPressGesture:(id)target action:(SEL)action;

/**
 增加pan手势

 @param target target
 @param action action
 */
- (void)addPanGesture:(id)target action:(SEL)action;

/**
 移除手势
 */
- (void)removeGesture;

#pragma ------ mark style ------

/**
 圆形
 */
- (instancetype)rounded;

/**
 圆角矩形, corners:一个矩形的四个角。

 @param radius 圆角
 */
- (instancetype)roundedRectWith:(CGFloat)radius;
- (instancetype)roundedRectWith:(CGFloat)radius byRoundingCorners:(UIRectCorner)corners;

/**
 加阴影 color:shadowColor  opacity:shadowOpacity offset:shadowOffset blurRadius:shadowRadius

 @param color 阴影颜色
 @param opacity 透明度
 @param offset 偏移
 @param blurRadius 模糊度数
 */
- (void)setShadow:(UIColor *)color
          opacity:(CGFloat)opacity
           offset:(CGSize)offset
       blurRadius:(CGFloat)blurRadius;


/**
 边框大小,颜色

 @param width 边框宽度
 @param color 边框颜色
 */
- (instancetype)borderWidth:(CGFloat)width color:(UIColor *)color;

#pragma mark -------------------------- function ---------------------------------

- (void)addSubview:(UIView *)subview alignment:(JDViewAlignment)alignment;

- (void)addSubview:(UIView *)subview alignment:(JDViewAlignment)alignment offset:(CGPoint)offset;

/**
 截屏
 */
- (UIImage *)snapShot;

#pragma mark --------------------------操作结构树--------------------------

/**
 是否包含某个view

 @param subView 子view
 */
- (BOOL)containsSubView:(UIView *)subView;

/**
 是否包含某一类view

 @param clazz 子view的class
 */
- (BOOL)containsSubViewOfClassType:(Class)clazz;

/**
 在父视图的位置
 */
- (NSInteger)locationAtSuperView;

/**
 移除所有子视图
 */
- (void)removeaAllSubView;

/**
 移除某个子view

 @param tag 子view标签
 */
- (void)removeSubViewWithTag:(NSInteger)tag;

#pragma mark --------------------------hidden-------------------------

- (void)hideView:(BOOL)hidden byAttributes:(NSLayoutAttribute)attributes,...NS_REQUIRES_NIL_TERMINATION;

/**
 height or width == 0 则隐藏控件
 如果不知道width或height则填负值-1，则只做显示不做值更改

 @param width 宽度
 */
- (void)hiddenWithWidthConstraint:(CGFloat)width;
- (void)hiddenWithHeightConstraint:(CGFloat)height;
- (void)hiddenWithWidthConstraint:(CGFloat)width height:(CGFloat)height;


@end

NS_ASSUME_NONNULL_END
