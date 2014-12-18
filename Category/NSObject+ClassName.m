//
//  NSObject+ClassName.m
//  B2C
//
//  Created by Zou on 7/3/14.
//  Copyright (c) 2014 Zou. All rights reserved.
//

#import "NSObject+ClassName.h"
#import "objc/runtime.h"

@implementation NSObject (ClassName)

+ (NSString *)className
{
    return [NSString stringWithUTF8String:class_getName(self)];
}

@end
