//
//  NSArray+jd_convenience.h
//
//  Created by jd on 14-6-11.
//  Copyright (c) 2014年 jd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface NSArray (jd_convenience)


/*!
 *	@brief	将NSArray 转换为 NSMutableArray
 *	@return NSMutableArray
 */
- (NSMutableArray *)toMutableArray;

/*!
 *	@brief	Get the previous object
 *	@param 	object 	object The reference object.
 *	@return	The previous object or `nil` if not found.
 */
- (id)objectBefore:(id)object;

/*!
 *  Get the previous object with or without wrap.
 *
 *  @param object The reference object.
 *  @param wrap   Whether to cirularly wrap the array to get the previous element.
 *
 *  @return The previous object or `nil` if not found.
 */
- (id)objectBefore:(id)object wrap:(BOOL)wrap;

/*!
 *  Get the latter object
 *
 *  @param object The reference object.
 *
 *  @return The next object or `nil` if not found.
 */
- (id)objectAfter:(id)object;

/*!
 *  Get the next object with ot without wrap.
 *
 *  @param object The reference object.
 *  @param wrap   Whether to cirularly wrap the array to get the next element.
 *
 *  @return The next object or `nil` if not found.
 */
- (id)objectAfter:(id)object wrap:(BOOL)wrap;

/*!
 *  A "shorter" description method that tries avoid spanning into multiple lines.
 *
 *  @return NSString
 */
- (NSString *)shortDescription;


+ (instancetype)arrayWithBundleNameForResource:(NSString *)fileName ofType:(NSString *)ext;
+ (instancetype)arrayWithBundleNameForResource:(NSString *)fileName ofType:(NSString *)ext bundle:(NSBundle *)bundle;


@end

NS_ASSUME_NONNULL_END
