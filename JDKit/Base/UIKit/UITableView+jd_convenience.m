//
//  UITableView+jd_convenience.m
//
//
//  Created by wjd on 14-1-13.
//  Copyright (c) 2014年 wjd. All rights reserved.
//

#import "UITableView+jd_convenience.h"

@implementation UITableView (jd_convenience)

@dynamic separatorInsetAtIos7;

- (void)setSeparatorInsetAtIos7:(UIEdgeInsets)separatorInsetAtIos7{
    BOOL IOS7ORLate = [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0;
    if(IOS7ORLate){
        self.separatorInset = separatorInsetAtIos7;
    }
    if ([self respondsToSelector:@selector(layoutMargins)]) {
        self.layoutMargins = separatorInsetAtIos7;
    }
}

- (UIEdgeInsets)separatorInsetAtIos7{
    BOOL IOS7ORLate = [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0;
    if(IOS7ORLate){
        return self.separatorInset;
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

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
