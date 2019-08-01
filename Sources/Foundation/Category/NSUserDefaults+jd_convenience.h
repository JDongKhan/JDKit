//
//  NSUserDefaults+jd_convenience.h
//  
//
//  Created by jd on 14-6-14.
//  Copyright (c) 2014年 jd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSUserDefaults (jd_convenience)


/*!
 保存对象  一行代码就可以了

 @param value value
 @param key key
 */
+ (void)saveValue:(id)value forKey:(NSString *)key;

/*!
 获取对象

 @param key key
 */
+ (id)getValueForKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
