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
    }
    return result;
}
@end
