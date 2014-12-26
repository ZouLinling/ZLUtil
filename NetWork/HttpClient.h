//
//  HttpClient.h
//  B2C
//
//  Created by Zou on 12/26/14.
//  Copyright (c) 2014 Zou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "ZLBlocks.h"
@class XMLHelper;

#define HOST   @"http://192.168.2.1:8080/dyshop/rmi"

@interface HttpClient : NSObject

@property (nonatomic, strong) NSString *host;

+(void)request:(XMLHelper*)params completionBlock:(ArrayBlock)resultBlcok errorBlock:(ErrorBlock)errorBlock;

@end
