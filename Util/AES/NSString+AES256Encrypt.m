//
//  NSString+AES256Encrypt.m
//  B2C
//
//  Created by Zou on 4/16/15.
//  Copyright (c) 2015 Zou. All rights reserved.
//

#import "NSString+AES256Encrypt.h"
#import "NSData+Encryption.h"
#import "ZLGTMBase64.h"
@implementation NSString (AES256Encrypt)

/**
 *  AES 256加密
 *
 *  @param key 32位的key值，注意key值必须是32位，否则跨平台使用时会有问题
 *
 *  @return
 */
-(NSString*)AES256Encrypt:(NSString*)key
{
    NSData *keyData = [[NSData alloc] initWithBytes:[[key dataUsingEncoding: NSUTF8StringEncoding] bytes] length:32];
    NSData *valueData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSData *resultData = [valueData AES256EncryptWithKey:keyData];
    NSString *result = [ZLGTMBase64 stringByEncodingData:resultData];
    return result;
}

-(NSString*)AES256Decrypt:(NSString*)key
{
    NSData *keyData = [[NSData alloc] initWithBytes:[[key dataUsingEncoding: NSUTF8StringEncoding] bytes] length:32];
    NSData *data = [ZLGTMBase64 decodeString:self];
    NSData *resultData = [data AES256DecryptWithKey:keyData];
    NSString *result = [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
    return result;
}


@end
