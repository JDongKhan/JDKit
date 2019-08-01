//
//  NSUserDefaults+jd_convenience.m
//
//
//  Created by jd on 14-6-14.
//  Copyright (c) 2014年 jd. All rights reserved.
//

#import "NSUserDefaults+jd_convenience.h"

@implementation NSUserDefaults (jd_convenience)

+ (void)saveValue:(id)value forKey:(NSString *)key {
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    [userdefault setValue:value forKeyPath:key];
    [userdefault synchronize];
}

+ (id)getValueForKey:(NSString *)key {
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    return [userdefault valueForKey:key];
}

@end
