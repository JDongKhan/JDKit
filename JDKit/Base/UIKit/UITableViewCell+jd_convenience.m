//
//  UITableViewCell+jd_convenience.m
//  
//
//  Created by wjd on 14-11-4.
//  Copyright (c) 2014年 wjd. All rights reserved.
//

#import "UITableViewCell+jd_convenience.h"

@implementation UITableViewCell (jd_convenience)

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


@end
