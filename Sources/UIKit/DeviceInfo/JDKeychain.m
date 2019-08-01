//
//  JDKeychain.m
//  JDFoundation
//
//  Created by jd on 2015/03/04.
//  Copyright (c) 2015 年 jd. All rights reserved.
//

#import "JDKeychain.h"
#import <Security/Security.h>

@implementation JDKeychain


+ (NSMutableDictionary *)keychainQueryForKey:(NSString *)key {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (__bridge id)kSecClassGenericPassword,(__bridge id)kSecClass,
            key, (__bridge id)kSecAttrService,
            key, (__bridge id)kSecAttrAccount,
            (__bridge id)kSecAttrAccessibleAfterFirstUnlock,(__bridge id)kSecAttrAccessible,
            nil];
}


+ (BOOL)saveData:(id)data forKey:(NSString *)key {
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [self keychainQueryForKey:key];
    //Delete old item before add new item
    SecItemDelete((__bridge CFDictionaryRef)keychainQuery);
    //Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(__bridge id)kSecValueData];
    //Add item to keychain with the search dictionary
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)keychainQuery, NULL);
    return status == errSecSuccess;
}


+ (nullable id)dataForKey:(NSString *)key {
    id returnValue = nil;
    NSMutableDictionary *keychainQuery = [self keychainQueryForKey:key];
    //Configure the search setting
    //Since in our simple case we are expecting only a single attribute to be returned (the password) we can set the attribute kSecReturnData to kCFBooleanTrue
    [keychainQuery setObject:(__bridge id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    [keychainQuery setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((__bridge CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            returnValue = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", key, e);
        } @finally {
        }
    }
    if (keyData != NULL) {
        CFRelease(keyData);
    }
    return returnValue;
}


+ (BOOL)deleteDataForKey:(NSString *)key {
    NSMutableDictionary *keychainQuery = [self keychainQueryForKey:key];
    OSStatus status = SecItemDelete((__bridge CFDictionaryRef)keychainQuery);
    return status == errSecSuccess;
}


@end
