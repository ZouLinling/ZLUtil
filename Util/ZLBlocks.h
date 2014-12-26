//
//  ZLBlocks.h
//  BaseProject
//
//  Created by Zou on 10/27/14.
//  Copyright (c) 2014 Zou. All rights reserved.
//

typedef void (^StringBlock)(NSString* result);

typedef void (^ObjectBlock)(id object);

typedef void (^ArrayBlock)(NSArray* array);

typedef void (^ErrorBlock)(NSError* error);