//
//  UIAlertView+Block.h
//  B2C
//
//  Created by Zou on 4/10/15.
//  Copyright (c) 2015 Zou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (Block)

typedef void(^CompleteBlock) (NSInteger buttonIndex);

- (void)showAlertViewWithCompleteBlock:(CompleteBlock)block;

@end
