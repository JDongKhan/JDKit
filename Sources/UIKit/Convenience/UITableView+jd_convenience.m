//
//  UITableView+jd_convenience.m
//
//
//  Created by JD on 14-1-13.
//  Copyright (c) 2014年 JD. All rights reserved.
//

#import "UITableView+jd_convenience.h"

@implementation UITableView (jd_convenience)

- (void)setExtraCellLineHidden{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    [self setTableFooterView:view];
}

//取消选中状态
- (void)deselectCurrentRow{
     [self performSelector:@selector(deselect) withObject:nil afterDelay:0.5f];
}

- (void)deselect{
    [self deselectRowAtIndexPath:[self indexPathForSelectedRow] animated:YES];
}

@end
