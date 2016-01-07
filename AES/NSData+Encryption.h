//
//  NSData+Encryption.h
//  B2C
//
//  Created by Zou on 4/16/15.
//  Copyright (c) 2015 Zou. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NSString;

@interface NSData (Encryption)
/**
 *  AES加密
 *
 *  @param key 32位的key值，注意key值必须是32位，否则跨平台使用时会有问题
 *
 *  @return
 */
- (NSData *)AES256EncryptWithKey:(NSData *)key;
/**
 *  AES解密
 *
 *  @param key 32位的key值，注意key值必须是32位，否则跨平台使用时会有问题
 *
 *  @return
 */
- (NSData *)AES256DecryptWithKey:(NSData *)key;
//- (NSString *)newStringInBase64FromData;            //追加64编码
//+ (NSString*)base64encode:(NSString*)str;           //同上64编码

@end
