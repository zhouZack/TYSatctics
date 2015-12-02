//
//  UIImage+Extension.h
//  ProjectBaseFrame
//
//  Created by Josh.Shron on 9/2/15.
//  Copyright (c) 2015 josh.shron. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

+(UIImage *)scaleToSize:(UIImage *)image size:(CGSize)size;
- (UIImage *)translateToSquare;

@end
