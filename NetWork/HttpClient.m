//
//  HttpClient.m
//  B2C
//
//  Created by Zou on 12/26/14.
//  Copyright (c) 2014 Zou. All rights reserved.
//

#import "HttpClient.h"
#import "XMLHelper.h"
#import "HttpResult.h"

@implementation HttpClient

+(void)request:(XMLHelper*)params completionBlock:(ArrayBlock)resultBlcok errorBlock:(ErrorBlock)errorBlock;
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
        resultBlcok(result.dataset);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // handle network related errors here
    }];
    [manager.operationQueue addOperation:operation];
}

@end
