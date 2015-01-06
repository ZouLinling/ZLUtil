//
//  HttpHelper.h
//  ZLUtil
//  服务端使用HttpServlet来提供数据服务，通用情况下，根据本类中提供的数据进行查询
//  或者反射执行具体的方法。
//  数据传输使用是xml，本类实现服务端所需的固定格式的xml
//  Created by Zou on 12/25/14.
//  Copyright (c) 2014 Zou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestHelper : NSObject

#define METHOD_QUERY @"Q"

#define METHOD_EXECUTE @"E"

#define BUFFSIZE 4096

#define HTTP_CHARSET @"UTF-8"

#define HTTP_CONNECT_TIMEOUT 1000

#define HTTP_CONTENT_TYPE @"text/html; charset=UTF-8"

#define XML_NODE_ROOT @"Root"

#define XML_NODE_METHOD @"method"

#define XML_NODE_CLASSPATH @"classPath"

#define XML_NODE_METHOD_NAME @"methodName"

#define XML_NODE_SQL @"Sql"

#define XML_NODE_KVDATA @"kvdata"

#define XML_NODE_DATASET @"dataset"

#define XML_NODE_DATA @"data"

#define XML_NODE_RESULT @"result"

#define DEFAULT_PAGESIZE 15

@property (nonatomic,strong) NSString *method;
@property (nonatomic,strong) NSString *classPath;
@property (nonatomic,strong) NSString *methodName;
@property (nonatomic,strong) NSString *sql;
@property (nonatomic,strong) NSMutableDictionary *kvData;
@property (nonatomic,strong) NSMutableArray *dataset; //data的集合，实际也是key-value的集合
@property int pageSize; //客户端不用设置，统一设置为DEFAULT_PAGESIZE
@property int pageIndex; //当前页码，从1开始
@property int itemCount; //第一次调用使用0，后面使用服务器返回数据
@property BOOL pagination;

-(NSString*)buildXml;
@end