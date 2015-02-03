//
//  NSData+Compressor.h
//  B2C
//
//  Created by Zou on 2/2/15.
//  Copyright (c) 2015 Zou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Compressor)

-(NSData *)uncompressZippedData;

-(NSData*) gzipData;

@end
