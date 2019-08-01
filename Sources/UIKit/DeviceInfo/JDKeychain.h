//
//  JDKeychain.h
//  JDFoundation
//
//  Created by jd on 2015/03/04.
//  Copyright (c) 2015 年 jd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIDevice.h>


NS_ASSUME_NONNULL_BEGIN


@interface JDKeychain : NSObject

/**
 存储数据

 @param data 数据
 @param key key
 */
+ (BOOL)saveData:(id)data forKey:(NSString *)key;

/**
 读取数据

 @param key key
 */
+ (nullable id)dataForKey:(NSString *)key;

/**
 删除数据

 @param key key
 */
+ (BOOL)deleteDataForKey:(NSString *)key;

@end


NS_ASSUME_NONNULL_END
