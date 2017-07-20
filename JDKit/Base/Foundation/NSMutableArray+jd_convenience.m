
//
//  NSMutableArray+jd_convenience.m
//
//  Created by wjd on 5/10/12.
//  Copyright (c) 2012 wjd. All rights reserved.
//

#import "NSMutableArray+jd_convenience.h"



@implementation NSMutableArray (jd_convenience)

- (void)moveObjectFromIndex:(NSUInteger)from toIndex:(NSUInteger)to {
    if (to != from) {
        id obj = [self objectAtIndex:from];
        [self removeObjectAtIndex:from];
        if (to >= [self count]) {
            [self addObject:obj];
        } else {
            [self insertObject:obj atIndex:to];
        }
    }
}

@end
