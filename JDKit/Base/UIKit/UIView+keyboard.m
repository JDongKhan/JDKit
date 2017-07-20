//
//  UIView+keyboard.m
//  JDKit
//
//  Created by 王金东 on 2017/7/20.
//  Copyright © 2017年 王金东. All rights reserved.
//

#import "UIView+keyboard.h"
#import "UIView+jd_convenience.h"

@implementation UIView (keyboard)
@dynamic tapForDismissKeyboard;


#pragma mark 增加点击空白区域取消键盘
// 隐藏方法的具体实现
- (void)setTapForDismissKeyboard:(BOOL)tapForDismissKeyboard {
    if(tapForDismissKeyboard){
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];    //创建一个通知
        // 添加单击手势
        UITapGestureRecognizer *singleTapGR =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(tapAnywhereToDismissKeyboard:)];    // 创建一个线程池
        NSOperationQueue *mainQuene =[NSOperationQueue mainQueue];
        // 通过通知用来监听键盘的的显示和隐藏
        __weak typeof (self) weakSelf = self;
        [nc addObserverForName:UIKeyboardWillShowNotification
                        object:nil
                         queue:mainQuene
                    usingBlock:^(NSNotification *note){
                        [weakSelf addGestureRecognizer:singleTapGR];
                    }];
        [nc addObserverForName:UIKeyboardWillHideNotification
                        object:nil
                         queue:mainQuene
                    usingBlock:^(NSNotification *note){
                        [weakSelf removeGestureRecognizer:singleTapGR];
                    }];
    }else{
        [self removeGesture];
    }
}

// 点击任何地方都将隐藏键盘
- (void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer {
    //[self becomeFirstResponder];
    // 此方法会将self.view里所有的subview的first responder都resign掉
    [self endEditing:YES];
}




/**
 ** 关闭键盘
 **/
- (void)closeKeyBoard {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}



@end
