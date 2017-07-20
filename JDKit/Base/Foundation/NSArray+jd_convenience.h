//
//  NSArray+jd_convenience.h
//
//  Created by wjd on 14-6-11.
//  Copyright (c) 2014年 wjd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (jd_convenience)

/**
 *	@brief	将NSArray 转换为 NSMutableArray
 *	@return NSMutableArray
 */
- (NSMutableArray *)toMutableArray;

/**
 *	@brief	取到某一项的前一项
 *	@param 	object 	object The reference object.
 *	@return	The previous object or `nil` if not found.
 */
- (id)objectBefore:(id)object;

/**
 *  Get the previous object with ot without wrap.
 *
 *  @param object The reference object.
 *  @param wrap   Whether to cirularly wrap the array to get the previous element.
 *
 *  @return The previous object or `nil` if not found.
 */
- (id)objectBefore:(id)object wrap:(BOOL)wrap;

/**
 *  取到某一项的后一项
 *
 *  @param object The reference object.
 *
 *  @return The next object or `nil` if not found.
 */
- (id)objectAfter:(id)object;

/**
 *  Get the next object with ot without wrap.
 *
 *  @param object The reference object.
 *  @param wrap   Whether to cirularly wrap the array to get the next element.
 *
 *  @return The next object or `nil` if not found.
 */
- (id)objectAfter:(id)object wrap:(BOOL)wrap;

/**
 *  A "shorter" description method that tries avoid spanning into multiple lines.
 *
 *  @return NSString
 */
- (NSString *)shortDescription;


+ (instancetype)arrayWithBundleNameForResource:(NSString *)fileName ofType:(NSString *)ext;
+ (instancetype)arrayWithBundleNameForResource:(NSString *)fileName ofType:(NSString *)ext bundle:(NSBundle *)bundle;


@end
