//
//  UIImage+ImageFromUIColor.h
//  BaseProject
//
//  Created by Zou on 6/30/14.
//  Copyright (c) 2014 Zou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (UIImageFromUIColor)
+ (UIImage *)initImageWithUIColor:(UIColor *)color;
+ (UIImage *)initImageWithUIColor:(UIColor *)color andSize:(CGSize)size;
@end
