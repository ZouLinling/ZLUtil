//
//  Util.m
//  BaseProject
//
//  Created by Zou on 3/25/14.
//  Copyright (c) 2014 Zou. All rights reserved.
//

#import "Util.h"
#include "netdb.h"
#import "NSObject+ClassName.h"
#import "UIImage+UIImageFromUIColor.h"
#import "SystemConfiguration/SystemConfiguration.h"
#import <MBProgressHUD.h>
#import  <CoreTelephony/CTCarrier.h>
#import <CommonCrypto/CommonDigest.h>
#import  <CoreTelephony/CTTelephonyNetworkInfo.h>

@implementation Util

+ (BOOL) isNetworkAvailable
{

        // 创建零地址，0.0.0.0的地址表示查询本机的网络连接状态
        struct sockaddr_in zeroAddress;
        bzero(&zeroAddress, sizeof(zeroAddress));
        zeroAddress.sin_len = sizeof(zeroAddress);
        zeroAddress.sin_family = AF_INET;
        
        /**
         *  SCNetworkReachabilityRef: 用来保存创建测试连接返回的引用
         *
         *  SCNetworkReachabilityCreateWithAddress: 根据传入的地址测试连接.
         *  第一个参数可以为NULL或kCFAllocatorDefault
         *  第二个参数为需要测试连接的IP地址,当为0.0.0.0时则可以查询本机的网络连接状态.
         *  同时返回一个引用必须在用完后释放.
         *  PS: SCNetworkReachabilityCreateWithName: 这个是根据传入的网址测试连接,
         *  第二个参数比如为"www.apple.com",其他和上一个一样.
         *
         *  SCNetworkReachabilityGetFlags: 这个函数用来获得测试连接的状态,
         *  第一个参数为之前建立的测试连接的引用,
         *  第二个参数用来保存获得的状态,
         *  如果能获得状态则返回TRUE，否则返回FALSE
         *
         */
        SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
        SCNetworkReachabilityFlags flags;
        
        BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
        CFRelease(defaultRouteReachability);
        
        if (!didRetrieveFlags)
        {
            printf("Error. Could not recover network reachability flagsn");
            return NO;
        }
        
        /**
         *  kSCNetworkReachabilityFlagsReachable: 能够连接网络
         *  kSCNetworkReachabilityFlagsConnectionRequired: 能够连接网络,但是首先得建立连接过程
         *  kSCNetworkReachabilityFlagsIsWWAN: 判断是否通过蜂窝网覆盖的连接,
         *  比如EDGE,GPRS或者目前的3G.主要是区别通过WiFi的连接.
         *
         */
        BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
        BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
        return (isReachable && !needsConnection) ? YES : NO;
}

//获取当前分辨率
+ (UIDeviceResolution) currentResolution {
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
        if ([[UIScreen mainScreen] respondsToSelector: @selector(scale)]) {
            CGSize result = [[UIScreen mainScreen] bounds].size;
            result = CGSizeMake(result.width * [UIScreen mainScreen].scale, result.height * [UIScreen mainScreen].scale);
            if (result.height <= 480.0f) {
                return UIDevice_iPhone;
            } else if ([self floatValue:result.height isEqualTo:960.0f]) {
                return UIDevice_iPhone4;
            } else if ([self floatValue:result.height isEqualTo:1136.0f]) {
                return UIDevice_iPhone5;
            } else if ([self floatValue:result.height isEqualTo:1334.0f]) {
                return UIDevice_iPhone6;
            } else if ([self floatValue:result.height isEqualTo:1980.0f]) {
                return UIDevice_iPhone6P;
            } else {
                return UIDevice_iPhone4;
            }
        } else
            return UIDevice_iPhone;
    } else
        return (([[UIScreen mainScreen] respondsToSelector: @selector(scale)]) ? UIDevice_iPad3 : UIDevice_iPadStandard);
}

+(BOOL)floatValue:(float)value1 isEqualTo:(float)value2 {
    if (abs(value1 - value2) < 0.000001) {
        return YES;
    } else {
        return NO;
    }
}

//当前是否运行在iPhone5端
+ (BOOL)isRunningOniPhone5{
    if ([self currentResolution] == UIDevice_iPhone5) {
        return YES;
    }
    return NO;
}

//函数描述 : 当前是否运行在iPhone端
+ (BOOL)isRunningOniPhone{
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone);
}

+ (BOOL)isiOS7Available
{
    return ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0);
}

+ (BOOL)iSiOS8Available
{
    return ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0);
}

/**
 * 字符串MD5加密
 *
 **/
+ (NSString *)MD5String:(NSString *)string whetherUpCase:(BOOL) toUpCase
{
    if (string == NULL) {
        return NULL;
    }
    const char *concat_str = [string UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(concat_str, strlen(concat_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    if (toUpCase) {
        return [hash uppercaseString];
    } else {
        return hash;
    }
}

/**
 * 弹出文字提示
 *
 **/
+ (void)makeToast:(NSString *)message
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    hud.margin = 10.f;
    hud.yOffset = 150.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1.0];
}

+(void)showSuccess
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = @"SUCCESS";
    hud.margin = 10.f;
    hud.alpha = 0.7;
    hud.yOffset = 150.f;
    hud.removeFromSuperViewOnHide = YES;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 37, 37)];
    imageView.image = [UIImage imageNamed:@"gou"];
    hud.customView = imageView;
    [hud hide:YES afterDelay:0.5];
}

////显示加载提示
+(MBProgressHUD*) showProgressHud
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].delegate window] animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.margin = 10.f;
    hud.yOffset = 0.0f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:10];//10秒之后自动消失
    return hud;
}

+(NSString*)currentTimeString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //用[NSDate date]可以获取系统当前时间
    return [dateFormatter stringFromDate:[NSDate date]];
}

+(NSString*)currentTimeWithoutSpace
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyyMMdd_HH_mm_ss"];
    //用[NSDate date]可以获取系统当前时间
    return [dateFormatter stringFromDate:[NSDate date]];
}

+(void)pushViewController:(Class)viewControllerClass navigationController:(UINavigationController*)navigationController hideTabBar:(BOOL)hideTabBar
{
    UIViewController *viewController = [[viewControllerClass alloc] initWithNibName:[viewControllerClass className] bundle:nil];
    viewController.hidesBottomBarWhenPushed = hideTabBar;
    [navigationController pushViewController:viewController animated:YES];
}

+(BOOL)checkPhoneNumInput:(NSString *)phone{
    
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9]|7[0-9])\\d{8}$";
    
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    BOOL res1 = [regextestmobile evaluateWithObject:phone];
    BOOL res2 = [regextestcm evaluateWithObject:phone];
    BOOL res3 = [regextestcu evaluateWithObject:phone];
    BOOL res4 = [regextestct evaluateWithObject:phone];
    
    if (res1 || res2 || res3 || res4 )
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
}

+ (NSString*)formatMoney:(float)money
{
    return [NSString stringWithFormat:@"￥%.2f",money];
}

//yyyy-MM-dd HH:mm:ss
+(NSString*)formatDate:(long)timeMills
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    return currentDateStr;
}

//格式化日期显示
+ (NSString*)formatDateByDay:(NSString*)formattedDateBySeconds
{
    return [formattedDateBySeconds substringToIndex:10];
}

+ (NSString*)today
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    return currentDateStr;
}

+ (NSString *) getTimeRelese:(NSString *)timenode
{
    NSDateFormatter *Formatter = [[NSDateFormatter alloc] init];
    [Formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *d=[Formatter dateFromString:timenode];
    NSString *timeString;
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ;
    
    NSDateComponents *de = [cal components:unitFlags fromDate:[NSDate date] toDate:d options:0 ];
    timeString = [NSString stringWithFormat:@"%d日%d时%d分%d秒结束", [de day], [de hour], [de minute], [de second]];
    
    return timeString;

}


+(void)iOS7StyleForUISegmentUnderiOS6:(UIColor*)selectedColor normalColor:(UIColor*)normalColor
{
    [[UISegmentedControl appearance] setBackgroundImage:[UIImage initImageWithUIColor:selectedColor andSize:CGSizeMake(1, 29)]
                                               forState:UIControlStateSelected
                                             barMetrics:UIBarMetricsDefault];
    
    [[UISegmentedControl appearance] setBackgroundImage:[UIImage initImageWithUIColor:normalColor andSize:CGSizeMake(1, 29)]
                                               forState:UIControlStateNormal
                                             barMetrics:UIBarMetricsDefault];
    
    [[UISegmentedControl appearance] setDividerImage:[UIImage initImageWithUIColor:selectedColor andSize:CGSizeMake(1, 29)]
                                 forLeftSegmentState:UIControlStateNormal
                                   rightSegmentState:UIControlStateSelected
                                          barMetrics:UIBarMetricsDefault];
    
    [[UISegmentedControl appearance] setTitleTextAttributes:@{
                                                              UITextAttributeTextColor: selectedColor,
                                                              UITextAttributeFont: [UIFont systemFontOfSize:14],
                                                              UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetMake(0, 0)] }
                                                   forState:UIControlStateNormal];
    
    [[UISegmentedControl appearance] setTitleTextAttributes:@{
                                                              UITextAttributeTextColor: normalColor,
                                                              UITextAttributeFont: [UIFont systemFontOfSize:14],
                                                              UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetMake(0, 0)]}
                                                   forState:UIControlStateSelected];
}

+(void)iOS7StyleForUIBarButtonItemUnderiOS6:(NSString*)backImageName
{
    //iOS6 nav 返回按钮扁平化
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:[[UIImage imageNamed:backImageName] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 18, 0, 0)]
                                                      forState:UIControlStateNormal
                                                    barMetrics:UIBarMetricsDefault];
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(5, 0)
                                                         forBarMetrics:UIBarMetricsDefault];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:
     @{ UITextAttributeFont: [UIFont systemFontOfSize:17],
        UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero]} forState:UIControlStateNormal];
    [[UIBarButtonItem appearance] setBackgroundImage:[UIImage new]
                                            forState:UIControlStateNormal
                                          barMetrics:UIBarMetricsDefault];
}

+(void)addBorderForView:(UIView*)view addLeft:(BOOL)left addRight:(BOOL)right addTop:(BOOL)top addBottom:(BOOL)bottom borderColor:(UIColor*)color
{
    if (top) {
        CALayer *topBorder = [CALayer layer];
        topBorder.frame = CGRectMake(0.0f, 0.0f, view.frame.size.width, 1.0f);
        topBorder.backgroundColor = [color CGColor];
        [view.layer addSublayer:topBorder];
    }
    
    if (bottom) {
        CALayer *bottomBorder = [CALayer layer];
        bottomBorder.frame = CGRectMake(0.0f, view.frame.size.height-1, view.frame.size.width, 1.0f);
        bottomBorder.backgroundColor = [color CGColor];
        [view.layer addSublayer:bottomBorder];
    }
    
    if (left) {
        CALayer *leftSideBorder = [CALayer layer];
        leftSideBorder.frame = CGRectMake(0.0f, 0.0f, 1.0f, view.frame.size.height);
        leftSideBorder.backgroundColor = [color CGColor];
        [view.layer addSublayer:leftSideBorder];
    }
    
    if (right) {
        CALayer *rightSideBorder = [CALayer layer];
        rightSideBorder.frame = CGRectMake(view.frame.size.width-1, 0.0f, 1.0f, view.frame.size.height);
        rightSideBorder.backgroundColor = [color CGColor];
        [view.layer addSublayer:rightSideBorder];
    }
}

//bool转字符串
+(NSString*)bool2String:(BOOL)boolValue
{
    return boolValue?@"1":@"0";
}

+(NSString*)int2String:(int)intValue
{
    return [NSString stringWithFormat:@"%d",intValue];
}

+(NSString*)float2String:(float)floatValue
{
    return [NSString stringWithFormat:@"%.2f",floatValue];
}

+(NSString*)combineString:(NSString*)string1 with:(NSString*)string2
{
    return [NSString stringWithFormat:@"%@%@",string1,string2];
}

+(CarrierType)carrier
{
    CTCarrier *carrier = [[[CTTelephonyNetworkInfo alloc] init] subscriberCellularProvider];
    
    NSString *MCC = [carrier mobileCountryCode]; //MobileCountryCode，460是中国
    NSString *MNC = [carrier mobileNetworkCode]; //MobileNetworkCode
    /**********************************
    00 China Mobile
    01 China Unicom
    02 China Mobile
    03 China Telecom
    05 China Telecom
    06 China Unicom
    07 China Mobile
    20 China Tietong
    ***********************************/ //这是国际标准，不要使用carriername来判断
    if ([MCC isEqualToString:@"460"]) {
        if ([MNC isEqualToString:@"00"] || [MNC isEqualToString:@"02"] || [MNC isEqualToString:@"07"]) {
            return Carrier_China_Mobile;
        } else if ([MNC isEqualToString:@"01"] || [MNC isEqualToString:@"06"]) {
            return Carrier_China_Unicom;
        } else if ([MNC isEqualToString:@"03"] || [MNC isEqualToString:@"05"]) {
            return Carrier_China_Telecom;
        } else {
            return Carrier_Unknow;
        }
    } else {
        return Carrier_Unknow;
    }
}

+(void)strikethroughLabel:(UILabel *)label withText:(NSString *)text
{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:text];
    [attrString addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlineStyleSingle | NSUnderlinePatternSolid) range:[text rangeOfString:text]];
    [label setAttributedText:attrString];
}

+(void)deleteBackTitle:(UINavigationItem *)navigationItem
{
    UIBarButtonItem *myBackBarButtonItem = [[UIBarButtonItem alloc]
                                            init];
    myBackBarButtonItem.title = @"";
    myBackBarButtonItem.image = [myBackBarButtonItem.image imageWithRenderingMode:UIImageRenderingModeAutomatic];
    navigationItem.backBarButtonItem = myBackBarButtonItem;
}

+(void)customButton:(UIButton*)button enabledColor:(NSInteger)enabledColor disabledColor:(NSInteger)disabledColor whetherFilletedCorner:(BOOL)hasFilletedCorner
{
    //从颜色构建图片
    UIImage *normalBackgroundImage = [UIImage initImageWithUIColor:[UIColor colorWithHex:enabledColor]];
    if (hasFilletedCorner) {
        //图片设置圆角
        normalBackgroundImage = [normalBackgroundImage createRoundedRectImage:normalBackgroundImage size:button.frame.size];
    }
    
    //设置背景
    [button setBackgroundImage:normalBackgroundImage forState:UIControlStateNormal];
    
    //从颜色构建图片
    UIImage *disabledBackgroundImage = [UIImage initImageWithUIColor:[UIColor colorWithHex:disabledColor]];
    if (hasFilletedCorner) {
        //图片设置圆角
        disabledBackgroundImage = [disabledBackgroundImage createRoundedRectImage:disabledBackgroundImage size:button.frame.size];
    }
    //设置背景
    [button setBackgroundImage:disabledBackgroundImage forState:UIControlStateDisabled];
}

+(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}
@end
