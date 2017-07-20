//
//  UITextField+jd_convenience.h
//  
//
//  Created by 王金东 on 14-8-28.
//  Copyright (c) 2014年 王金东. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,JDTextFieldFormatType){
    JDTextFieldFormatNone,
    JDTextFieldFormatPhone,
    JDTextFieldFormatBankCard,
};

@interface UITextField (jd_convenience)

//数字格式化功能 将数字中间加入-分隔
@property (nonatomic,assign) JDTextFieldFormatType formatType;

@property (nonatomic,strong) NSString *numText;

//小数位控制
@property(nonatomic,assign) int rangeDecimal;

@property (nonatomic,assign) int maxLenght;//最大长度
@property (nonatomic,assign) BOOL hiddenTip;

//不能为空
@property (nonatomic,assign) BOOL validEmpty;
@property (nonatomic,strong) NSString *regex;
@property (nonatomic,strong) NSString *textWithEditChanged;

//验证
- (BOOL)isValidate;

@end
