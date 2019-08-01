//
//  UITableView+jd_convenience.h
//
//
//  Created by JD on 14-1-13.
//  Copyright (c) 2014年 JD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (jd_convenience)


/**
 去除多余的分隔线
 */
- (void)setExtraCellLineHidden;

/**
 取消选中状态
 */
- (void)deselectCurrentRow;

@end

NS_ASSUME_NONNULL_END
