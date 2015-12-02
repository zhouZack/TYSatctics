//
//  HuanGoAccountController.m
//  TYStatistics
//
//  Created by Zc_zhou on 15/11/23.
//  Copyright © 2015年 Josh.Shron. All rights reserved.
//

#import "HuanGoAccountController.h"
#import "UserDetailViewController.h"

#define BlackColor [UIColor colorWithRed:251/255.0f green:251/255.0f blue:251/255.0f alpha:1]
#define BorderColor [UIColor colorWithRed:237/255.0f green:237/255.0f blue:237/255.0f alpha:1].CGColor
@interface HuanGoAccountController ()
@property (nonatomic ,strong)UILabel *titleLabel;

@property (nonatomic ,strong)NSArray*dataSource;//总的数据数组，保存的事字典

@property (nonatomic ,strong)NSMutableArray *titleLabelArray;
@property (nonatomic ,strong)NSMutableArray *numLabelArray;
@property (nonatomic ,strong)NSMutableArray *percentLabelArray;

@end

@implementation HuanGoAccountController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"top_bg"]]];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.hidesBackButton = YES;
    [self reloadView];
    [self reloadData];
}

- (void)reloadData{
    
    [TYSProgressHUD show];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    dict[@"dateNum"] = @"2";
    dict[@"province"] = @"集团";
    dict[@"statisticDate"] = @"20150601";

    [manager POST:@"http://101.95.48.92:8004/clientuni/services/userStatistic/huangoUserStat" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            _dataSource = responseObject[@"statDataList"];
            [self updataSubView];
            [TYSProgressHUD dismissSuccessWith:@"加载成功"];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [TYSProgressHUD dismessFailWith:@"加载失败"];
    }];
    
    
}
- (void)updataSubView{
    if (_dataSource.count == _titleLabelArray.count) {
        //解析请求回来的数据
        for (int i = 0 ; i<_dataSource.count ; i++) {
            UILabel*titleLabel = _titleLabelArray[i];
            UILabel*numLabel = _numLabelArray[i];
            UILabel*percentLabel = _percentLabelArray[i];
            NSDictionary *dict = _dataSource[i];
            titleLabel.text = dict[@"kpiName"];
            numLabel.text = dict[@"statNums"];
            NSString*str;
            if ([dict[@"arrow"] isEqualToString:@"2"]) {
                str = @"↓";
            }else if([dict[@"arrow"] isEqualToString:@"1"]){
                str = @"↑";
            }else{
                str = @"";
            }
            NSString*str2 =@"%";
            percentLabel.text = [NSString stringWithFormat:@"%@%@%@",str,dict
                                 [@"percent"],str2];
            NSRange range = [percentLabel.text rangeOfString:@"↓"];
            if (range.length) {
                percentLabel.textColor = [UIColor greenColor];
            }
            
        }
    }
    
}
- (void)reloadView
{
    _titleLabelArray = [[NSMutableArray alloc] init];
    _numLabelArray = [[NSMutableArray alloc] init];
    _percentLabelArray = [[NSMutableArray alloc] init];
    
    UIButton *leftButton = [ToolUtil buttonWithFrame:CGRectMake(0, 0, 40,40) font:12 BackImage:@"button_bg" target:self action:@selector(navBtn:) color:[UIColor whiteColor] title:@"返回"];
    _titleLabel = [ToolUtil labelWithFrame:CGRectMake(0, 0, 120, 44) font:25 color:[UIColor whiteColor] Alignment:NSTextAlignmentCenter text:@"欢GO统计"];

    self.navigationItem.titleView = _titleLabel;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    CGFloat width = (UIScreenWidth-40)/2;
    CGFloat downH = 123*UIScreenHeight/667;
    CGFloat height = (UIScreenHeight-64-downH-45)/4;
    NSArray* titleArr = @[@"户",@"用户",@"户",@"累",@"累计迁用户",@"",@"服量",@"累"];
    NSArray* numArr = @[@"11",@"421",@"5828",@"0",@"0",@"983",@"113",@"0"];
    NSArray* percentArr = @[@"2%",@"82%",@"↓.82%",@"0",@"0",@".82%",@"↓",@""];
    for (int i =0; i<8; i++) {
        NSInteger row = i%2;
        NSInteger section = i/2;
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10+row*(width+10), 15+section*(height+10), width, height)];
        button.tag = 10+i;
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = BlackColor;
        button.layer.cornerRadius = 5;
        button.layer.borderWidth = 2.0;
        button.layer.borderColor = BorderColor;
        [self.view addSubview:button];
        
        UILabel *titleLabel = [ToolUtil labelWithFrame:CGRectMake(0, 0, button.width, button.height/3) font:18 color:[UIColor blackColor] Alignment:NSTextAlignmentCenter text:titleArr[i]];
        [button addSubview:titleLabel];
        
        UILabel *numLabel = [ToolUtil labelWithFrame:CGRectMake(0, button.height/3, button.width, button.height/3) font:18 color:[UIColor blackColor] Alignment:NSTextAlignmentCenter text:numArr[i]];
        [button addSubview:numLabel];
        
        UILabel *percentLabel = [ToolUtil labelWithFrame:CGRectMake(0, button.height*2/3, button.width, button.height/3) font:18 color:[UIColor redColor] Alignment:NSTextAlignmentCenter text:percentArr[i]];
        [button addSubview:percentLabel];
        [_titleLabelArray addObject:titleLabel];
        [_numLabelArray addObject:numLabel];
        [_percentLabelArray addObject:percentLabel];

    }

}
- (void)navBtn:(UIButton*)button{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)btnClick:(UIButton*)btn{
    NSInteger inter = btn.tag;
    UserDetailViewController *use = [[UserDetailViewController alloc] init];
    use.fromWhere = @"欢GO";
    use.integer = 0;
        if (inter == 10) {
            use.titleText = @"新增用户统计";
            use.kpiType = @"1001";
            use.provinceGH = @"安徽";
            use.todayNumText = _dataSource[inter-10][@"statNums"];
            use.todayAccountLabelText = _dataSource[inter-10][@"kpiName"];
            UILabel *label =_percentLabelArray[inter-10];
            use.accountNUmText = label.text;
            
            
        }else if (inter ==11){
            use.titleText = @"迁移用户统计";
            use.kpiType = @"1002";
            use.provinceGH = @"安徽";
            use.todayNumText = _dataSource[inter-10][@"statNums"];
            use.todayAccountLabelText = _dataSource[inter-10][@"kpiName"];
            UILabel *label =_percentLabelArray[inter-10];
            use.accountNUmText = label.text;
        }else if (inter == 12){
            use.titleText = @"登陆用户统计";
            use.kpiType = @"1003";
            use.provinceGH = @"安徽";
            use.todayNumText = _dataSource[inter-10][@"statNums"];
            use.todayAccountLabelText = _dataSource[inter-10][@"kpiName"];
            UILabel *label =_percentLabelArray[inter-10];
            use.accountNUmText = label.text;
            
        }else if (inter == 13){
            use.titleText = @"累计发展用户统计";
            use.kpiType = @"1008";
            use.provinceGH = @"安徽";
            use.todayNumText = _dataSource[inter-10][@"statNums"];
            use.todayAccountLabelText = _dataSource[inter-10][@"kpiName"];
            UILabel *label =_percentLabelArray[inter-10];
            use.accountNUmText = label.text;
        }else if (inter == 14){
            use.titleText = @"累计迁移用户统计";
            use.kpiType = @"1009";
            use.provinceGH = @"安徽";
            use.todayNumText = _dataSource[inter-10][@"statNums"];
            use.todayAccountLabelText = _dataSource[inter-10][@"kpiName"];
            UILabel *label =_percentLabelArray[inter-10];
            use.accountNUmText = label.text;
        }else if (inter == 15){
            use.titleText = @"登陆次数统计";
            use.kpiType = @"1010";
            use.provinceGH = @"安徽";
            use.todayNumText = _dataSource[inter-10][@"statNums"];
            use.todayAccountLabelText = _dataSource[inter-10][@"kpiName"];
            UILabel *label =_percentLabelArray[inter-10];
            use.accountNUmText = label.text;
        }else if (inter == 16){
            use.titleText = @"服务量统计";
            use.kpiType = @"1011";
            use.provinceGH = @"安徽";
            use.todayNumText = _dataSource[inter-10][@"statNums"];
            use.todayAccountLabelText = _dataSource[inter-10][@"kpiName"];
            UILabel *label =_percentLabelArray[inter-10];
            use.accountNUmText = label.text;
        }else if (inter == 17){
            use.titleText = @"累计服务总量";
            use.kpiType = @"1012";
            use.provinceGH = @"安徽";
            use.todayNumText = _dataSource[inter-10][@"statNums"];
            use.todayAccountLabelText = _dataSource[inter-10][@"kpiName"];
            UILabel *label =_percentLabelArray[inter-10];
            use.accountNUmText = label.text;
        }

        [self.navigationController pushViewController:use animated:YES];
    
    
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
