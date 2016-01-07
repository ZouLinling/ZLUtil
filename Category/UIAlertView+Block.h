//
//  UIAlertView+Block.h
//  B2C
//
//  Created by Zou on 4/10/15.
//  Copyright (c) 2015 Zou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (Block)
/**
 *  定义一个点击弹出按钮后的回调block
 *
 *  @param buttonIndex 点击按钮的index
 */
typedef void(^CompleteBlock) (NSInteger buttonIndex);
/**
 *  用Block的方式回调，这时候会默认用self作为Delegate
 *
 *  @param block CompleteBlock
 */
- (void)showAlertViewWithCompleteBlock:(CompleteBlock)block;

@end
