//
//  NSDictionary+jd_convenience.h
//  
//
//  Created by jd on 14-5-12.
//  Copyright (c) 2014年 jd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (jd_convenience)


/*!
 字典对象转为实体对象

 @param entity 实体类
 */
- (void)dictionaryToEntity:(NSObject *)entity;

/*!
 实体对象转为字典对象

 @param entity 实体对象
 */
+ (NSDictionary *)entityToDictionary:(id)entity;

/*!
 将NSDictionary 转换为NSMutableDictionary
 */
- (NSMutableDictionary *)toMutableDictionary;

/*!
 排除null 和 NSNull

 @param key key
 */
- (id)entityForKey:(NSString *)key;

/*!
 去除null,<null>

 @param dictionary 字典
 */
+ (instancetype)toTrimNill:(NSDictionary *)dictionary;

/*!
 从文件中取出字典

 @param fileName 文件名称
 @param ext 后缀
 */
+ (instancetype)dictionaryWithBundleNameForResource:(NSString *)fileName ofType:(NSString *)ext;
+ (instancetype)dictionaryWithBundleNameForResource:(NSString *)fileName ofType:(NSString *)ext bundle:(NSBundle *)bundle;


@end

NS_ASSUME_NONNULL_END
