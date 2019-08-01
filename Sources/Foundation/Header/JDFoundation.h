//
//  macros.h
//  JDFoundation
//
//  Created by jd on 2017/7/10.
//  Copyright © 2017年 jd. All rights reserved.
//

#import "NSArray+jd_convenience.h"
#import "NSAttributedString+jd_convenience.h"
#import "NSData+jd_convenience.h"
#import "NSDate+jd_convenience.h"
#import "NSDictionary+jd_convenience.h"
#import "NSMutableArray+jd_convenience.h"
#import "NSMutableDictionary+jd_convenience.h"
#import "NSNotificationCenter+jd_runtime.h"
#import "NSObject+jd_convenience.h"
#import "NSString+jd_convenience.h"
#import "NSUserDefaults+jd_convenience.h"

#import <mach/mach_time.h>

//计算方法时间
static inline void JDTimeThisBlock (void (^block)(void), void (^complete)(double ms)) {
    mach_timebase_info_data_t info;
    if (mach_timebase_info(&info) != KERN_SUCCESS) return complete(-1.0);
    
    uint64_t start = mach_absolute_time ();
    block ();
    uint64_t end = mach_absolute_time ();
    uint64_t elapsed = end - start;
    
    uint64_t nanos = elapsed * info.numer / info.denom;
    complete((CGFloat)nanos / NSEC_PER_SEC);
}

extern BOOL jd_is_none_empty_string(NSString * _Nullable string);


/**************************************************************/
// 单例模式  给类自动加入单例
#undef	JD_HEAD_SINGLETON
#define JD_HEAD_SINGLETON( __class ) \
+ (__class *)sharedInstance;

#undef	JD_IMP_SINGLETON
#define JD_IMP_SINGLETON( __class ) \
+ (__class *)sharedInstance { \
    static dispatch_once_t once; \
    static __class * __singleton__; \
    dispatch_once( &once, ^{ __singleton__ = [[self alloc] init]; } ); \
    return __singleton__; \
}

#define JDMainBundle [NSBundle mainBundle]
#define JDMainBundleResourcePath [[NSBundle mainBundle] resourcePath]

/**
 *
 * Example:
 *   @weakify(self)
 *   [self doSomething^{
 *     @strongify(self)
 *       if (!self) return;
 *       ...
 *   }];
 */
#ifndef weakify
    #if DEBUG
        #if __has_feature(objc_arc)
            #define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
        #else
            #define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
    #endif
    #else
        #if __has_feature(objc_arc)
            #define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
        #else
            #define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
        #endif
    #endif
#endif

#ifndef strongify
    #if DEBUG
        #if __has_feature(objc_arc)
            #define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
        #else
            #define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
        #endif
    #else
        #if __has_feature(objc_arc)
            #define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
        #else
            #define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
        #endif
    #endif
#endif



#define JD_isNilOrNull(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]))

#define JD_PI 3.14159265359

//角度转弧度
#define  JD_DEGREES_TO_RADIANS(degrees)  ((pi * degrees)/ 180)

/**************************************************************/
//转换
#define JD_I2S(number) [NSString stringWithFormat:@"%d",number]
#define JD_F2S(number) [NSString stringWithFormat:@"%f",number]
#define JD_DATE(stamp) [NSDate dateWithTimeIntervalSince1970:[stamp intValue]];


/**************************************************************/
// GCD 多线程
#define JD_GCD_MainFun(aFun) dispatch_async( dispatch_get_main_queue(), ^(void){aFun;} );
#define JD_GCD_MainBlock(block) dispatch_async( dispatch_get_main_queue(), block );

#define JD_GCD_BackGroundBlock(block) dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block );
#define JD_GCD_BackGroundFun(aFun) dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){aFun;} );

#define JD_GCD_OnceBlock(block) {static dispatch_once_t once;dispatch_once( &once, block);}

#define JD_GCD_AfterBlock(block,delayInSeconds)  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
#define JD_GCD_AfterFun(aFun,delayInSeconds) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void){aFun;});


#define JD_NoWarningPerformSelector(target, action, object) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wundeclared-selector\"") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
if ([target respondsToSelector:action]) {\
[target performSelector:action withObject:object]; }\
_Pragma("clang diagnostic pop") \

//notification
#define JD_PostNotification(name,userInfo)  [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil userInfo:userInfo];
#define JD_AddObserverNotification(target,sel,name)  [[NSNotificationCenter defaultCenter] addObserver:target selector:sel name:name object:nil];
#define JD_RemoveObserverNotification [[NSNotificationCenter defaultCenter] removeObserver:self];

