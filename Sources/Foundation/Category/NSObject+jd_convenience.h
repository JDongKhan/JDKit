//
//  NSObject+jd_convenience.h
//
//
//  Created by jd on 14-6-12.
//  Copyright (c) 2014年 jd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (jd_convenience)


/*!
 从object里面读取key存储的值

 @param key key
 */
- (id)associatedObjectForKey:(NSString*)key;

/*!
 往object里存储key的值

 @param object 存储的值的对象
 @param key key
 */
- (void)setAssociatedObject:(id)object forKey:(NSString*)key;

/*!
 解析属性成字符串
 */
#pragma mark
- (NSString*)autoDescription;

/*!
 处理空对象
 */
+ (instancetype)toTrimNull:(id)obj;

/*!
 判断是否为空
 */
+ (BOOL)isNullObject:(id)obj;

/*!
 判断是否为空
 */
+ (BOOL)isEmptyObject:(id)obj;

/*!
 将对象转换为json字符串
 */
- (NSString *)toJSONString;

/*!
 json字符串转对象
 */
+ (id)jsonToObject:(NSString *)jsonString;

/*!
 将对象转换成utf8格式的字符串
 */
- (NSString *)UTF8EncodingString;

/*!
 对象里面值拷贝
 */
- (void)copyValueFromObject:(id)object;

@end

NS_ASSUME_NONNULL_END
