//
//  NSObject+jd_convenience.h
//
//
//  Created by wjd on 14-6-12.
//  Copyright (c) 2014年 wjd. All rights reserved.
//

#import <Foundation/Foundation.h>

#define IS_NULL_STRING(__POINTER) \
(__POINTER == nil || \
__POINTER == (NSString *)[NSNull null] || \
![__POINTER isKindOfClass:[NSString class]] || \
![__POINTER length])

@interface NSObject (jd_convenience)

#pragma mark 给对象增加额外属性
- (id)associatedObjectForKey:(NSString*)key;

- (void)setAssociatedObject:(id)object forKey:(NSString*)key;

#pragma mark 解析属性成字符串
- (NSString*)autoDescription;

//处理空对象
+ (instancetype)toTrimNull:(id)obj;

//判断是否为空
+ (BOOL)isNullObject:(id)obj;

//判断是否为空
+ (BOOL)isEmptyObject:(id)obj;

//将对象转换为json字符串
- (NSString *)toJSONString;

//json字符串转对象
+ (id)jsonToObject:(NSString *)jsonString;

//将对象转换成utf8格式的字符串
- (NSString *)UTF8EncodingString;

//对象里面值拷贝
- (void)copyValueFromObject:(id)object;

@end
