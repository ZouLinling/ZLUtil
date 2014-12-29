//
//  HttpHelper.m
//  ZLUtil
//
//  Created by Zou on 12/25/14.
//  Copyright (c) 2014 Zou. All rights reserved.
//

#import "RequestHelper.h"
#import "GDataXMLNode.h"

@implementation RequestHelper

/*************XML Pattern*************/
//<?xml version="1.0" encoding="UTF-8"?>
//<Root>
//<method action="P|Q|E">
//<classPath>com.soar.ClassPath</classPath>
//<methodName>methodName</methodName>
//<sql pageSize="50" pageIndex="2" pagination="true">select * from dual</sql>
//</method>
//<result code="00|01|02|99"  message="失败|成功|重复|异常(code)"/>
//<mapData arg0="v0" arg1="v1" arg2="v2"/>
//<dataset>
//<data arg0="v0" arg1="v1" arg2="v2"/>
//</dataset>
//</Root>
-(NSString*)buildXml
{
    GDataXMLElement *rootElement = [GDataXMLNode elementWithName:XML_NODE_ROOT];
    
    GDataXMLElement *methodElement = [GDataXMLNode elementWithName:XML_NODE_METHOD];
    GDataXMLNode *actionAttribute = [GDataXMLNode elementWithName:@"action" stringValue:_method];
    [methodElement addAttribute:actionAttribute];
    
    [methodElement addChild:[GDataXMLNode elementWithName:XML_NODE_CLASSPATH stringValue:_classPath]];
    
    [methodElement addChild:[GDataXMLNode elementWithName:XML_NODE_METHOD_NAME stringValue:_methodName]];
    
    GDataXMLElement *sqlElement = [GDataXMLElement elementWithName:XML_NODE_SQL stringValue:_sql];
    //服务端解析attribute并不是根据属性名字来解析的，而是根据顺序，所以这里的name都可以不是固定的，但是顺序不能修改
    GDataXMLNode *attribute1 = [GDataXMLNode elementWithName:@"pageSize" stringValue:[RequestHelper int2String:_pageSize]];
    [sqlElement addAttribute:attribute1];
    GDataXMLNode *attribute2 = [GDataXMLNode elementWithName:@"pageIndex" stringValue:[RequestHelper int2String:_pageIndex]];
    [sqlElement addAttribute:attribute2];
    GDataXMLNode *attribute3 = [GDataXMLNode elementWithName:@"itemCount" stringValue:[RequestHelper int2String:_itemCount]];
    [sqlElement addAttribute:attribute3];
    GDataXMLNode *attribute4 = [GDataXMLNode elementWithName:@"pagination" stringValue:_pagination == YES?@"true":@"false"];
    [sqlElement addAttribute:attribute4];
    [methodElement addChild:sqlElement];
    
    [rootElement addChild:methodElement];
    
    if (_kvData != nil) {
        GDataXMLElement *kvdataElement = [GDataXMLNode elementWithName:XML_NODE_KVDATA];
        for (NSString *key in _kvData) {
            [kvdataElement addAttribute:[GDataXMLNode elementWithName:key stringValue:_kvData[key]]];
        }
        [rootElement addChild:kvdataElement];
    }
    
    if(_dataset != nil) {
        GDataXMLElement *datasetElement = [GDataXMLNode elementWithName:XML_NODE_DATASET];
        for (NSDictionary *dict in _dataset) {
            GDataXMLElement *dataElement = [GDataXMLNode elementWithName:XML_NODE_DATA];
            for (NSString *key in dict) {
                [dataElement addAttribute:[GDataXMLNode elementWithName:key stringValue:dict[key]]];
            }
            [datasetElement addChild:dataElement];
        }
        [rootElement addChild:datasetElement];
    }
    //使用根节点创建xml文档
    GDataXMLDocument *xmlDocument = [[GDataXMLDocument alloc] initWithRootElement:rootElement];
    //设置使用的xml版本号
    [xmlDocument setVersion:@"1.0"];
    //设置xml文档的字符编码
    [xmlDocument setCharacterEncoding:@"utf-8"];
    
    //获取并打印xml字符串
    NSString *xmlString = [[NSString alloc] initWithData:xmlDocument.XMLData encoding:NSUTF8StringEncoding];
    NSLog(@"%@", xmlDocument);
    return xmlString;
}

+(NSString*)int2String:(int)intValue
{
    return [NSString stringWithFormat:@"%d",intValue];
}

@end
