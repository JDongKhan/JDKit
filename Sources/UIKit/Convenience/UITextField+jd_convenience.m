//
//  UITextField+jd_convenience.m
//  
//
//  Created by JD on 14-8-28.
//  Copyright (c) 2014年 JD. All rights reserved.
//

#import "UITextField+jd_convenience.h"
#import <objc/runtime.h>
#import "NSNotificationCenter+jd_runtime.h"

static const void *tmaxLenght = &tmaxLenght;
static const void *tformatType = &tformatType;
static const void *trangeDecimal = &trangeDecimal;
static const void *limitTipsLabel = &limitTipsLabel;


static const void *textFieldInvalidEmpty = &textFieldInvalidEmpty;
static const void *textFieldregex = &textFieldregex;

@implementation UITextField (jd_convenience)
@dynamic numText;
@dynamic hiddenTip;

//文本长度限制
- (void)setMaxLenght:(int)maxLenght {
    __weak typeof (self) weakSelf = self;
    [[NSNotificationCenter defaultCenter] addObserver:self forName:UITextFieldTextDidChangeNotification withNotifyBlock:^(NSNotification *notification){
        [weakSelf textFiledEditChanged:notification];
    }];    
    objc_setAssociatedObject(self, tmaxLenght, [NSNumber numberWithFloat:maxLenght], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.tipLabel.text = [NSString stringWithFormat:@"%d",maxLenght];
}

- (int)maxLenght {
    NSNumber *lines = objc_getAssociatedObject(self, tmaxLenght);
    return [lines intValue];
}

//银行卡号码格式化
- (void)setFormatType:(JDTextFieldFormatType)formatType {
    __weak typeof (self) weakSelf = self;
    [[NSNotificationCenter defaultCenter] addObserver:self forName:UITextFieldTextDidChangeNotification withNotifyBlock:^(NSNotification *notification){
        [weakSelf textFiledEditChanged:notification];
    }];
    objc_setAssociatedObject(self, tformatType, [NSNumber numberWithInteger:formatType], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//设置范围
-(void) setRangeDecimal:(int) rangeDecimal {
    __weak typeof (self) weakSelf = self;
    [[NSNotificationCenter defaultCenter] addObserver:self forName:UITextFieldTextDidChangeNotification withNotifyBlock:^(NSNotification *notification){
        [weakSelf textFiledEditChanged:notification];
    }];
    objc_setAssociatedObject(self, trangeDecimal, [NSNumber numberWithInteger:rangeDecimal], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(int)rangeDecimal{
   NSNumber *rangeDecimal =  objc_getAssociatedObject(self, trangeDecimal);
    return [rangeDecimal intValue];
}

- (UILabel *)tipLabel {
    UILabel *lable = objc_getAssociatedObject(self, limitTipsLabel);
    if (lable == nil) {
        lable = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-80, self.frame.size.height-15, 75, 10)];
        lable.textColor = [UIColor grayColor];
        lable.font = [UIFont systemFontOfSize:12.0f];
        lable.userInteractionEnabled = NO;
        lable.textAlignment = NSTextAlignmentRight;
        lable.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin;
        [self addSubview:lable];
        
         objc_setAssociatedObject(self, limitTipsLabel, lable, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return lable;
}
- (void)setTextWithEditChanged:(NSString *)textWithEditChanged {
    self.text = textWithEditChanged;
    [self reloadTipsWithTextField:self];
}
- (NSString *)textWithEditChanged {
    return self.text;
}

- (JDTextFieldFormatType)formatType{
    NSNumber *able = objc_getAssociatedObject(self, tformatType);
    return [able integerValue];
}

- (void)textFiledEditChanged:(NSNotification *)obj{
    UITextField *textField = (UITextField *)obj.object;
    if (textField == self) {
        [self reloadTipsWithTextField:textField];
    }
}

- (void)reloadTipsWithTextField:(UITextField *)textField {
    NSInteger maxlenght = self.maxLenght;
    //最大长度限制
    if (maxlenght > 0) {
        NSString *toBeString = textField.text;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage];      // 键盘输入模式
#pragma clang diagnostic pop
        // 简体中文输入，包括简体拼音，健体五笔，简体手写
        if ([lang isEqualToString:@"zh-Hans"]) {
            UITextRange *selectedRange = [textField markedTextRange];
            //获取高亮部分
            UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
            // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if (!position) {
                if (toBeString.length > maxlenght) {
                    textField.text = [toBeString substringToIndex:maxlenght];
                }
            }
            // 有高亮选择的字符串，则暂不对文字进行统计和限制
            else{
                
            }
        }
        // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        else{
            if (toBeString.length > maxlenght) {
                textField.text = [toBeString substringToIndex:maxlenght];
            }
        }
        self.tipLabel.text = [NSString stringWithFormat:@"%d",(self.maxLenght-(int)textField.text.length)];
    }
    //银行卡格式化
    JDTextFieldFormatType textFieldFormatType = self.formatType;
    if(textFieldFormatType == JDTextFieldFormatBankCard){
        NSString *tmpStr = [self numText];
        NSUInteger groupLenght = 4;
        NSUInteger size = (tmpStr.length / groupLenght);
        NSMutableArray *tmpStrArr = [[NSMutableArray alloc] init];
        for (int n = 0;n < size; n++){
            [tmpStrArr addObject:[tmpStr substringWithRange:NSMakeRange(n*groupLenght, groupLenght)]];
        }
        NSString *lastStr = [tmpStr substringWithRange:NSMakeRange(size*groupLenght, (tmpStr.length % groupLenght))];
        if (lastStr.length > 0) {
            [tmpStrArr addObject:lastStr];
        }
        tmpStr = [tmpStrArr componentsJoinedByString:@" "];
        self.text = tmpStr;
    }else if(textFieldFormatType == JDTextFieldFormatPhone){
        NSString *tmpStr = [self numText];
        if(tmpStr.length > 3){
            NSUInteger groupLenght = 4;
            NSUInteger size = ((tmpStr.length-3) / groupLenght);
            NSMutableArray *tmpStrArr = [[NSMutableArray alloc] init];
            [tmpStrArr addObject:[tmpStr substringWithRange:NSMakeRange(0, 3)]];
            for (int n = 0;n < size; n++){
                [tmpStrArr addObject:[tmpStr substringWithRange:NSMakeRange(n*groupLenght+3, groupLenght)]];
            }
            NSString *lastStr = [tmpStr substringWithRange:NSMakeRange(size*groupLenght+3, ((tmpStr.length-3) % groupLenght))];
            if (lastStr.length > 0) {
                [tmpStrArr addObject:lastStr];
            }
            tmpStr = [tmpStrArr componentsJoinedByString:@" "];
            
        }
        self.text = tmpStr;
    }
    //如小数位大于0,将限制下位数
    if(self.rangeDecimal>0){
        NSString *toBeString = textField.text;
        NSRange range =  [toBeString rangeOfString:@"."];
        if (range.length>0) {
            NSInteger lenght = range.location+self.rangeDecimal;
            NSString* append = [toBeString substringFromIndex:range.location];
            if (append.length > self.rangeDecimal+1) {
                textField.text = [toBeString substringToIndex:lenght+1];
            }
        }
    }
}

- (NSString *)numText{
    return [self.text stringByReplacingOccurrencesOfString:@" " withString:@""];
}



- (void)setValidEmpty:(BOOL)invalidEmpty {
    objc_setAssociatedObject(self, textFieldInvalidEmpty, [NSNumber numberWithBool:invalidEmpty], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)validEmpty {
    return [objc_getAssociatedObject(self, textFieldInvalidEmpty) boolValue];
}
- (void)setRegex:(NSString *)regex {
    objc_setAssociatedObject(self, textFieldregex, regex, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)regex {
    return objc_getAssociatedObject(self, textFieldregex);
}

- (BOOL)isValidate {
    
    BOOL isValidate = YES;
    if (self.validEmpty && self.text.length == 0) {
        isValidate = NO;
    }
    if (self.maxLenght != 0 && self.text.length > self.maxLenght) {
        isValidate = NO;
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", self.regex];
    isValidate = [predicate evaluateWithObject:self.text];
    
    return isValidate;
}

- (void)setHiddenTip:(BOOL)hiddenTip {
    self.tipLabel.hidden = hiddenTip;
}

@end
