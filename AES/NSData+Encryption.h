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
- (NSData *)AES256EncryptWithKey:(NSData *)key;   //加密
- (NSData *)AES256DecryptWithKey:(NSData *)key;   //解密
//- (NSString *)newStringInBase64FromData;            //追加64编码
//+ (NSString*)base64encode:(NSString*)str;           //同上64编码

@end
