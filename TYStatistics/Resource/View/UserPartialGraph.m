//
//  UserDevelopTable.m
//  TYStatistics
//
//  Created by Zc_zhou on 15/11/18.
//  Copyright © 2015年 Josh.Shron. All rights reserved.
//

#import "UserPartialGraph.h"


@interface UserPartialGraph ()
@property (nonatomic ,strong)UILabel *Vlabel;
@property (nonatomic ,strong)UILabel *Hlabel;

@property (nonatomic ,strong)NSMutableArray *stripLabeArray;//保存条状Label的数组
@property (nonatomic ,strong)NSMutableArray *textLabelArray;//保存6个省份的名字的数组
@property (nonatomic ,strong)NSMutableArray *numberLabelArray;//保存用户数字型数据的数组
@property (nonatomic ,strong)NSMutableArray *countLabelArray;//保存条状条上面的数据

@end

@implementation UserPartialGraph
/**
 表格示意图
 */
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self reloadView];
    }
    return self;
}
-(void)setTage:(NSInteger)tage
{
    _tage = tage;
    if (tage >=6) {
        tage =6;
    }
    [self createDate:tage+1];
}
-(void)setCountArray:(NSArray *)countArray{
    _countArray = countArray;
    int k = _countLabelArray.count>countArray.count?(int)countArray.count:(int)_countLabelArray.count;

    for (int i =0 ; i<k; i++) {
        UILabel *label = _countLabelArray[i];
        label.text = countArray[i];
        [label sizeToFit];
        UILabel *stripL = _stripLabeArray[i];
        label.centerX = stripL.centerX;
    }
    
}

-(void)setStripArray:(NSArray *)stripArray{
    _stripArray = stripArray;
    int k= _stripLabeArray.count>stripArray.count ?(int)stripArray.count:(int)_stripLabeArray.count;

    for (int i=0; i<k; i++) {
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
    int k= _textLabelArray.count>textArray.count ?(int)textArray.count:(int)_textLabelArray.count;

    for (int i =0; i<k; i++) {
        UILabel *label = _textLabelArray[i];
        label.text = textArray[i];
        [label sizeToFit];
    }
}
-(void)setNumberArray:(NSArray *)numberArray{
    _numberArray = numberArray;
    for (int i= 0; i<_numberLabelArray.count; i++) {
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
    
    CGFloat width = self.width;
    CGFloat height = self.height;
    
    _Hlabel = [[UILabel alloc] initWithFrame:CGRectMake(40, height*4/5, width-40, 3)];
    _Hlabel.backgroundColor = [UIColor blackColor];
    [self addSubview:_Hlabel];
    UILabel *zeroLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _Hlabel.bottom-10, 10, 10)];
    zeroLabel.font = [UIFont systemFontOfSize:14];
    zeroLabel.text = @"0";
    [self addSubview:zeroLabel];
    
    _Vlabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 3, height*4/5)];
    _Vlabel.backgroundColor = [UIColor blackColor];
    [self addSubview:_Vlabel];
    
    //表格垂直的每列的宽度
    CGFloat Vertical = _Vlabel.height/5.66;
    for (int i = 0; i<5; i++) {
        //表格每一列的横线
        UILabel *label = [[UILabel alloc] init];
        if (i==0) {
            label.top = Vertical*0.66;
        }else{
            label.top = Vertical*0.66 + i*Vertical;
        }
        label.width = width - _Vlabel.right -15;
        label.left = _Vlabel.right;
        label.height = 1;
        label.backgroundColor = [UIColor blackColor];
        [self addSubview:label];
        
        UILabel *numberLabel = [[UILabel alloc] init];
        numberLabel.width =35;
        numberLabel.height = 15;
        numberLabel.left = 3;
        numberLabel.centerY = label.centerY-10;
        numberLabel.font = [UIFont systemFontOfSize:13];
        numberLabel.text = @"208万";
        [numberLabel sizeToFit];
        [self addSubview:numberLabel];
        [_numberLabelArray addObject:numberLabel];
    }

}
//创建数据
- (void)createDate:(NSInteger)num{
    NSArray *colorArray =ColorArr;
    
    //表格水平的每条间隔
    CGFloat hotizontal = (_Hlabel.width-25)/6;
    for (int i = 1; i<num; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.top = _Hlabel.bottom;
        label.width = 3;
        label.height = 3;
        label.backgroundColor = [UIColor blackColor];
        label.right = _Vlabel.right + i*hotizontal;
        [self addSubview:label];
        
        UILabel * stripLabel= [[UILabel alloc] init];
        stripLabel.width = hotizontal*3/5;
        stripLabel.height = 0;
        stripLabel.centerX = label.centerX;
        stripLabel.bottom = _Hlabel.top;
        stripLabel.backgroundColor = colorArray[(i-1)%5];
        [self addSubview:stripLabel];
        [_stripLabeArray addObject:stripLabel];
        
        UILabel *countLabel = [[UILabel alloc] init];
        countLabel.text = @"";
        countLabel.font = [UIFont systemFontOfSize:13];
        [countLabel sizeToFit];
        countLabel.centerX = label.centerX;
        countLabel.bottom = stripLabel.top-3;
        [self addSubview:countLabel];
        [_countLabelArray addObject:countLabel];
        
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.width = stripLabel.width;
        textLabel.height = 15;
        textLabel.centerX = label.centerX;
        textLabel.top = label.bottom+5;
        textLabel.transform = CGAffineTransformMakeRotation(-0.4);
        textLabel.font = [UIFont systemFontOfSize:14];
        
        [self addSubview:textLabel];
        [_textLabelArray addObject:textLabel];
    }

}

@end
