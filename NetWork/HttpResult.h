//
//  HttpResult.h
//  ZLUtil
//
//  Created by Zou on 12/25/14.
//  Copyright (c) 2014 Zou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpResult : NSObject

#define RESULT_SUCCESS @"success"
#define RESULT_FAIL @"fail"

@property (nonatomic,strong) NSString *code;
@property (nonatomic,strong) NSString *message;

+(HttpResult*)parseResult:(NSString*)xmlResult;

/**
 *  如果返回值kvData是用JSON形式，使用下面的宏，如果使用原始的格式，注释下面的宏
 *
 */
#define USE_JSON

#ifdef USE_JSON

@property (nonatomic,strong) NSDictionary *jsonDict; //JSON格式的返回值
#define ERROR_CODE @"error_code"
#define RESULT @"result"
#define RESULT_SUCCESS_CODE @"0"

#else

@property (nonatomic,strong) NSMutableDictionary *kvdata;
@property (nonatomic,strong) NSMutableArray *dataset;
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
#define HTTP_RESULT_ERROR_DICTIONARY_KEY @"ErrorMessage"

#endif

@end
