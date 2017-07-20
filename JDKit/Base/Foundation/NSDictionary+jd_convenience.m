//
//  NSDictionary+jd_convenience.m
//  
//
//  Created by wjd on 14-5-12.
//  Copyright (c) 2014年 wjd. All rights reserved.
//

#import "NSDictionary+jd_convenience.h"
#import <objc/runtime.h>

@implementation NSDictionary (jd_convenience)

//字典对象转为实体对象
- (void)dictionaryToEntity:(NSObject*)entity {
    if (entity) {
        for (NSString *keyName in [self allKeys]) {
            //构建出属性的set方法
            NSString *destMethodName = [NSString stringWithFormat:@"set%@:",[keyName capitalizedString]]; //capitalizedString返回每个单词首字母大写的字符串（每个单词的其余字母转换为小写）
            SEL destMethodSelector = NSSelectorFromString(destMethodName);
            if ([entity respondsToSelector:destMethodSelector]) {
                
                [entity performSelector:destMethodSelector withObject:[self objectForKey:keyName] afterDelay:0.0];
            }
        }//end for
    }//end if
}

//实体对象转为字典对象
+ (NSDictionary *)entityToDictionary:(id)entity {
    if([entity isKindOfClass:[NSDictionary class]]){
        return entity;
    }
    if([entity isKindOfClass:[NSArray class]]){
        return nil;
    }
    Class clazz = [entity class];
    u_int count;
    
    objc_property_t* properties = class_copyPropertyList(clazz, &count);
    
    NSMutableDictionary *propertiesDic = [NSMutableDictionary dictionaryWithCapacity:count];

    for (int i = 0; i < count ; i++)
    {
        objc_property_t prop=properties[i];
        const char* propertyName = property_getName(prop);
        //NSString *key = [NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding];
        NSString *key = [NSString stringWithUTF8String:propertyName];
        //        const char* attributeName = property_getAttributes(prop);
        //        NSLog(@"%@",[NSString stringWithUTF8String:propertyName]);
        //        NSLog(@"%@",[NSString stringWithUTF8String:attributeName]);
        id value =  nil;
        SEL sel = NSSelectorFromString(key);
        if([entity respondsToSelector:sel]){
           // value = [entity performSelector:sel];
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            value = [entity performSelector:sel];
    #pragma clang diagnostic push
            
        }
        if(value == nil){
            value = [NSNull null];
        }
        if(value != [NSNull null] && [value description] == nil){
            [propertiesDic setValue:[NSDictionary entityToDictionary:value] forKey:key];
        }else{
            [propertiesDic setValue:value forKey:key];
        }
    }
    free(properties);
    return propertiesDic;
}

- (NSMutableDictionary *)toMutableDictionary {
    return [NSMutableDictionary dictionaryWithDictionary:self];
}

- (id)entityForKey:(NSString *)key{
    id obj = [self valueForKey:key];
    if(obj == NULL || (NSNull *)obj == [NSNull null]){
        return nil;
    }
    return obj;
}

+ (instancetype)toTrimNill:(NSDictionary *)dictionary {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    if ([dictionary isEqual:@"<null>"] || [dictionary isEqual:@"null"]) {
        return nil;
    }
    __block NSMutableDictionary *_dic = dict;
    [dictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (obj == NULL || (NSNull *)obj == [NSNull null]) {
            obj = nil;
        }else if([obj isKindOfClass:[NSArray class]]){
            NSMutableArray *array = [NSMutableArray array];
            for (id arrayObj in obj) {
                [array addObject:[NSMutableDictionary toTrimNill:arrayObj]];
            }
            obj = array;
        }else if([obj isKindOfClass:[NSDictionary class]]){
            obj = [NSMutableDictionary toTrimNill:obj];
        }
        [_dic setValue:obj forKey:key];
    }];
    return dict;
}



+ (instancetype)dictionaryWithBundleNameForResource:(NSString *)fileName ofType:(NSString *)ext {
    return [NSDictionary dictionaryWithBundleNameForResource:fileName ofType:ext bundle:[NSBundle mainBundle]];
}
+ (instancetype)dictionaryWithBundleNameForResource:(NSString *)fileName
                                             ofType:(NSString *)ext
                                             bundle:(NSBundle *)bundle {
    NSString *path = [bundle pathForResource:fileName ofType:ext];
    return [NSDictionary dictionaryWithContentsOfFile:path];
}

- (NSString *)descriptionWithLocale:(id)locale {
    return [self descriptionPrivate];
}
- (NSString *)debugDescription {
    return [self descriptionPrivate];
}

- (NSString *)descriptionPrivate {
    NSArray *allKeys = [self allKeys];
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"{\t\n "];
    for (NSString *key in allKeys) {
            id value= self[key];
            [str appendFormat:@"\t \"%@\" = %@,\n",key, value];
    }
    [str appendString:@"}"];
    return str;
}

@end
