//
//  UIView+jd_hidenConstraints
//
//  Created by wjd on 15/8/20.
//  Copyright (c) 2015年 wjd. All rights reserved.
//

#import "UIView+jd_hidenConstraints.h"
#import <objc/runtime.h>

@implementation UIView (jd_hidenConstraints)

- (void)hideView:(BOOL)hidden byAttributes:(NSLayoutAttribute)attributes,...NS_REQUIRES_NIL_TERMINATION{
    va_list ap;
    va_start(ap,attributes);
    if (attributes){
        
        [self hideView:hidden withAttribute:attributes];
        
        NSLayoutAttribute detailattribute;
        while ((detailattribute=va_arg(ap,  NSLayoutAttribute ))) {
            
            [self hideView:hidden withAttribute:detailattribute];
        }
    }
    va_end(ap);
    self.hidden=hidden;
}



- (void)hideView:(BOOL)hidden withAttribute:(NSLayoutAttribute)attribute {
    NSLayoutConstraint *constraint=[self constraintForAttribute:attribute];
    if (constraint){
        
        NSString *constraintString=[self _attributeToString:attribute];
        NSNumber *savednumber = objc_getAssociatedObject(self, [constraintString UTF8String]);
        if (!savednumber) {
            objc_setAssociatedObject(self, [constraintString UTF8String], @(constraint.constant), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            savednumber=@(constraint.constant);
        }
        NSLog(@"%f",savednumber.floatValue);
        if (hidden){
            [constraint setConstant:0];
        }else{
            [constraint setConstant:savednumber.floatValue];
        }
    }
}

- (CGFloat)constraintConstantforAttribute:(NSLayoutAttribute)attribute {
    NSLayoutConstraint * constraint = [self constraintForAttribute:attribute];
    if (constraint){
        return constraint.constant;
    }else{
        return NAN;
    }
}


- (NSLayoutConstraint*) constraintForAttribute:(NSLayoutAttribute)attribute {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"firstAttribute = %d && firstItem = %@", attribute, self];
    NSArray *constraintsArr=[self.superview constraints];
    NSArray *fillteredArray = [constraintsArr filteredArrayUsingPredicate:predicate];
    if(fillteredArray.count == 0) {
        NSArray *selffillteredArray = [self.constraints filteredArrayUsingPredicate:predicate];
        if(selffillteredArray.count == 0)
        {
            return nil;
        }
        else{
            return selffillteredArray.firstObject;
        }
        return nil;
    }else {
        return fillteredArray.firstObject;
    }
}



- (NSString*)_attributeToString:(NSLayoutAttribute)attribute {
    
    switch (attribute) {
        case NSLayoutAttributeLeft:{
            return @"NSLayoutAttributeLeft";
            break;
        }
        case NSLayoutAttributeRight:{
            return @"NSLayoutAttributeRight";
            break;
        }
        case NSLayoutAttributeTop:{
            return @"NSLayoutAttributeTop";
            break;
        }
        case NSLayoutAttributeBottom:{
            return @"NSLayoutAttributeBottom";
            break;
        }
        case NSLayoutAttributeLeading:{
            return @"NSLayoutAttributeLeading";
            break;
        }
        case NSLayoutAttributeTrailing:{
            return @"NSLayoutAttributeTrailing";
            break;
        }
        case NSLayoutAttributeWidth:{
            return @"NSLayoutAttributeWidth";
            break;
        }
        case NSLayoutAttributeHeight:{
            return @"NSLayoutAttributeHeight";
            break;
        }
        case NSLayoutAttributeCenterX:{
            return @"NSLayoutAttributeCenterX";
            break;
        }
        case NSLayoutAttributeCenterY:{
            return @"NSLayoutAttributeCenterY";
            break;
        }
        case NSLayoutAttributeBaseline:{
            return @"NSLayoutAttributeBaseline";
            break;
        }
        case NSLayoutAttributeFirstBaseline:{
            return @"NSLayoutAttributeFirstBaseline";
            break;
        }
        case NSLayoutAttributeLeftMargin:{
            return @"NSLayoutAttributeLeftMargin";
            break;
        }
        case NSLayoutAttributeRightMargin:{
            return @"NSLayoutAttributeRightMargin";
            break;
        }
        case NSLayoutAttributeTopMargin:{
            return @"NSLayoutAttributeTopMargin";
            break;
        }
        case NSLayoutAttributeBottomMargin:{
            return @"NSLayoutAttributeBottomMargin";
            break;
        }
        case NSLayoutAttributeLeadingMargin:{
            return @"NSLayoutAttributeLeadingMargin";
            break;
        }
        case NSLayoutAttributeTrailingMargin:{
            return @"NSLayoutAttributeTrailingMargin";
            break;
        }
        case NSLayoutAttributeCenterXWithinMargins:{
            return @"NSLayoutAttributeCenterXWithinMargins";
            break;
        }
        case NSLayoutAttributeCenterYWithinMargins:{
            return @"NSLayoutAttributeCenterYWithinMargins";
            break;
        }
        case NSLayoutAttributeNotAnAttribute:{
            return @"NSLayoutAttributeNotAnAttribute";
            break;
        }
        default:
            break;
    }
    
    return @"NSLayoutAttributeNotAnAttribute";
}

- (void)hiddenWithWidthConstraint:(CGFloat)width {
    [self hiddenWithWidthConstraint:width height:-1];
}
- (void)hiddenWithHeightConstraint:(CGFloat)height {
    [self hiddenWithWidthConstraint:-1 height:height];
}
- (void)hiddenWithWidthConstraint:(CGFloat)width height:(CGFloat)height {
    NSArray* constrains = self.constraints;
    for (NSLayoutConstraint *constraint in constrains) {
        if (constraint.firstAttribute == NSLayoutAttributeHeight && height >= 0) {
            constraint.constant = height;
        }else if (constraint.firstAttribute == NSLayoutAttributeWidth && width >= 0) {
            constraint.constant = width;
        }
    }
    if(height == 0 || width == 0){
        self.hidden = YES;
    }else{
        self.hidden = NO;
    }
}


@end
