//
//  UINavigationBar+Customize.h
//  B2C
//
//  Created by Zou on 3/6/15.
//  Copyright (c) 2015 Zou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (Customize)

/**
 *  设置背景颜色(16进制颜色)
 *
 *  @param color 16进制颜色，例如0xAABBCC
 */
-(void)setBackgroundColor:(NSInteger)color;

/**
 *  设置默认背景颜色
 */
-(void)setDefaultBackgroundColor;

/**
 *  设置nav bar上按钮的颜色，如返回按钮
 *
 *  @param color 16进制颜色，例如0xAABBCC
 */
-(void)setBarButtonItemColor:(NSInteger)color;

/**
 *  设置nav bar上标题的颜色
 *
 *  @param color 16进制颜色，例如0xAABBCC
 */
-(void)setTitleColor:(NSInteger)color;

@end
