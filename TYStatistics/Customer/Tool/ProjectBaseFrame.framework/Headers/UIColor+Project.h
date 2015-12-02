//
//  UIColor+Project.h
//  ProjectBaseFrame
//
//  Created by git on 5/12/15.
//  Copyright (c) 2015 josh.shron. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Project)

+ (UIColor *)colorWithHex:(NSString*)hexColor;
+ (UIColor *)colorwithRGB:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;
+ (UIColor *)colorwithRGB:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

@end
