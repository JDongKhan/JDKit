//
//  NSDate+jd_convenience.h
//
//  Created by jd on 4/23/12.
//  Copyright (c) 2012 jd. All rights reserved.
//

#define JD_SECOND	(1)
#define JD_MINUTE	(60 * JD_SECOND)
#define JD_HOUR	(60 * JD_MINUTE)
#define JD_DAY		(24 * JD_HOUR)
#define JD_MONTH	(30 * JD_DAY)

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (jd_convenience)


/*!
 获取年
 */
@property (nonatomic, readonly) NSInteger year;

/*!
 获取月
 */
@property (nonatomic, readonly) NSInteger month;

/*!
 获取天
 */
@property (nonatomic, readonly) NSInteger day;

/*!
 获取周
 */
@property (nonatomic, readonly) NSInteger week;
@property (nonatomic, readonly, copy) NSString *weekString;

/**
 获取小时
 */
@property (nonatomic, readonly) NSInteger hour;

/**
 获取分钟
 */
@property (nonatomic, readonly) NSInteger minute;

/**
 获取秒
 */
@property (nonatomic, readonly) NSInteger seconds;

/*!
 本周第一天所在日期
 */
@property (nonatomic, readonly, strong, class) NSDate *dateStartOfWeek;

/*!
 本周最后一天所在日期
 */
@property (nonatomic, readonly, strong, class) NSDate *dateEndOfWeek;

/*!
 计算当前月 多少天
 */
@property (nonatomic, readonly) NSUInteger numDaysInMonth;

/*!
 计算当前月第一天所在位置
 */
@property (nonatomic, readonly) NSUInteger firstWeekDayInMonth;

/*!
 时间戳
 */
@property (nonatomic, readonly, class) long long timeStamp;

/*!
 将时间转换描述，如刚刚，1小时前等
 */
@property (nonatomic, readonly, copy) NSString *timeAgo;

/*!
 [NSDate date] 获取的是GMT时间，要想获得某个时区的时间，以下代码可以解决这个问题
 */
@property (nonatomic, readonly, strong, class) NSDate *localeDate;
@property (nonatomic, readonly, strong) NSDate *toLocaleDate;

/*************************** is xxxx **********************************/

/*!
 是否是今天
 */
@property (nonatomic, readonly) BOOL isToday;

/*!
 是否是明天
 */
@property (nonatomic, readonly) BOOL isTomorrow;

/*!
 是否是昨天
 */
@property (nonatomic, readonly) BOOL isYesterday;

/*!
 是否是这个月
 */
@property (nonatomic, readonly) BOOL isThisMonth;

/*!
 是否是今年
 */
@property (nonatomic, readonly) BOOL isThisYear;

/*!
 是否是明年
 */
@property (nonatomic, readonly) BOOL isNextYear;

/*!
 是否是去年
 */
@property (nonatomic, readonly) BOOL isLastYear;

/*!
 是否是将来
 */
@property (nonatomic, readonly) BOOL isFuture;

/*!
 是否是过去
 */
@property (nonatomic, readonly) BOOL isPast;

/*!
 计算偏移月的日期

 @param numMonths 月数
 */
- (NSDate *)offsetMonth:(int)numMonths;

/*!
 计算偏移日的日期

 @param numDays 天数
 */
- (NSDate *)offsetDay:(int)numDays;

/*!
 计算偏移小时的日期

 @param hours 小时数
 */
- (NSDate *)offsetHours:(int)hours;

/*!
 格式化日期

 @param format 格式
 */
- (NSString *)stringOfFormat:(NSString *)format;

/*!
 格式化日期

 @param format 格式
 */
- (NSDate *)dateOfFormat:(NSString *)format;

/*!
 返回距离aDate有多少天

 @param aDate 另一个时间对象
 */
- (NSInteger)distanceInDaysToDate:(NSDate *)aDate;

@end

NS_ASSUME_NONNULL_END
