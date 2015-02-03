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
#import "RequestXMLBuilder.h"
#import "HttpResult.h"
#import "SQLBuilder.h"
#import "HttpResult.h" 
#import "Constant.h"

#define NEED_ENCRYPT YES

@interface HttpClient : NSObject

@property (nonatomic, strong) NSString *host;

+(void)request:(RequestXMLBuilder*)params completionBlock:(HttpResultBlock)resultBlcok errorBlock:(ErrorBlock)errorBlock;

@end
