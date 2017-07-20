//
//  NSDictionary+jd_convenience.h
//  
//
//  Created by wjd on 14-5-12.
//  Copyright (c) 2014年 wjd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (jd_convenience)

//字典对象转为实体对象
- (void)dictionaryToEntity:(NSObject*)entity;

//实体对象转为字典对象
+ (NSDictionary *)entityToDictionary:(id)entity;

//将NSDictionary 转换为NSMutableDictionary
- (NSMutableDictionary *)toMutableDictionary;

//排除null 和 NSNull
- (id)entityForKey:(NSString *)key;

+ (instancetype)toTrimNill:(NSDictionary *)dictionary;

// 从文件中取出字典
+ (instancetype)dictionaryWithBundleNameForResource:(NSString *)fileName ofType:(NSString *)ext;
+ (instancetype)dictionaryWithBundleNameForResource:(NSString *)fileName ofType:(NSString *)ext bundle:(NSBundle *)bundle;


@end
