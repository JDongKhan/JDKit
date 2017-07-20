//
//  UIScrollView+jd_convenience.h
//
//
//  Created by 王金东 on 14-11-6.
//  Copyright (c) 2014年 wjd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, JDScrollViewOrientation) {
    JDScrollViewHorizontal,
    JDScrollViewVertical,
};

typedef void(^UIScrollView_block_self)(UIScrollView *scrollView);

@interface UIScrollView (jd_convenience) <UIScrollViewDelegate>

//子view数组
- (void)addPageItemArray:(NSArray *)itemArray;
- (void)addPageItemArray:(NSArray *)itemArray orientation:(JDScrollViewOrientation)orientation;

- (void)handScrollViewDidEndDecelerating:(UIScrollView_block_self)deceleratingBlock;
- (void)handScrollViewDidScroll:(UIScrollView_block_self)deceleratingBlock;

@end
