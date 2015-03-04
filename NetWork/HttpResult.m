//
//  HttpResult.m
//  ZLUtil
//
//  Created by Zou on 12/25/14.
//  Copyright (c) 2014 Zou. All rights reserved.
//

#import "HttpResult.h"
#import "GDataXMLNode.h"
#import "RequestXMLBuilder.h"
#import "NSString+URL.h"
#import "HttpClient.h"
#import "NSData+Compressor.h"
#import "ZLGTMBase64.h"
#import "JSONKit.h"

@implementation HttpResult

+(HttpResult*)parseResult:(NSString*)xmlResult
{
    HttpResult *result = [self alloc];
    NSData *resultData = [xmlResult dataUsingEncoding:NSUTF8StringEncoding];
    NSData *xmlData;
    if (NEED_ENCRYPT) {
        xmlData = [[ZLGTMBase64 decodeData:resultData] uncompressZippedData];
    } else {
        xmlData = resultData;
    }
    NSError *error;
    GDataXMLDocument *xmlDocument = [[GDataXMLDocument alloc] initWithData:xmlData options:0 error:&error];
    NSArray *elements = [[xmlDocument rootElement] children];
    for (GDataXMLElement *element in elements) {
#ifdef USE_JSON
        if ([[element name] isEqualToString:XML_NODE_KVDATA]) {
            //EXAMPLE:<kvdata response="JSON"/>
            //JSON 示例
            //{"error_code":"0","result":{"user_id":"1234","user_name":"ljn"}}
            //{"error_code":"101","result":"密码错误"}
            NSArray *attributes = [element attributes];
            //按照与接口方的协议，这里attributes中有且只有一个元素response
            result.kvdata = [[NSMutableDictionary alloc] init];
            NSString *response;
            for (GDataXMLNode *node in attributes) {
                response = [node stringValue];
                break;
            }
            if (response) {
                NSDictionary *dict = [response objectFromJSONString];
                result.code = [dict objectForKey:ERROR_CODE];
                if ([result.code isEqualToString:RESULT_SUCCESS_CODE]) {
                    result.jsonResult = [dict objectForKey:RESULT];
                } else {
                    result.jsonResult = nil;
                    result.message = [dict objectForKey:RESULT];
                }
            }
        }
#else
        if ([[element name] isEqualToString:XML_NODE_RESULT]) {
            //EXAMPlE:<Result code = "00" message="操作失败，请重试..."/>
            result.code = [[element attributeForName:RESULT_CODE] stringValue];
            result.message = [[element attributeForName:RESULT_MESSAAGE] stringValue];
        } else if ([[element name] isEqualToString:XML_NODE_KVDATA]) {
            //EXAMPLE:<kvdata name="zoulinling" gender="male"/>
            NSArray *attributes = [element attributes];
            result.kvdata = [[NSMutableDictionary alloc] init];
            for (GDataXMLNode *node in attributes) {
                [result.kvdata setObject:[node stringValue] forKey:[node name]];
            }
        } else if ([[element name] isEqualToString:XML_NODE_DATASET]) {
            //EXAMPLE:
            //<dataset>
            //<data name="zoulinling" gender="male"/>
            //<data name="zhangaoxiang" gender="male"/>
            //</dataset>
            result.dataset = [[NSMutableArray alloc] init];
            NSArray *dataArray = [element children];
            for (GDataXMLElement *data in dataArray) {
                NSArray *attributes = [data attributes];
                NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                for (GDataXMLNode *node in attributes) {
                    [dict setObject:[node stringValue] forKey:[node name]];
                }
                [result.dataset addObject:dict];
            }
        }
#endif
        
    }
    return result;
}
@end
