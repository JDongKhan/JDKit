//
//  UITextField+jd_convenience.h
//  
//
//  Created by JD on 14-8-28.
//  Copyright (c) 2014年 JD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,JDTextFieldFormatType){
    JDTextFieldFormatNone,
    JDTextFieldFormatPhone,
    JDTextFieldFormatBankCard,
};

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (jd_convenience)

/**
 数字格式化功能 将数字中间加入-分隔
 */
@property (nonatomic,assign) JDTextFieldFormatType formatType;

/**
 数字文本
 */
@property (nonatomic,strong) NSString *numText;

/**
 小数位控制
 */
@property(nonatomic,assign) int rangeDecimal;

/**
 最大长度
 */
@property (nonatomic,assign) int maxLenght;

/**
 隐藏提示
 */
@property (nonatomic,assign) BOOL hiddenTip;

/**
 文本编辑事件
 */
@property (nonatomic,strong) NSString *textWithEditChanged;

/**
 验证：不能为空
 */
@property (nonatomic,assign) BOOL validEmpty;

/**
 正则表达式，符合该正则的才能输入
 */
@property (nonatomic,strong) NSString *regex;

/**
 验证
 
 配合validEmpty、regex、maxLenght使用
 */
- (BOOL)isValidate;

@end

NS_ASSUME_NONNULL_END
