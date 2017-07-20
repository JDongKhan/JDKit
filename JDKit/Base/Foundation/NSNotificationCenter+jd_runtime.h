//
//  NSNotificationCenter+jd_runtime.h
//  
//
//  Created by 王金东 on 14-8-28.
//  Copyright (c) 2014年 王金东. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNotificationCenter (jd_runtime)
/**
 *  添加观察者
 *
 *  @param observer 观察者
 *  @param name     名字
 *  @param block    block
 */
- (void)addObserver:(id)observer forName:(NSString *)name withNotifyBlock:(void(^)(NSNotification *note))block;


@end
