//
//  NSDate+jd_convenience.h
//
//  Created by wjd on 4/23/12.
//  Copyright (c) 2012 wjd. All rights reserved.
//

#define SECOND	(1)
#define MINUTE	(60 * SECOND)
#define HOUR	(60 * MINUTE)
#define DAY		(24 * HOUR)
#define MONTH	(30 * DAY)

#import <Foundation/Foundation.h>

@interface NSDate (jd_convenience)

//计算偏移月的日期
- (NSDate *)offsetMonth:(int)numMonths;

//计算偏移日的日期
- (NSDate *)offsetDay:(int)numDays;

//计算偏移小时的日期
- (NSDate *)offsetHours:(int)hours;

//计算当前月 多少天
- (NSUInteger)numDaysInMonth;

//计算当前月第一天所在位置
- (NSUInteger)firstWeekDayInMonth;

//获取年
- (NSInteger)year;

//获取月
- (NSInteger)month;

//获取天
- (NSInteger)day;
//获取周
- (NSInteger)week;
- (NSString *)weekString;

//本周第一天所在日期
+ (NSDate *)dateStartOfWeek;

//本周最后一天所在日期
+ (NSDate *)dateEndOfWeek;

//格式化日期
- (NSString *)stringOfFormat:(NSString *)format;
//格式化日期
- (NSDate *)dateOfFormat:(NSString *)format;

//时间戳
+ (long long)timeStamp;

//转换
- (NSString *)timeAgo;

// 返回距离aDate有多少天
- (NSInteger)distanceInDaysToDate:(NSDate *)aDate;

//[NSDate date] 获取的是GMT时间，要想获得某个时区的时间，以下代码可以解决这个问题
+ (NSDate *)localeDate;
- (NSDate *)toLocaleDate;

@end
