//
//  UIKitMacros.h
//  JDKit
//
//  Created by JD on 2019/8/1.
//  Copyright © 2019 JD. All rights reserved.
//

#import "UIActionSheet+jd_convenience.h"
#import "UIAlertView+jd_convenience.h"
#import "UIButton+jd_convenience.h"
#import "UIColor+jd_convenience.h"
#import "UIImage+jd_convenience.h"
#import "UILabel+jd_convenience.h"
#import "UIScrollView+jd_convenience.h"
#import "UITableView+jd_convenience.h"
#import "UITextField+jd_convenience.h"
#import "UITextView+jd_convenience.h"
#import "UIView+jd_convenience.h"
#import "JDAppInfo.h"
#import "JDDeviceInfo.h"
#import "JDKeychain.h"
#import "JDOpenUDID.h"
#import "CALayer+jd_convenience.h"
#import "UIImageView+jd_gif.h"
#import "UIView+jd_animal.h"
#import "UIViewController+jd_alpha.h"

/**************************** color ************************************/
#define JD_RGB(r, g, b)             [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]
#define JD_RGBAlpha(r, g, b, a)     [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]
#define JD_UIColorHex16(rgbValue)   [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


/**************************** os ************************************/
#define JD_iOS9ORLate ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0 ? YES : NO)
#define JD_iOS8ORLate ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ? YES : NO)
#define JD_iOS_version [[[UIDevice currentDevice] systemVersion] floatValue]

#define JD_iOSSystemORLate(version) ([[[UIDevice currentDevice] systemVersion] floatValue] >= version ? YES : NO)


/**************************** screen ************************************/

// iPad
#define JD_is_iPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define JD_is_Phone ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)

#define JD_SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height    // 获取屏幕的高度
#define JD_SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width      // 获取屏幕的宽度


#define JD_is_iPhone6p ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)    // 判断是否是iPhone6屏幕

#define JD_is_iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)    // 判断是否是iPhone6屏幕

#define JD_is_iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)    // 判断是否是iPhone5屏幕

#define JD_is_iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)    // 判断是否是iPhone4屏幕
