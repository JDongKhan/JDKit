//
//  NSObject+jd_convenience.m
//
//
//  Created by jd on 14-6-12.
//  Copyright (c) 2014年 jd. All rights reserved.
//

#import "NSObject+jd_convenience.h"
#import <objc/runtime.h>
#import "NSDictionary+jd_convenience.h"
#import "NSString+jd_convenience.h"

static char associatedObjectsKey;

@implementation NSObject (jd_convenience)

#pragma mark 给对象增加额外属性
- (id)associatedObjectForKey:(NSString*)key {
    NSMutableDictionary *dict = objc_getAssociatedObject(self, &associatedObjectsKey);
    return [dict objectForKey:key];
}

- (void)setAssociatedObject:(id)object forKey:(NSString*)key {
    NSMutableDictionary *dict = objc_getAssociatedObject(self, &associatedObjectsKey);
    if (!dict) {
        dict = [[NSMutableDictionary alloc] init];
        objc_setAssociatedObject(self, &associatedObjectsKey, dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [dict setObject:object forKey:key];
}

- (NSString*)autoDescription {
    NSDictionary *dic = [NSDictionary entityToDictionary:self];
    NSString *description =  [dic description];
    return [NSString stringWithFormat:@"[%@ {%@}]", NSStringFromClass([self class]),
            description];
}


//处理空对象
+ (instancetype)toTrimNull:(id)obj {
    if(obj == nil || obj == NULL || (NSNull *)obj == [NSNull null]) {
        return nil;
    }
    return obj;
}

//判断是否为空
+ (BOOL)isNullObject:(id)obj {
    if(obj == nil || obj == NULL || (NSNull *)obj == [NSNull null]) {
        return YES;
    }
    return NO;
}

//判断是否为空
+ (BOOL)isEmptyObject:(id)obj {
    if(obj == nil || obj == NULL || (NSNull *)obj == [NSNull null]) {
        return YES;
    }
    if([obj isKindOfClass:[NSString class]]) {
        NSString *str = obj;
        if(str.length == 0){
            return YES;
        }
    } else if([obj isKindOfClass:[NSArray class]]) {
        NSArray *array = obj;
        if(array.count == 0){
            return YES;
        }
    } else if([obj isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = obj;
        if(dic.count == 0){
            return YES;
        }
    }
    return NO;
}

//将对象转换为json字符串
- (NSString *)toJSONString{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if ([jsonData length] > 0 && error == nil) {
        NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                     encoding:NSUTF8StringEncoding];
        return jsonString;
    }else{
        return nil;
    }
}

//json字符串转对象
+ (id)jsonToObject:(NSString *)jsonString {
    if(jsonString == nil) {
        return nil;
    }
    NSError *error;
    return [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
}

- (NSString *)UTF8EncodingString {
    if ([self isKindOfClass:[NSNull class]]) {
		return nil;
    }
	if ([self isKindOfClass:[NSString class]]) {
		return [(NSString *)self UTF8Encoding];
	} else if ([self isKindOfClass:[NSData class]]) {
		NSData * data = (NSData *)self;
		return [[NSString alloc] initWithBytes:data.bytes length:data.length encoding:NSUTF8StringEncoding];
	} else {
		return [NSString stringWithFormat:@"%@", [self autoDescription]];
	}
}

- (void)copyValueFromObject:(id)object {
    Class clazz = [self class];
    u_int count;
    objc_property_t* properties = class_copyPropertyList(clazz, &count);
    for (int i = 0; i < count ; i++) {
        objc_property_t prop=properties[i];
        const char* propertyName = property_getName(prop);
        //NSString *key = [NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding];
        NSString *key = [NSString stringWithUTF8String:propertyName];
        //        const char* attributeName = property_getAttributes(prop);
        //        HSLog(@"%@",[NSString stringWithUTF8String:propertyName]);
        //        HSLog(@"%@",[NSString stringWithUTF8String:attributeName]);
        id value =  nil;
        SEL sel = NSSelectorFromString(key);
        if([object respondsToSelector:sel]){
            // value = [entity performSelector:sel];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            value = [object performSelector:sel];
#pragma clang diagnostic push
            
        }
        if(value == nil){
            value = [NSNull null];
        }
        [self setValue:value forKey:key];
    }
    free(properties);
}


@end
