//
//  UIImage+UpdateFrame.h
//  BaseProject
//
//  Created by Zou on 6/30/14.
//  Copyright (c) 2014 Zou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (UpdateFrame)
//直接设置某一个值
-(void) setHeight:(CGFloat)height;
-(void) setWidth:(CGFloat)width;
-(void) setXValue:(CGFloat)x;
-(void) setYValue:(CGFloat)y;

//根据偏移量来设置，如上移20
-(void) updateHeight:(CGFloat)heightOffset;
-(void) updateWidth:(CGFloat)widthOffset;
-(void) updateXValue:(CGFloat)xOffset;
-(void) updateYValue:(CGFloat)yOffset;
@end
