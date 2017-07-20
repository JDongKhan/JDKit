//
//  UIImageView+jd_gif.h
//  TLAttributedLabel
//
//  Created by wjd on 15/8/8.
//  Copyright (c) 2015年 wjd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (jd_gif)

// 从指定的路径加载GIF并创建UIImageView
+ (UIImageView *)imageViewWithGIFFile:(NSString *)file frame:(CGRect)frame;

@end
