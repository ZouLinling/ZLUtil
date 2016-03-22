//
//  UITabBar+Customize.h
//  B2C
//
//  Created by Zou on 3/5/15.
//  Copyright (c) 2015 Zou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (Customize)

-(void)setTabBarItemTitle:(NSString*)title image:(NSString*)imageName parentViewController:(UIViewController*) parent tintColor:(NSInteger)tintColor selectedTintColor:(NSInteger)selectedTintColor backgroundImageColor:(NSInteger)backgroundImageColor normalTextColor:(NSInteger)normalTextColor selectedTextColor:(NSInteger)selectedTextColor;

@end
