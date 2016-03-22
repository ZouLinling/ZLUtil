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
-(void)setTabBarItemTitle:(NSString*)title image:(NSString*)imageName parentViewController:(UIViewController*) parent tintColor:(NSInteger)tintColor selectedTintColor:(NSInteger)selectedTintColor backgroundImageColor:(NSInteger)backgroundImageColor normalTextColor:(NSInteger)normalTextColor selectedTextColor:(NSInteger)selectedTextColor;
{
    UITabBarItem *tabBarItem = [parent tabBarItem];
    [tabBarItem setTitle:title];
    //注意不要使用渲染，使用图片的原来的颜色
    UIImage *image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [tabBarItem setImage:image];
    [tabBarItem setSelectedImage:[UIImage imageNamed:imageName]];
    [self setTintColor:[UIColor colorWithHex:tintColor]];
    //因为没有设置selectedimage，所以这里需要重新渲染
    [self setSelectedImageTintColor:[UIColor colorWithHex:selectedTintColor]];
    //背景色
    //    [[UITabBar appearance] setBarTintColor:[UIColor colorWithHex:0x5B1712]];
    //background和bartintcolor有区别
    [[UITabBar appearance] setBackgroundImage:[UIImage initImageWithUIColor:[UIColor colorWithHex:backgroundImageColor]]];
    //文字颜色
    [tabBarItem setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHex:normalTextColor],                                                                                                              UITextAttributeTextColor, nil]
                              forState:UIControlStateNormal];
    //选中的文字的颜色
    [tabBarItem setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor colorWithHex:selectedTextColor],
      UITextAttributeTextColor, nil] forState:UIControlStateSelected];
}

@end
