//
//  UIView+keyboard.h
//  JDKit
//
//  Created by 王金东 on 2017/7/20.
//  Copyright © 2017年 王金东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (keyboard)


//开启点击空白区域取消键盘功能
@property (nonatomic,assign) BOOL tapForDismissKeyboard;


/**
 ** 关闭键盘
 **/
- (void)closeKeyBoard;


@end
