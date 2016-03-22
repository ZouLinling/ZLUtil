//
//  NSData+Compressor.h
//  B2C
//
//  Created by Zou on 2/2/15.
//  Copyright (c) 2015 Zou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Compressor)
/**
 *  解压缩，可以解压zip与gzip压缩过的字符串
 *
 *  @return
 */
-(NSData *)uncompressZippedData;

/**
 *  压缩成gzip格式
 *
 *  @return
 */
-(NSData*) gzipData;

@end
