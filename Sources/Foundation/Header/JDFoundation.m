//
//  JDFoundation.m
//  JDKit
//
//  Created by JD on 2019/8/1.
//

#import "JDFoundation.h"

BOOL jd_is_none_null_string(NSString * _Nullable string) {
    if (string == nil) {
        return NO;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return NO;
    }
    return string.length != 0;
}
