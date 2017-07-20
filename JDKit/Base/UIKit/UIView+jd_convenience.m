//
//  UIView+jd_convenience.m
//
//  Created by wjd on 12/1/11.
//  Copyright (c) 2011 wjd. All rights reserved.
//

#import "UIView+jd_convenience.h"
#import "NSObject+jd_convenience.h"
#import <objc/runtime.h>

static const void *ktapBlock = &ktapBlock;

@implementation UIView (jd_convenience)


//是否包含某一个view
- (BOOL)containsSubView:(UIView *)subView {
    for (UIView *view in [self subviews]) {
        if ([view isEqual:subView]) {
            return YES;
        }
    }
    return NO;
}
//是否包含某一类view
- (BOOL)containsSubViewOfClassType:(Class)clazz {
    for (UIView *view in [self subviews]) {
        if ([view isMemberOfClass:clazz]) {
            return YES;
        }
    }
    return NO;
}

- (UIViewController *)topViewController {
    UIResponder *firstResponder = [self nextResponder];
    while (true && firstResponder != nil) {
        if([firstResponder isKindOfClass:[UIViewController class]]){
            return (UIViewController *)firstResponder;
        }
        firstResponder = [firstResponder nextResponder];
    }
    return nil;
}

#pragma mark touch

//增加点击手势
- (void)addTapGesture:(id)target action:(SEL)action {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
}
- (void)addTapGesture:(void(^)(id sender))tapBlock {
    
    objc_setAssociatedObject(self, ktapBlock, tapBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBlock:)];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
}
- (void)tapBlock:(UIGestureRecognizer *)gesture {
    void(^tapBlock)(id sender) = objc_getAssociatedObject(self, ktapBlock);
    if (tapBlock) {
        tapBlock(self);
    }
}
//增加长按手势
- (void)addLongPressGesture:(id)target action:(SEL)action {
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:target action:action];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:longPress];
}
//增加pan手势
- (void)addPanGesture:(id)target action:(SEL)action {
    UIPanGestureRecognizer *tap = [[UIPanGestureRecognizer alloc] initWithTarget:target action:action];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
}
//移除手势
- (void)removeGesture {
    for (UIGestureRecognizer *gesture in self.gestureRecognizers) {
        [self removeGestureRecognizer:gesture];
    }
}

// 圆形
- (instancetype)rounded {
    self.clipsToBounds = YES;
    CGFloat min = self.bounds.size.width > self.bounds.size.height?self.bounds.size.height:self.bounds.size.width;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, min, min);
    self.layer.cornerRadius = min / 2;
    return self;
}

// 圆角矩形, corners:一个矩形的四个角。
- (instancetype)roundedRectWith:(CGFloat)radius {
    self.clipsToBounds = YES;
    self.layer.cornerRadius = radius;
    
    return self;
}
- (instancetype)roundedRectWith:(CGFloat)radius byRoundingCorners:(UIRectCorner)corners {
    UIBezierPath * maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer * maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    return self;
}
//阴影
- (void)setShadow : (UIColor *)color opacity:(CGFloat)opacity offset:(CGSize)offset blurRadius:(CGFloat)blurRadius {
	CALayer *l = self.layer;
	l.shadowColor = [color CGColor];
	l.shadowOpacity = opacity;
	l.shadowOffset = offset;
	l.shadowRadius = blurRadius;
}


- (instancetype)borderWidth:(CGFloat)width color:(UIColor *)color {
    self.layer.borderWidth = width;
    if (color) {
        self.layer.borderColor = color.CGColor;
    }
    return self;
}

#pragma mark function

- (void)addSubview:(UIView *)view alignment:(JDViewAlignment)alignment {
    [self addSubview:view alignment:alignment offset:CGPointMake(0, 0)];
}
- (void)addSubview:(UIView *)view alignment:(JDViewAlignment)alignment offset:(CGPoint)offset {
    CGRect frame = view.frame;
    //左上
    if(alignment == (JDViewAlignmentLeft |JDViewAlignmentTop)){
        frame.origin.x = 0.0f+offset.x;
        frame.origin.y = 0.0f+offset.y;
    }else if(alignment == (JDViewAlignmentLeft | JDViewAlignmentCenter)){//左中
        frame.origin.x = 0.0f+offset.x;
        frame.origin.y = (self.frame.size.height-frame.size.height)/2.0f+offset.y;
    }else if(alignment == (JDViewAlignmentLeft | JDViewAlignmentBottom)){//左下
        frame.origin.x = 0.0f+offset.x;
        frame.origin.y = self.frame.size.height-frame.size.height+offset.y;
    }else if(alignment == (JDViewAlignmentCenter | JDViewAlignmentTop)){//中上
        frame.origin.x = (self.frame.size.width-frame.size.width)/2.0f;
        frame.origin.y = 0.0f+offset.y;
    }else if(alignment == JDViewAlignmentCenter){//中中
        frame.origin.x = (self.frame.size.width-frame.size.width)/2.0f+offset.x;
        frame.origin.y = (self.frame.size.height-frame.size.height)/2.0f+offset.y;
    }else if(alignment == (JDViewAlignmentCenter | JDViewAlignmentBottom)){// 中下
        frame.origin.x = (self.frame.size.width-frame.size.width)/2.0f+offset.x;
        frame.origin.y = self.frame.size.height-frame.size.height+offset.y;
    }else if(alignment == (JDViewAlignmentRight | JDViewAlignmentTop )){//右上
        frame.origin.x = self.frame.size.width-frame.size.width+offset.x;
        frame.origin.y = 0.0f+offset.y;
    }else if(alignment == (JDViewAlignmentRight | JDViewAlignmentCenter) ){//右中
        frame.origin.x = self.frame.size.width-frame.size.width+offset.x;
        frame.origin.y = (self.frame.size.height-frame.size.height)/2.0f+offset.y;
    }else if(alignment == (JDViewAlignmentRight | JDViewAlignmentBottom)){//右下
        frame.origin.x = self.frame.size.width-frame.size.width+offset.x;
        frame.origin.y = self.frame.size.height-frame.size.height+offset.y;
    }else if(alignment == JDViewAlignmentLeft){
        frame.origin.x = 0.0f+offset.x;
    }else if(alignment == JDViewAlignmentRight){
        frame.origin.x = self.frame.size.width-frame.size.width+offset.x;
    }else if(alignment == JDViewAlignmentTop){
        frame.origin.y = 0.0f+offset.y;
    }else if(alignment == JDViewAlignmentBottom){
        frame.origin.y = self.frame.size.height-frame.size.height+offset.y;
    }
    view.frame = frame;
    [self addSubview:view];
}

//截屏
- (UIImage *)snapShot {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


#pragma mark 操作结构树
//得到自己在父view的位置
- (NSInteger)locationAtSuperView {
    for (NSInteger i = 0 ; i<self.superview.subviews.count; i ++) {
        UIView *subView = self.superview.subviews[i];
        if(subView == self)
            return i;
    }
    return -1;
}

//移除子视图
- (void)removeSubView {
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
}
- (void)removeSubViewWithTag:(NSInteger)tag {
    for (UIView *subView in self.subviews) {
        if(subView.tag == tag){
            [subView removeFromSuperview];
        }
    }
}

#pragma mark -todo attribute
- (void)showDataWithDic:(NSDictionary *)dic {
    if (dic) {
        [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            id tempObj = [self valueForKeyPath:key];
            if ([tempObj isKindOfClass:[UILabel class]]) {
                NSString *str = [obj UTF8EncodingString];
                [tempObj setText:str];
            }else if([tempObj isKindOfClass:[UIImageView class]]) {
                if ([obj isKindOfClass:[UIImage class]]) {
                    [tempObj setValue:obj forKey:@"image"];
                } else if ([obj isKindOfClass:[NSString class]]){
                    UIImage *tempImg = [UIImage imageNamed:obj];
                    [tempObj setValue:tempImg forKey:@"image"];
                }
            } else if (1) {
                [self setValue:obj forKeyPath:key];
            }
        }];
    }
}

@end

