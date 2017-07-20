//
//  UIButton+jd_convenience.h
//  
//
//  Created by 王金东 on 14-11-5.
//  Copyright (c) 2014年 王金东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (jd_convenience)

/**
 *  button.title
 */
@property (nonatomic, copy) NSString *title;

- (void)addTapClick:(void(^)(id sender))tapBlock;

@end
