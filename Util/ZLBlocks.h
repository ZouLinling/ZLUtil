//
//  ZLBlocks.h
//  BaseProject
//
//  Created by Zou on 10/27/14.
//  Copyright (c) 2014 Zou. All rights reserved.
//
@class HttpResult;

typedef void (^StringBlock)(NSString* result);

typedef void (^ObjectBlock)(id object);

typedef void (^ArrayBlock)(NSArray* array);

typedef void (^ErrorBlock)(NSError* error);

typedef void (^HttpResultBlock)(HttpResult* result);

typedef void (^BoolResult)(BOOL result);

typedef void (^DictionaryBlock)(NSDictionary *result);

typedef void (^CompleteActionBlock)();