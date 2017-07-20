//
//  NSUserDefaults+jd_convenience.h
//  
//
//  Created by wjd on 14-6-14.
//  Copyright (c) 2014年 wjd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (jd_convenience)

//保存对象  一行代码就可以了
+ (void)saveValue:(id)value forKey:(NSString *)key;

//获取对象
+ (id)getValueForKey:(NSString *)key;

@end
