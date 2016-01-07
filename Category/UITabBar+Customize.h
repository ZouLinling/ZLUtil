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
 *  @param title     tab的名称
 *  @param imageName tab的图片
 *  @param parent    对应的ViewController
 */
-(void)setTabBarItemTitle:(NSString*)title image:(NSString*)imageName parentViewController:(UIViewController*) parent;

@end
