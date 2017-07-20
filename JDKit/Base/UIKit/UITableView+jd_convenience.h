//
//  UITableView+jd_convenience.h
//
//
//  Created by wjd on 14-1-13.
//  Copyright (c) 2014年 wjd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (jd_convenience)

//设置tableview的分隔线左边偏距
@property (nonatomic) UIEdgeInsets separatorInsetAtIos7;

//去除多余的分隔线
- (void)setExtraCellLineHidden;

//取消选中状态
- (void)deselectCurrentRow;

@end
