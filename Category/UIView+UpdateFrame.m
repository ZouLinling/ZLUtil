//
//  UIImage+UpdateFrame.m
//  BaseProject
//
//  Created by Zou on 6/30/14.
//  Copyright (c) 2014 Zou. All rights reserved.
//

#import "UIView+UpdateFrame.h"

@implementation UIView (UpdateFrame)
//
-(void) setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    [self setFrame:frame];
}

//
-(void) setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    [self setFrame:frame];
}

//
-(void) setXValue:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    [self setFrame:frame];
}

//
-(void) setYValue:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    [self setFrame:frame];
}

//
-(void) updateHeight:(CGFloat)heightOffset
{
    CGRect frame = self.frame;
    frame.size.height += heightOffset;
    [self setFrame:frame];
}

//
-(void) updateWidth:(CGFloat)widthOffset
{
    CGRect frame = self.frame;
    frame.size.width += widthOffset;
    [self setFrame:frame];
}

//
-(void) updateXValue:(CGFloat)xOffset
{
    CGRect frame = self.frame;
    frame.origin.x += xOffset;
    [self setFrame:frame];
}

//
-(void) updateYValue:(CGFloat)yOffset
{
    CGRect frame = self.frame;
    frame.origin.y += yOffset;
    [self setFrame:frame];
}

@end
