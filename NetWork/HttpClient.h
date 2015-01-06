//
//  HttpClient.h
//  ZLUtil
//
//  Created by Zou on 12/26/14.
//  Copyright (c) 2014 Zou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "ZLBlocks.h"
#import "RequestHelper.h"
#import "HttpResult.h"
#import "SQLBuilder.h"
#import "HttpResult.h"

#define HOST   @"http://192.168.2.1:8080/dyshop/rmi"

@interface HttpClient : NSObject

@property (nonatomic, strong) NSString *host;

+(void)request:(RequestHelper*)params completionBlock:(HttpResultBlock)resultBlcok errorBlock:(ErrorBlock)errorBlock;

@end
