//
//  JDAppInfo.h
//  JDUIKit
//
//  Created by JD on 2019/7/31.
//  Copyright © 2019 JD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JDAppInfo : NSObject

#pragma mark -------------- app基本功能 --------------
@property (nonatomic, copy, readonly) NSString *appName;


/*!
 可以获取appversion 1.0.1
 */
@property (nonatomic, copy, readonly) NSString *appVersion;

/*!
 可以获取appBuild 1.0
 */
@property (nonatomic, copy, readonly) NSString *appBuild;

/*!
 可以获取BundleIdentifier
 */
@property (nonatomic, copy, readonly) NSString *bundleIdentifier;

/**
 获取app基本信息
 */
@property (nonatomic, copy, readonly) NSDictionary *appInfo;

@end

NS_ASSUME_NONNULL_END
