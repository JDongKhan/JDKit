//
//  NSMutableArray+jd_convenience.h
//
//  Created by  jd on 5/10/12.
//  Copyright (c) 2012 jd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray (jd_convenience)


/*!
 将from下的对象 移到to位置

 @param from 开始位置
 @param to 要调换的位置
 */
- (void)moveObjectFromIndex:(NSUInteger)from toIndex:(NSUInteger)to;

/*!
 翻转
 */
- (void)reverse;

/*!
 随机排序
 */
- (void)shuffle;


@end

NS_ASSUME_NONNULL_END
