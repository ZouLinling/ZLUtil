//
//  UITabBar+Customize.m
//  B2C
//
//  Created by Zou on 3/5/15.
//  Copyright (c) 2015 Zou. All rights reserved.
//

#import "UITabBar+Customize.h"
#import "UIImage+UIImageFromUIColor.h"
#import "UIColor+UIColorFromHex.h"

@implementation UITabBar (Customize)

//设置顶部tab的名称和图片，图片必须为30*30（iPhone4）和 60*60（retina屏幕）
-(void)setTabBarItemTitle:(NSString*)title image:(NSString*)imageName parentViewController:(UIViewController*) parent;
{
    UITabBarItem *tabBarItem = [parent tabBarItem];
    [tabBarItem setTitle:title];
    //注意不要使用渲染，使用图片的原来的颜色
    UIImage *image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [tabBarItem setImage:image];
    [tabBarItem setSelectedImage:[UIImage imageNamed:imageName]];
    [self setTintColor:[UIColor colorWithHex:0xFF7119]];
    //因为没有设置selectedimage，所以这里需要重新渲染
    [self setSelectedImageTintColor:[UIColor colorWithHex:0xFF7119]];
    //背景色
    //    [[UITabBar appearance] setBarTintColor:[UIColor colorWithHex:0x5B1712]];
    //background和bartintcolor有区别
    [[UITabBar appearance] setBackgroundImage:[UIImage initImageWithUIColor:[UIColor colorWithHex:0x5B1712]]];
    //文字颜色
    [tabBarItem setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHex:0xAB7372],                                                                                                              UITextAttributeTextColor, nil]
                              forState:UIControlStateNormal];
    //选中的文字的颜色
    [tabBarItem setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor colorWithHex:0xFF7119],
      UITextAttributeTextColor, nil] forState:UIControlStateSelected];
}

@end
