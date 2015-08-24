//
//  UIImage+CircleImage.h
//  B2C
//
//  Created by Zou on 5/20/15.
//  Copyright (c) 2015 Zou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CircleImage)

/**
 * 制造圆形图片
 *  @para inset 会根据原始图的最大半径扣除inset值来画园
 */
-(UIImage*) circleImageWithInset:(CGFloat)inset;

@end
