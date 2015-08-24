//
//  UIImage+CircleImage.m
//  B2C
//
//  Created by Zou on 5/20/15.
//  Copyright (c) 2015 Zou. All rights reserved.
//

#import "UIImage+CircleImage.h"

@implementation UIImage (CircleImage)

-(UIImage*)circleImageWithInset:(CGFloat)inset {
    UIGraphicsBeginImageContext(self.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2);
    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
    CGRect rect = CGRectMake(inset, inset, self.size.width - inset * 2.0f, self.size.height - inset * 2.0f);
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    
    [self drawInRect:rect];
    CGContextAddEllipseInRect(context, rect);
    CGContextStrokePath(context);
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}

@end
