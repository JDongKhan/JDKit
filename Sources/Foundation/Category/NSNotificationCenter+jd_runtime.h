//
//  NSNotificationCenter+jd_runtime.h
//  
//
//  Created by jd on 14-8-28.
//  Copyright (c) 2014年 jd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSNotificationCenter (jd_runtime)


/*!
 *  添加观察者
 *
 *  @param observer 观察者
 *  @param name     名字
 *  @param block    block
 */
- (void)addObserver:(id)observer forName:(NSString *)name withNotifyBlock:(void(^)(NSNotification *note))block;

@end

NS_ASSUME_NONNULL_END
