//
//  NSDate+jd_convenience.m
//
//  Created by jd on 4/23/12.
//  Copyright (c) 2012 jd. All rights reserved.
//



#import "NSDate+jd_convenience.h"
#import "NSString+jd_convenience.h"

@implementation NSDate (jd_convenience)


//获取年
- (NSInteger)year {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitYear fromDate:self];
    return [components year];
}

//获取月
- (NSInteger)month {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitYear fromDate:self];
    return [components month];
}

//获取天
- (NSInteger)day {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitDay fromDate:self];
    return [components day];
}

- (NSInteger)week {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday fromDate:self];
    return [components weekday];
}

- (NSString *)weekString {
    NSInteger week = [self week];
    switch (week) {
        case 1:
            return @"周日";
            break;
        case 2:
            return @"周一";
            break;
        case 3:
            return @"周二";
            break;
        case 4:
            return @"周三";
            break;
        case 5:
            return @"周四";
            break;
        case 6:
            return @"周五";
            break;
        case 7:
            return @"周六";
            break;
        default:
            break;
    }
    return nil;
}

- (NSInteger)hour {
    NSDateComponents *components = [NSCalendar.currentCalendar components:NSCalendarUnitHour fromDate:self];
    return components.hour;
}


- (NSInteger)minute {
    NSDateComponents *components = [NSCalendar.currentCalendar components:NSCalendarUnitMinute fromDate:self];
    return components.minute;
}


- (NSInteger)seconds {
    NSDateComponents *components = [NSCalendar.currentCalendar components:NSCalendarUnitSecond fromDate:self];
    return components.second;
}


//本月第一天 所在位置
- (NSUInteger)firstWeekDayInMonth {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [gregorian setFirstWeekday:1]; //sunday is first day
    
    //Set date to first of month
    NSDateComponents *comps = [gregorian components:NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay fromDate:self];
    [comps setDay:1];
    NSDate *newDate = [gregorian dateFromComponents:comps];

    return [gregorian ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:newDate];
}

//获取本月天数
- (NSUInteger)numDaysInMonth {
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSRange range = [cal rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    NSUInteger numberOfDaysInMonth = range.length;
    return numberOfDaysInMonth;
}

+ (NSDate *)dateStartOfWeek {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [gregorian setFirstWeekday:1]; //sunday is first day
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:[NSDate date]];

    NSDateComponents *componentsToSubtract = [[NSDateComponents alloc] init];
    [componentsToSubtract setDay: - ((([components weekday] - [gregorian firstWeekday])
                                      + 7 ) % 7)];
    NSDate *beginningOfWeek = [gregorian dateByAddingComponents:componentsToSubtract toDate:[NSDate date] options:0];
    
    NSDateComponents *componentsStripped = [gregorian components: (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)
                                                fromDate: beginningOfWeek];
    
    //gestript
    beginningOfWeek = [gregorian dateFromComponents: componentsStripped];
    
    return beginningOfWeek;
}

+ (NSDate *)dateEndOfWeek {
    NSCalendar *gregorian =[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:[NSDate date]];
    
    
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setDay: + (((([components weekday] - [gregorian firstWeekday])
                                      + 7 ) % 7))+6];
    NSDate *endOfWeek = [gregorian dateByAddingComponents:componentsToAdd toDate:[NSDate date] options:0];
    
    NSDateComponents *componentsStripped = [gregorian components: (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)
                                                       fromDate: endOfWeek];
    
    //gestript
    endOfWeek = [gregorian dateFromComponents: componentsStripped];
    return endOfWeek;
}

+ (long long)timeStamp {
    return (long long)[[NSDate date] timeIntervalSince1970];
}

- (NSString *)timeAgo {
    NSTimeInterval delta = [[NSDate date] timeIntervalSinceDate:self];
    
    if (delta < 1 * JD_MINUTE) {
        return @"刚刚";
    } else if (delta < 2 * JD_MINUTE) {
        return @"1分钟前";
    } else if (delta < 45 * JD_MINUTE) {
        int minutes = floor((double)delta/JD_MINUTE);
        return [NSString stringWithFormat:@"%d分钟前", minutes];
    } else if (delta < 90 * JD_MINUTE) {
        return @"1小时前";
    } else if (delta < 24 * JD_HOUR) {
        int hours = floor((double)delta/JD_HOUR);
        return [NSString stringWithFormat:@"%d小时前", hours];
    } else if (delta < 48 * JD_HOUR) {
        return @"昨天";
    } else if (delta < 30 * JD_DAY) {
        int days = floor((double)delta/JD_DAY);
        return [NSString stringWithFormat:@"%d天前", days];
    } else if (delta < 12 * JD_MONTH) {
        int months = floor((double)delta/JD_MONTH);
        return months <= 1 ? @"1个月前" : [NSString stringWithFormat:@"%d个月前", months];
    }
    
    int years = floor((double)delta/JD_MONTH/12.0);
    return years <= 1 ? @"1年前" : [NSString stringWithFormat:@"%d年前", years];
}

+ (NSDate *)localeDate {
    NSDate *date = [NSDate date];
    return [date toLocaleDate];
}

- (NSDate *)toLocaleDate {
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: self];
    NSDate *localeDate = [self  dateByAddingTimeInterval: interval];
    return localeDate;
}

#pragma mark ----- is xxxx
/****************************** is xxx *******************************/

- (BOOL)isEqualToDateIgnoringTime:(NSDate *)aDate {
    NSDateComponents *components1 = [NSCalendar.currentCalendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    NSDateComponents *components2 = [NSCalendar.currentCalendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:aDate];
    return ((components1.year == components2.year) &&
            (components1.month == components2.month) &&
            (components1.day == components2.day));
}

- (BOOL)isToday {
    return [self isEqualToDateIgnoringTime:[NSDate date]];
}


- (BOOL)isTomorrow {
    NSDate *tomorrow = [NSDate dateWithTimeIntervalSinceNow:60.0 * 60.8 * 24.0];
    return [self isEqualToDateIgnoringTime:tomorrow];
}


- (BOOL)isYesterday {
    NSDate *yesterday = [NSDate dateWithTimeIntervalSinceNow:60.0 * 60.8 * 24.0 * (-1.0)];
    return [self isEqualToDateIgnoringTime:yesterday];
}

- (BOOL)isSameMonthAsDate:(NSDate *)aDate {
    NSDateComponents *components1 = [NSCalendar.currentCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:self];
    NSDateComponents *components2 = [NSCalendar.currentCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:aDate];
    return ((components1.month == components2.month) &&
            (components1.year == components2.year));
}

- (BOOL)isThisMonth {
    return [self isSameMonthAsDate:[NSDate date]];
}

- (BOOL)isSameYearAsDate:(NSDate *)aDate {
    NSDateComponents *components1 = [NSCalendar.currentCalendar components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [NSCalendar.currentCalendar components:NSCalendarUnitYear fromDate:aDate];
    return (components1.year == components2.year);
}

- (BOOL)isThisYear {
    // Thanks, baspellis
    return [self isSameYearAsDate:[NSDate date]];
}

- (BOOL)isNextYear {
    NSDateComponents *components1 = [NSCalendar.currentCalendar components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [NSCalendar.currentCalendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return (components1.year == (components2.year + 1));
}

- (BOOL)isLastYear {
    NSDateComponents *components1 = [NSCalendar.currentCalendar components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [NSCalendar.currentCalendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return (components1.year == (components2.year - 1));
}

- (BOOL)earlierThan:(NSDate *)otherDate {
    return ([self compare:otherDate] == NSOrderedAscending);
}

- (BOOL)laterThan:(NSDate *)otherDate {
    return ([self compare:otherDate] == NSOrderedDescending);
}

- (BOOL)isInFuture {
    return ([self laterThan:[NSDate date]]);
}

- (BOOL)isInPast {
    return ([self earlierThan:[NSDate date]]);
}

#pragma mark ----- other
/***************************  other ***************************/

- (NSString *)stringOfFormat:(NSString *)format{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:self];
}

//格式化日期
- (NSDate *)dateOfFormat:(NSString *)format {
    NSString *dateString = [self stringOfFormat:format];
    return [dateString stringToDate:format];
}

+ (NSCalendar *)AZ_currentCalendar {
    NSMutableDictionary *dictionary = [[NSThread currentThread] threadDictionary];
    NSCalendar *currentCalendar = [dictionary objectForKey:@"AZ_currentCalendar"];
    if (currentCalendar == nil) {
        currentCalendar = [NSCalendar currentCalendar];
        [dictionary setObject:currentCalendar forKey:@"AZ_currentCalendar"];
    }
    return currentCalendar;
}

- (NSInteger)distanceInDaysToDate:(NSDate *)aDate{
    NSCalendar *calendar = [NSDate AZ_currentCalendar];
    NSDateComponents *dateComponents = [calendar
                                        components:NSCalendarUnitDay fromDate:self toDate:aDate options:0];
    return [dateComponents day];
}

//获取当前日期偏移numMonths个月的日期
- (NSDate *)offsetMonth:(int)numMonths {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [gregorian setFirstWeekday:1];      //sunday is first day
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setMonth:numMonths];
    return [gregorian dateByAddingComponents:offsetComponents toDate:self options:0];
}

//获取当前日期偏移hours个小时的日期
- (NSDate *)offsetHours:(int)hours {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [gregorian setFirstWeekday:1];      //sunday is first day
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setHour:hours];
    return [gregorian dateByAddingComponents:offsetComponents toDate:self options:0];
}

//获取当前日期偏移numDays天的日期
- (NSDate *)offsetDay:(int)numDays {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [gregorian setFirstWeekday:1];     //sunday is first day
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:numDays];
    return [gregorian dateByAddingComponents:offsetComponents toDate:self options:0];
}

@end
