
//
//  HttpClient.m
//  ZLUtil
//
//  Created by Zou on 12/26/14.
//  Copyright (c) 2014 Zou. All rights reserved.
//

#import "HttpClient.h"
#import "RequestXMLBuilder.h"
#import "Util.h"
#import "NSData+Compressor.h"
#import "ZLGTMBase64.h"

@implementation HttpClient

#ifdef USE_JSON
+(void)request:(RequestXMLBuilder*)params completionBlock:(ObjectBlock)resultBlcok errorBlock:(ErrorBlock)errorBlock
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //注意：默认情况下AFNetWorking无法解析返回的response中content-type是text/xml的数据，这里使用别AFXMLParserResponseSerializer来代替默认的responseSerializer，这样就直接返回未经处理的数据
    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:HOST]];
    NSData *data = [[params buildXml] dataUsingEncoding:NSUTF8StringEncoding];
    if (NEED_ENCRYPT) {
        NSData *compressedData = [data gzipData];
        [request setHTTPBody:[ZLGTMBase64 encodeData:compressedData]];
    } else {
        [request setHTTPBody:data];
    }
    [request setHTTPMethod:@"POST"];
    [request setValue:HTTP_CONTENT_TYPE forHTTPHeaderField:@"Content-Type"];
    [request setTimeoutInterval:10000];
    
    NSOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        HttpResult *result = [HttpResult parseResult:[operation responseString]];
        if (result.jsonDict) {
            //有返回值
            resultBlcok(result.jsonDict);
        } else {
            //错误信息
            if (result.message) {
                [Util makeToast:result.message];
            } else {
                [Util makeToast:@"99系统错误"];
            }
            
            errorBlock(nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error.localizedDescription != nil) {
            [Util makeToast:error.localizedDescription];
        } else {
            [Util makeToast:@"网络请求错误，请稍后再试"];
        }
        errorBlock(error);
    }];
    [manager.operationQueue addOperation:operation];
}

//上传文件用
+(void)requestWithFile:(RequestXMLBuilder*)params file:(NSString*)filePath completionBlock:(ObjectBlock)resultBlcok errorBlock:(ErrorBlock)errorBlock
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //注意：默认情况下AFNetWorking无法解析返回的response中content-type是text/xml的数据，这里使用别AFXMLParserResponseSerializer来代替默认的responseSerializer，这样就直接返回未经处理的数据
    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSMutableURLRequest *request = [manager.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:HOST parameters:nil constructingBodyWithBlock: ^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileURL:[NSURL URLWithString:filePath] name:@"RECORD_NAME" error:nil];
    } error:nil];
    
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:HOST]];
    NSData *data = [[params buildXml] dataUsingEncoding:NSUTF8StringEncoding];
    if (NEED_ENCRYPT) {
        NSData *compressedData = [data gzipData];
        [request setHTTPBody:[ZLGTMBase64 encodeData:compressedData]];
    } else {
        [request setHTTPBody:data];
    }
    [request setHTTPMethod:@"POST"];
    [request setValue:HTTP_CONTENT_TYPE forHTTPHeaderField:@"Content-Type"];
    [request setTimeoutInterval:10000];
    
//    NSOperation *operation = [manager POST:@"" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        [formData appendPartWithFileURL:nil name:@"RECORD_NAME" error:nil];
//    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        HttpResult *result = [HttpResult parseResult:[operation responseString]];
//        if (result.jsonDict) {
//            //有返回值
//            resultBlcok(result.jsonDict);
//        } else {
//            //错误信息
//            if (result.message) {
//                [Util makeToast:result.message];
//            } else {
//                [Util makeToast:@"99系统错误"];
//            }
//
//            errorBlock(nil);
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        if (error.localizedDescription != nil) {
//            [Util makeToast:error.localizedDescription];
//        } else {
//            [Util makeToast:@"网络请求错误，请稍后再试"];
//        }
//        errorBlock(error);
//    }];
    NSOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        HttpResult *result = [HttpResult parseResult:[operation responseString]];
        if (result.jsonDict) {
            //有返回值
            resultBlcok(result.jsonDict);
        } else {
            //错误信息
            if (result.message) {
                [Util makeToast:result.message];
            } else {
                [Util makeToast:@"99系统错误"];
            }
            
            errorBlock(nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error.localizedDescription != nil) {
            [Util makeToast:error.localizedDescription];
        } else {
            [Util makeToast:@"网络请求错误，请稍后再试"];
        }
        errorBlock(error);
    }];
    [manager.operationQueue addOperation:operation];
}

#else

+(void)request:(RequestXMLBuilder*)params completionBlock:(HttpResultBlock)resultBlcok errorBlock:(ErrorBlock)errorBlock;
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //注意：默认情况下AFNetWorking无法解析返回的response中content-type是text/xml的数据，这里使用别AFXMLParserResponseSerializer来代替默认的responseSerializer，这样就直接返回未经处理的数据
    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:HOST]];
    NSData *data = [[params buildXml] dataUsingEncoding:NSUTF8StringEncoding];
    if (NEED_ENCRYPT) {
        NSData *compressedData = [data gzipData];
        [request setHTTPBody:[ZLGTMBase64 encodeData:compressedData]];
    } else {
        [request setHTTPBody:data];
    }
    [request setHTTPMethod:@"POST"];
    [request setValue:HTTP_CONTENT_TYPE forHTTPHeaderField:@"Content-Type"];
    [request setTimeoutInterval:10];
    
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
#endif

+(void)cancelRequest
{
    
}

@end
