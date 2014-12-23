//
//  NSDictionary+Dictionary2JSON.m
//  BaseProject
//
//  Created by Zou on 10/9/14.
//  Copyright (c) 2014 Zou. All rights reserved.
//

#import "NSDictionary+Dictionary2JSON.h"

@implementation NSDictionary (Dictionary2JSON)

-(NSString*)dictionary2JSON:(NSDictionary*)targetDictionary
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:targetDictionary
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if ([jsonData length] > 0 && error == nil){
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];;
    }else{
        return nil;
    }
}
@end
