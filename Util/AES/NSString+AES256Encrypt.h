//
//  NSString+AES256Encrypt.h
//  B2C
//
//  Created by Zou on 4/16/15.
//  Copyright (c) 2015 Zou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AES256Encrypt)

/**
 *  AES 256加密
 *
 *  @param key 32位的key值，注意key值必须是32位，否则跨平台使用时会有问题
 *
 *  @return
 */
-(NSString*)AES256Encrypt:(NSString*)key;

-(NSString*)AES256Decrypt:(NSString*)key;

@end
