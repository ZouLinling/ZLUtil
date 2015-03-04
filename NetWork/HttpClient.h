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

#define NEED_ENCRYPT NO

@interface HttpClient : NSObject

@property (nonatomic, strong) NSString *host;

#ifdef USE_JSON
+(void)request:(RequestXMLBuilder*)params completionBlock:(StringBlock)resultBlcok errorBlock:(ErrorBlock)errorBlock;
#else
+(void)request:(RequestXMLBuilder*)params completionBlock:(HttpResultBlock)resultBlcok errorBlock:(ErrorBlock)errorBlock;
#endif

@end
