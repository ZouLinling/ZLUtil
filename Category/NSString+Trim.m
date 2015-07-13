//
//  NSString+Trim.m
//  B2C
//
//  Created by Zou on 7/13/15.
//  Copyright (c) 2015 Zou. All rights reserved.
//

#import "NSString+Trim.h"

@implementation NSString (Trim)

/**
 *  去除首尾空格
 *
 *  @return
 */
-(NSString*)trim
{
    return  [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end
