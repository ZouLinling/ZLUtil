//
//  UIImage+UpdateFrame.h
//  BaseProject
//
//  Created by Zou on 6/30/14.
//  Copyright (c) 2014 Zou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (UpdateFrame)

/**
 *  直接设置height
 *
 *  @param height
 */
-(void) setHeight:(CGFloat)height;

/**
 *  直接设置width
 *
 *  @param width
 */
-(void) setWidth:(CGFloat)width;

/**
 *  直接设置x
 *
 *  @param x
 */
-(void) setXValue:(CGFloat)x;

/**
 *  直接设置y
 *
 *  @param y
 */
-(void) setYValue:(CGFloat)y;

/**
 *  根据偏移量来设置height，如上移20
 *
 *  @param heightOffset
 */
-(void) updateHeight:(CGFloat)heightOffset;

/**
 *  根据偏移量来设置width，如上移20
 *
 *  @param widthOffset
 */
-(void) updateWidth:(CGFloat)widthOffset;

/**
 *  根据偏移量来设置x，如上移20
 *
 *  @param xOffset
 */
-(void) updateXValue:(CGFloat)xOffset;

/**
 *  根据偏移量来设置y，如上移20
 *
 *  @param yOffset 
 */
-(void) updateYValue:(CGFloat)yOffset;
@end
