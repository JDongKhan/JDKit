//
//  UIViewController+jd_alpha.h
//  JDKit
//
//  Created by JD on 2016/7/18.
//  Copyright © 2016年 JD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (jd_alpha)

@property (nonatomic,assign) CGFloat navigationBarAlpha;

@end


@interface UINavigationController (alpha)<UINavigationBarDelegate, UINavigationControllerDelegate>

@end

NS_ASSUME_NONNULL_END
