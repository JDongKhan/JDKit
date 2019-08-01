//
//  NSData+jd_convenience.h
//  JdCore
//
//  Created by jd on 16/7/8.
//  Copyright © 2016年 jd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (jd_convenience)


/*!
二进制data转16进制
*/
- (NSString *)dataToHexString;

/*!
md5
 */
- (NSData *)md5Data;


@end

NS_ASSUME_NONNULL_END
