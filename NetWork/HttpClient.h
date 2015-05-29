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
#define BOOL_RESULT_SUCCESS @"SUCCESS"

@interface HttpClient : NSObject

@property (nonatomic, strong) NSString *host;

#ifdef USE_JSON
/**
 *
 *
 *  @param params
 *  @param resultBlcok 三种情况的返回值，一种是NSDictionary，另一种是NSArray（值是N个NSDictionary）
 *                     第三种情况是NSString，bool类型或者是提示信息
 *  @param errorBlock
 */
+(void)request:(RequestXMLBuilder*)params completionBlock:(ObjectBlock)resultBlcok errorBlock:(ErrorBlock)errorBlock;

//上传文件用
+(void)requestWithFile:(RequestXMLBuilder*)params file:(NSString*)filePath completionBlock:(ObjectBlock)resultBlcok errorBlock:(ErrorBlock)errorBlock;
#else
+(void)request:(RequestXMLBuilder*)params completionBlock:(HttpResultBlock)resultBlcok errorBlock:(ErrorBlock)errorBlock;
#endif

+(void)cancelRequest;

@end
