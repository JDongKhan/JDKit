//
//  NSNotificationCenter+jd_runtime.m
//  
//
//  Created by jd on 14-8-28.
//  Copyright (c) 2014年 jd. All rights reserved.
//

#import "NSNotificationCenter+jd_runtime.h"
#import <objc/runtime.h>

@interface CustomInnerDictionary : NSObject

@property (nonatomic, strong) NSMutableDictionary *mMutableDictionary;

@end

@implementation CustomInnerDictionary

- (id)init {
    self = [super init];
    self.mMutableDictionary = [NSMutableDictionary dictionary];
    return self;
}

- (void)dealloc {
    NSArray *allValues = self.mMutableDictionary.allValues;
    for (id observer in allValues)  {
        [[NSNotificationCenter defaultCenter] removeObserver:observer];
    }
}

@end

@implementation NSNotificationCenter (jd_runtime)

static char customDictionaryKey;

- (void)addObserver:(id)observer forName:(NSString *)name withNotifyBlock:(void(^)(NSNotification *note))block {
    NSOperationQueue *op = [NSOperationQueue mainQueue];
    id innerObserver = [[NSNotificationCenter defaultCenter] addObserverForName:name object:nil queue:op usingBlock:block];
    CustomInnerDictionary *dict = objc_getAssociatedObject(observer, &customDictionaryKey);
    if (!dict) {
        dict = [[CustomInnerDictionary alloc] init];
        objc_setAssociatedObject(observer, &customDictionaryKey, dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [dict.mMutableDictionary setObject:innerObserver forKey:name];
}

@end

