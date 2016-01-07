//
//  UIImage+ImageFromUIColor.h
//  BaseProject
//
//  Created by Zou on 6/30/14.
//  Copyright (c) 2014 Zou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (UIImageFromUIColor)

/**
 *  以颜色来设置图片
 *
 *  @param color 设置颜色
 *
 *  @return
 */
+ (UIImage *)initImageWithUIColor:(UIColor *)color;

/**
 *  以颜色来设置图片，并设置图片尺寸
 *
 *  @param color 设置颜色
 *  @param size  图片尺寸
 *
 *  @return
 */
+ (UIImage *)initImageWithUIColor:(UIColor *)color andSize:(CGSize)size;
@end
