//
//  ResponseSpeedController.m
//  TYStatistics
//
//  Created by Zc_zhou on 15/11/23.
//  Copyright © 2015年 Josh.Shron. All rights reserved.
//

#import "ResponseSpeedController.h"
#import "ProvinceControl.h"

#define BlackColor [UIColor colorWithRed:176/255.0f green:226/255.0f blue:242/255.0f alpha:1]
#define TitleColor [UIColor colorWithRed:180/255.0f green:180/255.0f blue:180/255.0f alpha:1]
@interface ResponseSpeedController ()
@property (nonatomic ,strong)UILabel *titleLabel;
@property (nonatomic ,strong)UIButton *rightBtn;
@property (nonatomic ,strong)ProvinceControl *control;//点击导航栏右边按钮出现的省份控件


@property (nonatomic ,strong)UIScrollView *scrollView;

@end

@implementation ResponseSpeedController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"top_bg"]]];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.hidesBackButton = YES;
    [self reloadView];
}

- (void)reloadView{
    UIButton *leftBtn = [ToolUtil buttonWithFrame:CGRectMake(0, 0, 40, 40) font:12 BackImage:@"button_bg" target:self action:@selector(navBtn:) color:[UIColor whiteColor] title:@"返回"];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    _rightBtn = [ToolUtil buttonWithFrame:CGRectMake(0, 0, 34, 34) font:10 BackImage:@"button_bg" target:self action:@selector(navBtn:) color:[UIColor whiteColor] title:@"上海"];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:_rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    _titleLabel = [ToolUtil labelWithFrame:CGRectMake(0, 0, 120, 44) font:25 color:[UIColor whiteColor] Alignment:NSTextAlignmentCenter text:@"响应测速"];
    self.navigationItem.titleView = _titleLabel;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight-64)];
    _scrollView.bounces = NO;
    _scrollView.contentSize = CGSizeMake(0, 667-64);
    _scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_scrollView];
    
    UILabel *topLabel = [ToolUtil labelWithFrame:CGRectMake(0, 0, UIScreenWidth, 42) font:18 color:[UIColor blackColor] Alignment:NSTextAlignmentCenter text:@"全部启动"];
    topLabel.backgroundColor = BlackColor;
    [_scrollView addSubview:topLabel];
    
    CGFloat width = UIScreenWidth*2.1/5;
    CGFloat heigth = (667-53-64-42)/10;
    NSArray *titleArray = @[@"4G吐槽类别列表",@"获取邀请码",@"应用详情查询",@"国际漫游热门国家",@"附近网点区县",@"附近网点营业厅",@"10000知道网页",@"天翼俱乐部网页",@"宽带报障网页",@"用户套餐详情"];
        NSArray *labelArray = @[@"99毫秒",@"67毫秒",@"113毫秒",@"508毫秒",@"80毫秒",@"36毫秒",@"176毫秒",@"34毫秒",@"66毫秒",@"76毫秒"];
    for (int i = 0; i<10; i++) {

        UIButton *btn = [ToolUtil buttonWithFrame:CGRectMake(0, 50+i*(heigth+5), width, heigth) target:self action:@selector(btnClick:) color:[UIColor blackColor] title:titleArray[i]];
        btn.tag = 10+i;
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.backgroundColor = BlackColor;
        [_scrollView addSubview:btn];
        
        UILabel *label = [ToolUtil labelWithFrame:CGRectMake(btn.right+3, 50+i*(heigth+5),UIScreenWidth-width-3, heigth) font:14 color:TitleColor Alignment:NSTextAlignmentLeft text:[NSString stringWithFormat:@"使用时间：%@",labelArray[i]]];
        label.hidden = YES;
        label.tag = 20+i;
        [_scrollView addSubview:label];
    }
    //点击导航栏右边省份出现
    _control = [[ProvinceControl alloc] initWithFrame:CGRectMake(UIScreenWidth-90, 0, 80, UIScreenHeight*2/3)];
    _control.layer.cornerRadius = 5;
    __weak ProvinceControl*weak = _control;
    _control.cellBlcok = ^(NSString*str){
        
        NSLog(@"%@",str);
        weak.hidden = !weak.hidden;
    };
    [self.view addSubview:_control];
    _control.hidden = YES;

    
}
- (void)navBtn:(UIButton*)btn{
    if ([btn.titleLabel.text isEqualToString:@"返回"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        _control.hidden = !_control.hidden;
    }
    
}
- (void)btnClick:(UIButton*)button{
    UILabel *label = (UILabel*)[self.view viewWithTag:button.tag+10];
    label.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
