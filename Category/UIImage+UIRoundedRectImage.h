//
//  UIImage+UIRoundedRectImage.h
//  B2C
//
//  Created by Zou on 3/6/15.
//  Copyright (c) 2015 Zou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (UIRoundedRectImage)
/**
 *  将矩形图片设置成圆角图片，尺寸可以自定义
 *
 *  @param image 待设置图片
 *  @param size  自定义尺寸
 *
 *  @return 
 */
- (UIImage*) createRoundedRectImage:(UIImage*)image size:(CGSize)size;

@end
