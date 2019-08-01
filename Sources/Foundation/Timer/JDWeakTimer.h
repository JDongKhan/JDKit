//
//  JDWeakTimer.h
//  JDFoundation
//
//  Created by JD on 2017/12/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^JDTimerHandler)(id userInfo);

@interface JDWeakTimer : NSObject

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                      target:(id)aTarget
                                    selector:(SEL)aSelector
                                    userInfo:(id)userInfo
                                     repeats:(BOOL)repeats;

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                      block:(JDTimerHandler)block
                                   userInfo:(id)userInfo
                                    repeats:(BOOL)repeats;

@end

NS_ASSUME_NONNULL_END
