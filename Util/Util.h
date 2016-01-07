//
//  Util.h
//  BaseProject
//
//  Created by Zou on 3/25/14.
//  Copyright (c) 2014 Zou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIColor+UIColorFromHex.h"
#import "UIImage+UIRoundedRectImage.h"
#import "UIImage+UIImageFromUIColor.h"
#import "UINavigationBar+Customize.h"
#import "UIImage+CircleImage.h"
@class MBProgressHUD;
/**
 不同设备的屏幕分辨率
 */
enum {
    /**
     *  iPhone 1,3,3GS 标准分辨率(320x480px)
     */
    UIDevice_iPhone         = 1,
    /**
     *  iPhone 4,4S 高清分辨率(640x960px)
     */
    UIDevice_iPhone4        = 2,
    /**
     *  iPhone 5 高清分辨率(640x1136px)
     */
    UIDevice_iPhone5        = 3,
    /**
     *  iPad 1,2 标准分辨率(1024x768px)
     */
    UIDevice_iPadStandard   = 4,
    /**
     *  iPad 3 High Resolution(2048x1536px)
     */
    UIDevice_iPad3          = 5,
    /**
     *  1334×750
     */
    UIDevice_iPhone6        = 6,
    /**
     *  1920×1080
     */
    UIDevice_iPhone6P       = 7
    
}; typedef NSUInteger UIDeviceResolution;

enum {

    /**
     *  中国电信
     */
    Carrier_China_Telecom       = 1,
    /**
     *  中国移动
     */
    Carrier_China_Mobile        = 2,
    /**
     *  中国联通
     */
    Carrier_China_Unicom        = 3,
    /**
     *  其他
     */
    Carrier_Unknow              = 4
}; typedef NSUInteger CarrierType;

@interface Util : NSObject


/**
 *  判断是否有网络
 *  @deprecated 直接使用[[CloudClient sharedInstance] isReachable];
 *  @return
 */
+ (BOOL) isNetworkAvailable;

/**
 *  获取当前分辨率
 *
 *  @return
 */
+ (UIDeviceResolution) currentResolution;

/**
 *  是否是iPhone5
 *
 *  @return
 */
+ (BOOL)isRunningOniPhone5;

/**
 *  是否是iPhone
 *
 *  @return
 */
+ (BOOL)isRunningOniPhone;

/**
 *  是否是iOS7.0以上
 *
 *  @return
 */
+ (BOOL)isiOS7Available;

/**
 *  是否是iOS8.0以上
 *
 *  @return
 */
+ (BOOL)iSiOS8Available;

/**
 *  获取String的MD5值，可以设定大写或小写
 *
 *  @param string   待加密字符串
 *  @param toUpCase 是否大写
 *
 *  @return
 */
+ (NSString *)MD5String:(NSString *)string whetherUpCase:(BOOL) toUpCase;

/**
 *  成功提示
 *
 *  @param message
 */
+(void)showSuccess;

/**
 *  弹出消息提示，1.5秒后消失
 *
 *  @param message 提示内容
 */
+(void)makeToast:(NSString *)message;

/**
 *  显示正在加载提示
 *
 *  @return
 */
+(MBProgressHUD*) showProgressHud;

/**
 *  获取当前时间格式化字符串  2016-01-07 13:36:38 形式
 *
 *  @return
 */
+ (NSString*)currentTimeString;

/**
 *  获取当前时间格式化字符串,无空格  20160107_13_36_38 形式
 *
 *  @return
 */
+(NSString*)currentTimeWithoutSpace;

/**
 *  检查电话号码格式
 *
 *  @param phone
 *
 *  @return
 */
+ (BOOL)checkPhoneNumInput:(NSString *)phone;

/**
 *  push 一个指定的ViewController
 *
 *  @param viewControllerClass  目标viewcontroller类
 *  @param navigationController 导航栏控制器
 *  @param hideTabBar           是否隐藏tabbar
 */
+(void)pushViewController:(Class)viewControllerClass navigationController:(UINavigationController*)navigationController hideTabBar:(BOOL)hideTabBar;

/**
 *  格式化价格显示 例如：￥1.00
 *
 *  @param money
 *
 *  @return
 */
+ (NSString*)formatMoney:(float)money;

/**
 *  格式化日期显示 yyyy-MM-dd HH:mm:ss     
 *
 *  @param timeMills
 *
 *  @return
 */
+ (NSString*)formatDate:(long)timeMills;

/**
 *  格式化日期显示 yyyy-MM-dd
 *
 *  @param formattedDateBySeconds
 *
 *  @return
 */
+ (NSString*)formatDateByDay:(NSString*)formattedDateBySeconds;

/**
 *  今天，2014-09-09 形式
 *
 *  @return
 */
+ (NSString*)today;

/**
 *  求时间差 0日0时0分0秒结束 形式
 *
 *  @param timenode
 *
 *  @return
 */
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

/**
 *  添加边框
 *
 *  @param view
 *  @param left
 *  @param right
 *  @param top
 *  @param bottom
 *  @param color
 */
+(void)addBorderForView:(UIView*)view addLeft:(BOOL)left addRight:(BOOL)right addTop:(BOOL)top addBottom:(BOOL)bottom borderColor:(UIColor*)color;

/**
 *  bool转字符串
 *
 *  @param boolValue
 *
 *  @return
 */
+(NSString*)bool2String:(BOOL)boolValue;

/**
 *  整型转字符串
 *
 *  @param intValue
 *
 *  @return
 */
+(NSString*)int2String:(int)intValue;

/**
 *  浮点型转字符串
 *
 *  @param floatValue
 *
 *  @return
 */
+(NSString*)float2String:(float)floatValue;

/**
 *  拼接字符串
 *
 *  @param string1
 *  @param string2
 *
 *  @return
 */
+(NSString*)combineString:(NSString*)string1 with:(NSString*)string2;

/**
 *  获取运营商信息
 *
 *  @return
 */
+(CarrierType)carrier;

/**
 *  实现富文本显示,效果是在显示的文本上增加一条划线
 *
 *  @param label 目标label
 *  @param text  文本
 */
+(void)strikethroughLabel:(UILabel*)label withText:(NSString*)text;

/**
 *  删除返回按钮边上的文字,注意，这是删除下一个页面的返回按钮的文字，对当前页面无效
 *
 *  @param navigationItem
 */
+(void)deleteBackTitle:(UINavigationItem*)navigationItem;

/**
 *  自定义圆角button的背景色
 *
 *  @param button
 *  @param enabledColor      button启用时的颜色 16进制
 *  @param disabledColor     button禁用时的颜色 16进制
 *  @param hasFilletedCorner 是否需要圆角
 */
+(void)customButton:(UIButton*)button enabledColor:(NSInteger)enabledColor disabledColor:(NSInteger)disabledColor whetherFilletedCorner:(BOOL)hasFilletedCorner;

/**
 *  隐藏tableview的横线（无数据）
 *
 *  @param tableView 
 */
+ (void)setExtraCellLineHidden: (UITableView *)tableView;

@end
