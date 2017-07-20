//
//  NSMutableArray+jd_convenience.h
//
//  Created by  wjd on 5/10/12.
//  Copyright (c) 2012 wjd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (jd_convenience)

//将from下的对象 移到to位置
- (void)moveObjectFromIndex:(NSUInteger)from toIndex:(NSUInteger)to;

@end
