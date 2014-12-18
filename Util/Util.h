//
//  Util.h
//  BaseProject
//
//  Created by Zou on 3/25/14.
//  Copyright (c) 2014 Zou. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MBProgressHUD;

enum {
    // iPhone 1,3,3GS 标准分辨率(320x480px)
    UIDevice_iPhoneStandardRes      = 1,
    // iPhone 4,4S 高清分辨率(640x960px)
    UIDevice_iPhoneHiRes            = 2,
    // iPhone 5 高清分辨率(640x1136px)
    UIDevice_iPhoneTallerHiRes      = 3,
    // iPad 1,2 标准分辨率(1024x768px)
    UIDevice_iPadStandardRes        = 4,
    // iPad 3 High Resolution(2048x1536px)
    UIDevice_iPadHiRes              = 5
}; typedef NSUInteger UIDeviceResolution;

enum {
    
    Carrier_China_Telecom       = 1,

    Carrier_China_Mobile        = 2,

    Carrier_China_Unicom        = 3,

    Carrier_Unknow              = 4
}; typedef NSUInteger CarrierType;

@interface Util : NSObject


//判断是否有网络
+ (BOOL) isNetworkAvailable;

//获取当前分辨率
+ (UIDeviceResolution) currentResolution;

//是否是iPhone5
+ (BOOL)isRunningOniPhone5;

//是否是iPhone
+ (BOOL)isRunningOniPhone;

+ (BOOL)isRunningOniOS7;

+ (BOOL)iSRunningOniOS8;

//获取String的MD5值，可以设定大写或小写
+ (NSString *)getMD5StringFormString:(NSString *)string toUpCase:(BOOL) toUpCase;

//弹出消息提示，1.5秒后小时
+(void)makeToast:(NSString *)message;

//显示加载提示
+(MBProgressHUD*) showProgressHud:(UIView *)parentView;

//获取当前时间格式化字符串
+ (NSString*)currentTimeString;

//获取当前时间格式化字符串,无空格
+(NSString*)currentTimeWithoutSpace;

//检查电话号码格式
+ (BOOL)checkPhoneNumInput:(NSString *)phone;

//push 一个指定的ViewController
+(void)pushViewController:(Class)viewControllerClass navigationController:(UINavigationController*)navigationController hideTabBar:(BOOL)hideTabBar;

//格式化价格显示
+ (NSString*)formatMoney:(float)money;

//格式化日期显示 yyyy-MM-dd HH:mm:ss
+ (NSString*)formatDate:(long)timeMills;

//格式化日期显示
+ (NSString*)formatDateByDay:(NSString*)formattedDateBySeconds;

//今天，2014-09-09 形式
+ (NSString*)today;

//根据对象实例，获取格式化的JSON字符串，classInstance最好是NSObject的实例，支持嵌套解析
+ (NSString *) getDicFromNormalClass:(id) classInstance;

//求时间差
+ (NSString *) getTimeRelese:(NSString *)timenode;

/**
 *  iOS6下UISegment的扁平化
 *
 *  @param selectedColor 选中时的背景颜色
 *  @param normalColor   未选中时的背景颜色
 */
+(void)iOS7StyleForUISegmentUnderiOS6:(UIColor*)selectedColor normalColor:(UIColor*)normalColor;

/**
 *  iOS6下的nav的返回按钮的扁平化
 *
 *  @param backImageName 回退图片的名字
 */
+(void)iOS7StyleForUIBarButtonItemUnderiOS6:(NSString*)backImageName;


+(void)addBorderForView:(UIView*)view addLeft:(BOOL)left addRight:(BOOL)right addTop:(BOOL)top addBottom:(BOOL)bottom borderColor:(UIColor*)color;

+(CarrierType)carrier;
@end
