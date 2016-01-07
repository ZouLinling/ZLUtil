//
//  NSString+URL.h
//  B2C
//
//  Created by Zou on 8/21/14.
//  Copyright (c) 2014 Zou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URL)
/**
 *  将URL中的非拉丁字符转换成全拉丁字符
 *
 *  @return
 */
- (NSString *)URLEncodedString;

@end
