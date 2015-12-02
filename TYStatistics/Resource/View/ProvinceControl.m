//
//  ProvinceControl.m
//  TYStatistics
//
//  Created by Zc_zhou on 15/11/17.
//  Copyright © 2015年 Josh.Shron. All rights reserved.
//

#import "ProvinceControl.h"
@interface ProvinceControl ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,strong)UITableView*tabelView;
@property (nonatomic ,strong)NSArray*dateArray;
@end


@implementation ProvinceControl

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createView];
    }
    return self;
}
- (void)createView
{
    _dateArray = [[NSArray alloc] init];
    _dateArray = @[@"北京",@"天津",@"上海",@"重庆",@"河北",@"山西",@"辽宁",@"吉林",@"黑龙江",@"江苏",@"浙江",@"安徽",@"福建",@"江西",@"山东",@"河南",@"湖北",@"湖南",@"广东",@"海南",@"四川",@"贵州",@"云南",@"陕西",@"甘肃",@"青海",@"内蒙古",@"广西",@"西藏",@"宁夏",@"新疆"];
    
    _tabelView = [[UITableView alloc] initWithFrame:CGRectMake(3, 20, self.width-6, self.height-40) style:UITableViewStylePlain];
    _tabelView.delegate = self;
    _tabelView.dataSource = self;
    _tabelView.showsVerticalScrollIndicator = NO;
    _tabelView.backgroundColor = [UIColor clearColor];
    _tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;

    UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(3, 3, self.width-6, self.height-6)];
    image.image = [UIImage imageNamed:@"spinner_bg"];

    [self addSubview:image];
    
    [self addSubview:_tabelView];

    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dateArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*cellId = @"cellId";
    UITableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell ==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = _dateArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.cellBlcok) {
        
        self.cellBlcok([tableView cellForRowAtIndexPath:indexPath].textLabel.text);
        
    }
}
@end
