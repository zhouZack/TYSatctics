//
//  ProgressHUD.m
//  TYStatistics
//
//  Created by Zc_zhou on 15/11/25.
//  Copyright © 2015年 Josh.Shron. All rights reserved.
//

#import "TYSProgressHUD.h"
@interface TYSProgressHUD()
@property (nonatomic ,strong)UIImageView *imageView;
@property (nonatomic ,strong)UILabel *Infolabel;
@property (nonatomic ,strong)UILabel *lastLabel;
@end

@implementation TYSProgressHUD


+(TYSProgressHUD*)shareView{
    static dispatch_once_t once;
    static TYSProgressHUD*shareView;
    
    dispatch_once(&once,^{
        shareView = [[TYSProgressHUD alloc] initWithFrame:CGRectMake(0, 64, UIScreenWidth, UIScreenHeight-64)];
    });
    
    return shareView;
}

+(void)show{
    [[self shareView] displayImage];
    
}
+(void)dismissSuccessWith:(NSString*)str{
    [[self shareView] dismissSuccess:str];
}
+(void)dismessFailWith:(NSString *)str{
    [[self shareView] dismissImageWith:str];
}
- (void)displayImage{
    self.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.7];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 80,70)];
    _imageView.centerX = UIScreenWidth/2;
    _imageView.centerY = UIScreenHeight/2;
    
    [self addSubview:_imageView];
    
    _Infolabel = [[UILabel alloc]initWithFrame:CGRectMake(_imageView.left, _imageView.bottom, _imageView.width, 20)];
    
    _lastLabel = [[UILabel alloc]initWithFrame:CGRectMake(_imageView.left, self.height-240, _imageView.width, 20)];
    [self addSubview:_Infolabel];
    [self addSubview:_lastLabel];

    //设置动画帧
    _imageView.animationImages=[NSArray arrayWithObjects: [UIImage imageNamed:@"loading1"],
                                [UIImage imageNamed:@"loading2"],
                                [UIImage imageNamed:@"loading3"],
                                [UIImage imageNamed:@"loading4"],
                                [UIImage imageNamed:@"loading5"],
                                [UIImage imageNamed:@"loading6"],
                                [UIImage imageNamed:@"loading7"],
                                [UIImage imageNamed:@"loading8"],
                                [UIImage imageNamed:@"loading9"],
                                [UIImage imageNamed:@"loading10"],
                                [UIImage imageNamed:@"loading11"],
                                [UIImage imageNamed:@"loading12"],
                                [UIImage imageNamed:@"loading13"],
                                nil ];
    

    _Infolabel.text = @"努力加载数据中...";
    [_Infolabel sizeToFit];
    _Infolabel.centerX = _imageView.centerX;
    _Infolabel.backgroundColor = [UIColor clearColor];
    _Infolabel.textAlignment = NSTextAlignmentCenter;
    _Infolabel.textColor = [UIColor whiteColor];
    _Infolabel.font = [UIFont boldSystemFontOfSize:14];
    

    _lastLabel.textAlignment = NSTextAlignmentCenter;
    _lastLabel.textColor = [UIColor whiteColor];
    _lastLabel.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.7];
    _lastLabel.font = [UIFont boldSystemFontOfSize:14];
    _lastLabel.alpha = 0;

    //设置动画总时间
    _imageView.animationDuration=1.0;
    //设置重复次数,0表示不重复
    _imageView.animationRepeatCount=0;
    //开始动画
    [_imageView startAnimating];
    
    
}
- (void)dismissSuccess:(NSString*)string{
    _Infolabel.text = @"加载成功";
    [UIView animateWithDuration:0.5 animations:^{
        _Infolabel.alpha = 0;
        _imageView.alpha = 0;
    } completion:^(BOOL finished) {
        _lastLabel.alpha = 0;
        [_imageView removeFromSuperview];
        [_Infolabel removeFromSuperview];
        [_lastLabel removeFromSuperview];
        [self removeFromSuperview];
        
    }];
}
-(void)dismissImageWith:(NSString*)string{
    self.backgroundColor = [UIColor clearColor];
    _Infolabel.alpha = 0;
    _imageView.alpha = 0;
    _lastLabel.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.7];
    _lastLabel.text = string;
    [_lastLabel sizeToFit];
    _lastLabel.centerX = UIScreenWidth/2;
    [UIView animateWithDuration:1.5 animations:^{
        _lastLabel.alpha = 1;

    } completion:^(BOOL finished) {
        _lastLabel.alpha = 0;
        [_imageView removeFromSuperview];
        [_Infolabel removeFromSuperview];
        [_lastLabel removeFromSuperview];
        [self removeFromSuperview];
        
    }];
}

@end
