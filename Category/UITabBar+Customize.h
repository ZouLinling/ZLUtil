//
//  UITabBar+Customize.h
//  B2C
//
//  Created by Zou on 3/5/15.
//  Copyright (c) 2015 Zou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (Customize)

/**
 *  设置顶部tab的名称和图片，图片必须为30*30（iPhone4）和 60*60（retina屏幕）
 *
 *  @param title                tabBarItem的标题
 *  @param imageName            tabBarItem的图片名称
 *  @param parent               对应的viewcontroller
 *  @param tintColor            tabBarItem的颜色
 *  @param selectedTintColor    tabBarItem选中的时的颜色
 *  @param backgroundImageColor tabBarItem背景图片的颜色
 *  @param normalTextColor      普通状态下的tabBarItem文字颜色
 *  @param selectedTextColor    选中状态下的tabBarItem文字颜色
 */
-(void)setTabBarItemTitle:(NSString*)title image:(NSString*)imageName parentViewController:(UIViewController*) parent tintColor:(NSInteger)tintColor selectedTintColor:(NSInteger)selectedTintColor backgroundImageColor:(NSInteger)backgroundImageColor normalTextColor:(NSInteger)normalTextColor selectedTextColor:(NSInteger)selectedTextColor;

@end
