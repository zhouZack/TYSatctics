//
//  UIAlertView+Extension.h
//  ProjectBaseFrame
//
//  Created by Josh.Shron on 10/21/15.
//  Copyright © 2015 josh.shron. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^AlertViewBlock)(UIAlertView *alertView,NSInteger buttonIndex);

@interface UIAlertView (Extension) <UIAlertViewDelegate>

- (void)showAlertWithBlock:(AlertViewBlock)block;

@end
