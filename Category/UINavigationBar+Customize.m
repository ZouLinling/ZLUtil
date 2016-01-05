//
//  UINavigationBar+Customize.m
//  B2C
//
//  Created by Zou on 3/6/15.
//  Copyright (c) 2015 Zou. All rights reserved.
//

#import "UINavigationBar+Customize.h"
#import "UIImage+UIImageFromUIColor.h"
#import "UIColor+UIColorFromHex.h"
#import "Constant.h"

@implementation UINavigationBar (Customize)

//设置背景颜色
-(void)setBackgroundColor:(NSInteger)color
{
    [self setBackgroundImage:[UIImage initImageWithUIColor:[UIColor colorWithHex:color]] forBarMetrics:UIBarMetricsDefault];
}

//设置默认背景颜色
-(void)setDefaultBackgroundColor
{
    [self setBackgroundColor:TAB_BG];
}

/**
 *  设置nav bar上按钮的颜色，如返回按钮
 *
 *  @param color 16进制颜色，例如0xAABBCC
 */
-(void)setBarButtonItemColor:(NSInteger)color
{
    [self setTintColor:[UIColor colorWithHex:color]];
}

/**
 *  设置nav bar上标题的颜色
 *
 *  @param color 16进制颜色，例如0xAABBCC
 */
-(void)setTitleColor:(NSInteger)color
{
    [self setTitleTextAttributes:@{ NSForegroundColorAttributeName: [UIColor colorWithHex:color]}];
}
@end
