//
//  JDOpenUDID.h
//  JDFoundation
//

#import <Foundation/Foundation.h>

//
// Usage:
//    #include "OpenUDID.h"
//    NSString* openUDID = [OpenUDID value];
//

extern NSInteger const JDOpenUDIDErrorNone;
extern NSInteger const JDOpenUDIDErrorOptedOut;
extern NSInteger const JDOpenUDIDErrorCompromised;

NS_ASSUME_NONNULL_BEGIN


@interface JDOpenUDID : NSObject

+ (NSString *)value;

+ (NSString *)valueWithError:(NSError **)error;

+ (void)setOptOut:(BOOL)optOutValue;

@end

NS_ASSUME_NONNULL_END
