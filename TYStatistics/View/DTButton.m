//
//  DTButton.m
//  TYStatistics
//
//  Created by Zc_zhou on 15/11/16.
//  Copyright © 2015年 Josh.Shron. All rights reserved.
//

#import "DTButton.h"

@implementation DTButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundImage:[[UIImage imageNamed:@"item_bg"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font  = [UIFont systemFontOfSize:18];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.width = self.width*2/3;
    self.imageView.height =self.width*2/3;
    self.imageView.left = self.frame.size.width/6;
    self.imageView.top = self.height/7;
    self.titleLabel.top = self.imageView.bottom;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height*4/5 - self.imageView.height;
    self.titleLabel.centerX = self.width/2;
    
    
}
- (void)setTitle:(NSString *)title forState:(UIControlState)state{
    [super setTitle:title forState:state];
    
}
- (void)setImage:(UIImage *)image forState:(UIControlState)state{
    [super setImage:image forState:state];
    
}

@end
