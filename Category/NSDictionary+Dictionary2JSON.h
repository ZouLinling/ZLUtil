//
//  NSDictionary+Dictionary2JSON.h
//  BaseProject
//
//  Created by Zou on 10/9/14.
//  Copyright (c) 2014 Zou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Dictionary2JSON)
/**
 *  字典转换成JSON
 *
 *  @param targetDictionary 待转换目标字典
 *
 *  @return
 */
-(NSString*)dictionary2JSON:(NSDictionary*)targetDictionary;
@end
