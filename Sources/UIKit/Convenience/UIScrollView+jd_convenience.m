//
//  UIScrollView+jd_convenience.m
//
//
//  Created by JD on 14-11-6.
//  Copyright (c) 2014年 JD. All rights reserved.
//

#import "UIScrollView+jd_convenience.h"
#import <objc/runtime.h>

#undef	UIScrollView_key_decelerating
#define UIScrollView_key_decelerating	"UIScrollView.decelerating"

#undef	UIScrollView_key_scrolling
#define UIScrollView_key_scrolling	"UIScrollView.scrolling"

@implementation UIScrollView (jd_convenience)

- (void)addPageItemArray:(NSArray *)itemArray{
    [self addPageItemArray:itemArray orientation:JDScrollViewHorizontal];
}
- (void)addPageItemArray:(NSArray *)itemArray orientation:(JDScrollViewOrientation)orientation{
    self.pagingEnabled = YES;
    
    CGFloat x= 0.0f ;
    CGFloat y = 0.0f;
    CGFloat width = 0.0f;
    CGFloat height = 0.0f;
    CGFloat contentWidth = 0.0f;
    CGFloat contentHeight = 0.0f;
    for (UIView *view in itemArray) {
        width = view.frame.size.width;
        height = view.frame.size.height;
        view.frame = CGRectMake(x, y, width, height);
        if (orientation == JDScrollViewHorizontal) {
            x += width;
            contentWidth += width;
            contentHeight = contentHeight>height?contentHeight:height;
        }else{
            y += height;
            contentWidth = contentWidth > width ? contentWidth : width;
            contentHeight += height;
        }
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self addSubview:view];
    }
    self.contentSize = CGSizeMake(contentWidth, contentHeight);
  
}

- (void)handScrollViewDidEndDecelerating:(UIScrollView_block_self)deceleratingBlock{
    self.delegate = self;
    objc_setAssociatedObject(self, UIScrollView_key_decelerating, deceleratingBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


- (void)handScrollViewDidScroll:(UIScrollView_block_self)deceleratingBlock{
    self.delegate = self;
    objc_setAssociatedObject(self, UIScrollView_key_scrolling, deceleratingBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    UIScrollView_block_self block = objc_getAssociatedObject(self,UIScrollView_key_scrolling);
    if (block) block(scrollView);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    UIScrollView_block_self block = objc_getAssociatedObject(self,UIScrollView_key_decelerating);
    if (block) block(scrollView);
}

@end
