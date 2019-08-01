//
//  NSArray+jd_convenience.m
//
//
//  Created by jd on 14-6-11.
//  Copyright (c) 2014年 jd. All rights reserved.
//

#import "NSArray+jd_convenience.h"
#import "NSDictionary+jd_convenience.h"

@implementation NSArray (jd_convenience)


- (NSMutableArray *)toMutableArray {
    NSMutableArray *array = [NSMutableArray array];
    for (id item in self) {
        if([item isKindOfClass:[NSDictionary class]]){
            [array addObject:[((NSDictionary *)item) toMutableDictionary]];
        }else if([item isKindOfClass:[NSArray class]]){
            [array addObject:[((NSArray *)item) toMutableArray]];
        }else{
            [array addObject:item];
        }
    }
    return array;
}

#pragma mark - Retrieve objects
- (id)objectBefore:(id)object {
    return [self objectBefore:object
                         wrap:NO];
}

- (id)objectBefore:(id)object wrap:(BOOL)wrap {
    NSUInteger index = [self indexOfObject:object];
    
    if (index == NSNotFound ||                  // Not found?
        (!wrap && index == 0))                  // Or no wrap and was first object?
        return nil;
    
    index = (index - 1 + self.count) % self.count;
    return self[index];
}

- (id)objectAfter:(id)object {
    return [self objectAfter:object
                        wrap:NO];
}

- (id)objectAfter:(id)object  wrap:(BOOL)wrap {
    NSUInteger index = [self indexOfObject:object];
    
    if (index == NSNotFound ||                  // Not found?
        (!wrap && index == self.count - 1))     // Or no wrap and was last object?
        return nil;
    
    index = (index + 1) % self.count;
    return self[index];
}

- (NSString *)shortDescription {
    return [NSString stringWithFormat:@"(%@)", [self componentsJoinedByString:@", "]];
}

+ (instancetype)arrayWithBundleNameForResource:(NSString *)fileName ofType:(NSString *)ext {
    return [NSArray arrayWithBundleNameForResource:fileName ofType:ext bundle:[NSBundle mainBundle]];
}

+ (instancetype)arrayWithBundleNameForResource:(NSString *)fileName ofType:(NSString *)ext bundle:(NSBundle *)bundle {
    NSString *path = [bundle pathForResource:fileName ofType:ext];
    return [NSArray arrayWithContentsOfFile:path];
}

- (NSString *)descriptionWithLocale:(id)locale {
    return [self descriptionPrivate];
}

- (NSString *)debugDescription {
    return [self descriptionPrivate];
}

- (NSString *)descriptionPrivate {
    NSMutableString *str = [NSMutableString stringWithFormat:@"%lu (\n", (unsigned long)self.count];
    
    for (id obj in self) {
        [str appendFormat:@"\t%@, \n", obj];
    }
    
    [str appendString:@")"];
    
    return str;
}


@end
