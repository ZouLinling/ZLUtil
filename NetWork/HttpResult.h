//
//  HttpResult.h
//  B2C
//
//  Created by Zou on 12/25/14.
//  Copyright (c) 2014 Zou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpResult : NSObject

#define RESULT_CODE @"code"
#define RESULT_MESSAAGE @"msg"

#define HTTP_STATUS_CODE_FAIL @"00"
#define HTTP_STATUS_MESAAGE_FAIL @"操作失败，请重试..."

#define HTTP_STATUS_CODE_SUCCESS @"01"
#define HTTP_STATUS_MESAAGE_SUCCESS @"操作成功..."

#define HTTP_STATUS_CODE_REPEAT @"02"
#define HTTP_STATUS_MESAAGE_REPEAT @"重复项，请检查数据..."

#define HTTP_STATUS_CODE_EXCEPTION @"99"
#define HTTP_STATUS_MESAAGE_EXCEPTION @"系统异常，请联系服务商..."

@property (nonatomic,strong) NSString *code;
@property (nonatomic,strong) NSString *message;
@property (nonatomic,strong) NSMutableDictionary *kvdata;
@property (nonatomic,strong) NSMutableArray *dataset;

+(HttpResult*)parseResult:(NSString*)xmlResult;

@end
