//
//  UserTotalGraph.m
//  TYStatistics
//
//  Created by Zc_zhou on 15/11/21.
//  Copyright © 2015年 Josh.Shron. All rights reserved.
//

#import "UserTotalGraph.h"


@interface UserTotalGraph()

@property (nonatomic ,strong) UIScrollView *scrollView;
@property (nonatomic ,strong)UILabel *Vlabel;
@property (nonatomic ,strong)UILabel *Hlabel;

@property (nonatomic ,strong)NSMutableArray *stripLabeArray;//保存条状Label的数组
@property (nonatomic ,strong)NSMutableArray *textLabelArray;//保存6个省份的名字的数组
@property (nonatomic ,strong)NSMutableArray *numberLabelArray;//保存用户数字型数据的数组
@property (nonatomic ,strong)NSMutableArray *countLabelArray;//保存条状条上面的数据

@end

@implementation UserTotalGraph

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self reloadView];
        
    }
    return self;
}
-(void)setTage:(NSInteger)tage
{
    _tage = tage;

    [self createDate:tage+1];
    
}
-(void)setCountArray:(NSArray *)countArray{
    _countArray = countArray;
    for (int i =0 ; i<countArray.count; i++) {
        UILabel *label = _countLabelArray[i];
        label.text = countArray[i];
        [label sizeToFit];
        UILabel *stripL = _stripLabeArray[i];
        label.centerX = stripL.centerX;
    }
    
}
-(void)setStripArray:(NSArray *)stripArray{
    _stripArray = stripArray;
    for (int i=0; i<stripArray.count; i++) {
        CGFloat heigh = [stripArray[i] floatValue];
        UILabel *label = _stripLabeArray[i];
        label.height = heigh*_Vlabel.height*5/6;
        label.bottom = _Hlabel.top;
        UILabel *count = _countLabelArray[i];
        count.bottom = label.top-3;
    }
}
-(void)setTextArray:(NSArray *)textArray{
    _textArray = textArray;
    for (int i =0; i<textArray.count; i++) {
        UILabel *label = _textLabelArray[i];
        label.text = textArray[i];
        [label sizeToFit];
    }
}
-(void)setNumberArray:(NSArray *)numberArray{
    _numberArray = numberArray;
    for (int i= 0; i<numberArray.count; i++) {
        UILabel *label = _numberLabelArray[i];
        label.text = numberArray[i];
        [label sizeToFit];
    }
}

- (void)reloadView{
    _stripLabeArray = [[NSMutableArray alloc] init];
    _textLabelArray = [[NSMutableArray alloc] init];
    _numberLabelArray = [[NSMutableArray alloc] init];
    _countLabelArray = [[NSMutableArray alloc] init];
    _scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
    _scrollView.contentSize = CGSizeMake(2*UIScreenHeight, 0);
    _scrollView.bounces = NO;
    _scrollView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_scrollView];
    
    UIButton*btn = [ToolUtil buttonWithFrame:CGRectMake(22, self.height-40, 40, 20) target:self action:@selector(click) color:[UIColor blackColor] title:@"返回"];
    [self addSubview:btn];
    

    
    _Vlabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 30, 3, self.height-90)];
    _Vlabel.backgroundColor = [UIColor blackColor];
    [_scrollView addSubview:_Vlabel];
    
    UILabel *zeroLabel = [ToolUtil labelwithFrame:CGRectMake(25, _Vlabel.bottom-10, 35, 15) font:14 text:@"0"];
    [_scrollView addSubview:zeroLabel];
    
    _Hlabel = [[UILabel alloc] initWithFrame:CGRectMake(70, _Vlabel.bottom, 2*self.width-100, 3)];
    _Hlabel.backgroundColor = [UIColor blackColor];
    [_scrollView addSubview:_Hlabel];
    


}
- (void)createDate:(NSInteger)num
{
    //表格水平的每条间隔
    CGFloat hotizontal = (self.width-85)/6;
    NSArray *colorArray =ColorArr;
    
    _scrollView.contentSize = CGSizeMake(83+num*hotizontal, 0);

    _Hlabel.width = num*hotizontal;
    
    //表格垂直的每列的宽度
    CGFloat Vertical = _Vlabel.height/5.66;
    for (int i = 0; i<5; i++) {
        //表格每一列的横线
        UILabel *label = [[UILabel alloc] init];
        if (i==0) {
            label.top = 30+Vertical*0.66;
        }else{
            label.top = 30+Vertical*0.66 + i*Vertical;
        }
        label.width = _Hlabel.width -45;
        label.left = _Vlabel.right;
        label.height = 1;
        label.backgroundColor = [UIColor blackColor];
        [_scrollView addSubview:label];
        
        UILabel *numberLabel = [[UILabel alloc] init];
        numberLabel.width =35;
        numberLabel.height = 15;
        numberLabel.left = 25;
        numberLabel.centerY = label.centerY-10;
        numberLabel.font = [UIFont systemFontOfSize:14];
        
        [_scrollView addSubview:numberLabel];
        [_numberLabelArray addObject:numberLabel];
        
    }
    
    for (int i = 1; i<num; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.top = _Hlabel.bottom;
        label.width = 3;
        label.height = 3;
        label.backgroundColor = [UIColor blackColor];
        label.right = _Vlabel.right + i*hotizontal;
        [_scrollView addSubview:label];
        
        UILabel * stripLabel= [[UILabel alloc] init];
        stripLabel.width = hotizontal*3/5;
        stripLabel.height = 10;
        stripLabel.centerX = label.centerX;
        stripLabel.bottom = _Hlabel.top;
        stripLabel.backgroundColor = colorArray[(i-1)%5];
        [_scrollView addSubview:stripLabel];
        [_stripLabeArray addObject:stripLabel];
        
        UILabel *countLabel = [[UILabel alloc] init];
        countLabel.font = [UIFont systemFontOfSize:13];
        countLabel.text = @"0";
        [countLabel sizeToFit];
        countLabel.centerX = label.centerX;
        countLabel.bottom = stripLabel.top-3;
        [_scrollView addSubview:countLabel];
        [_countLabelArray addObject:countLabel];
        
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.width = stripLabel.width;
        textLabel.height = 15;
        textLabel.centerX = label.centerX;
        textLabel.top = label.bottom+5;
        textLabel.transform = CGAffineTransformMakeRotation(-0.4);
        textLabel.font = [UIFont systemFontOfSize:14];
        
        [_scrollView addSubview:textLabel];
        [_textLabelArray addObject:textLabel];
        
    }
    
 

}

- (void)click{
    if (self.block) {
        NSString*str =nil;
        self.block(str);
    
    }
}
@end
