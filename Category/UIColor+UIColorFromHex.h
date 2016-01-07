//
//  UIColor+UIColorFromHex.h
//  BaseProject
//  使用十六进制值来标识颜色
//  Created by Zou on 5/23/14.
//  Copyright (c) 2014 Zou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (UIColorFromHex)
/**
 *  以6位十六进制的形式表示颜色，并且可以设置该颜色的透明度
 *
 *  @param hexValue   6位十六进制数：0x000000 ~ 0xffffff
 *  @param alphaValue 透明度
 *
 *  @return
 */
+ (UIColor*)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;

/**
 *  以6位十六进制的形式表示颜色
 *
 *  @param hexValue 6位十六进制数：0x000000 ~ 0xffffff
 *
 *  @return 
 */
+ (UIColor*)colorWithHex:(NSInteger)hexValue;

/**
 *  颜色为白色时的透明度设置
 *
 *  @param alphaValue 透明度
 *
 *  @return
 */
+ (UIColor*)whiteColorWithAlpha:(CGFloat)alphaValue;

/**
 *  颜色为黑色时的透明度设置
 *
 *  @param alphaValue 透明度
 *
 *  @return 
 */
+ (UIColor*)blackColorWithAlpha:(CGFloat)alphaValue;
@end
