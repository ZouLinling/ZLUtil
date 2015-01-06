//
//  HttpClient.m
//  ZLUtil
//
//  Created by Zou on 12/26/14.
//  Copyright (c) 2014 Zou. All rights reserved.
//

#import "HttpClient.h"
#import "RequestHelper.h"
#import "HttpResult.h"
#import "Util.h"

@implementation HttpClient

+(void)request:(RequestHelper*)params completionBlock:(HttpResultBlock)resultBlcok errorBlock:(ErrorBlock)errorBlock;
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //注意：默认情况下AFNetWorking无法解析返回的response中content-type是text/xml的数据，这里使用别AFXMLParserResponseSerializer来代替默认的responseSerializer，这样就直接返回未经处理的数据
    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:HOST]];
    [request setHTTPBody:[[params buildXml] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPMethod:@"POST"];
    [request setValue:HTTP_CONTENT_TYPE forHTTPHeaderField:@"Content-Type"];
    
    NSOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        HttpResult *result = [HttpResult parseResult:[operation responseString]];
        if ([result.code isEqual:HTTP_STATUS_CODE_SUCCESS]) {
            resultBlcok(result);
        } else {
            if (result.message != nil && ![result.message isEqualToString:@""]) {
                [Util makeToast:result.message];
                NSError *error = [[NSError alloc] initWithDomain:HOST code:[result.code integerValue] userInfo:@{HTTP_RESULT_ERROR_DICTIONARY_KEY:result.message}];
                errorBlock(error);
            } else {
                [Util makeToast:@"服务器无响应，请稍后再试"];
                NSError *error = [[NSError alloc] initWithDomain:HOST code:[result.code integerValue] userInfo:@{HTTP_RESULT_ERROR_DICTIONARY_KEY:result.message}];
                errorBlock(error);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // handle network related errors here
        if (error.localizedFailureReason != nil) {
            [Util makeToast:error.localizedFailureReason];
        } else {
            [Util makeToast:@"网络请求错误，请稍后再试"];
        }
        errorBlock(error);
    }];
    [manager.operationQueue addOperation:operation];
}

@end
