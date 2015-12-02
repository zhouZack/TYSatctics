//
//  UserDetailViewController.m
//  TYStatistics
//
//  Created by Zc_zhou on 15/11/17.
//  Copyright © 2015年 Josh.Shron. All rights reserved.
//

#import "UserDetailViewController.h"
#import "ProvinceControl.h"
#import "UserPartialGraph.h"
#import "UserTotalGraph.h"


@interface UserDetailViewController ()

@property (nonatomic ,strong) UILabel *titleLabel;//导航栏标题label

@property (nonatomic ,strong) UILabel *dataLabel;//日期label
@property (nonatomic ,strong) UILabel *todayDevelopLabel;
@property (nonatomic ,strong) UILabel *todayNumber;//今日用户发展数量；
@property (nonatomic ,strong) UILabel *todayFormData;//今日用户发展的数据横条
@property (nonatomic ,strong) UILabel *accountDevelopLabel;
@property (nonatomic ,strong) UILabel *accountNumber;//累计数量;
@property (nonatomic ,strong) UILabel *accountFormDate;//累计用户的数据横条
@property (nonatomic ,strong) UIView *labelContainer;//上面6个label的容器
@property (nonatomic ,strong) UILabel *userLabel;//用户发展情况的label

@property (nonatomic ,strong) UIView *downView;//最底下放4个btn的View
@property (nonatomic ,strong) UIImageView *downImageView;//放蓝色分分割线图片bottom_bg的
@property (nonatomic ,strong) UILabel *userAcc;//downImageView下面的那个Label
@property (nonatomic ,strong) NSDate *todayDate;//当天日期
@property (nonatomic ,strong) NSMutableArray *downLabelArray;//装底部视图4个按钮上面的4个label

@property (nonatomic ,strong) UserPartialGraph *userDevelopTable;//现实条状数据的View
@property (nonatomic ,strong) UserTotalGraph *totalGraph;//条状数据大表

@property (nonatomic ,strong) UIButton *navRight;//导航栏右边省份Button

@property (nonatomic ,strong) ProvinceControl *control;//右边那栏省份的控制器

@property (nonatomic ,strong) UIControl *gestrueControl;//手势控制器
@property (nonatomic ,strong) UIView *leftView;//右边的侧推视图;
@property (nonatomic ,strong) NSMutableArray *leftBtnArray;//右边的侧推视图保存button的数组

/**
 数据请求
 */
@property (nonatomic ,strong)NSMutableArray *provinceArray;//每个省名称
@property (nonatomic ,strong)NSMutableArray *totalusersArray;//每个省／市用户数据
@property (nonatomic ,strong)NSMutableArray *totalusersChangeArray;//每个省／市用户数据转换成小数点保留2位
@property (nonatomic ,strong)NSMutableArray *stripArray;//数据条比例数据
@property (nonatomic ,strong)NSMutableArray *leftNumArray;//表格左侧的6个数据
@property (nonatomic ,assign)BOOL City;//用来判断接收省或者是市名称

//请求数据的3个参数
@property (nonatomic ,copy)NSString *userType;
@property (nonatomic ,copy)NSString *dateNum;
@property (nonatomic ,copy)NSString *province;



@end

@implementation UserDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"top_bg"]]];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor] ;
    [self reloadView];
    [self reloadDate];

    

}

- (void)reloadDate{
    _totalusersArray = [[NSMutableArray alloc] init];
    _provinceArray = [[NSMutableArray alloc] init];
    _stripArray = [[NSMutableArray alloc] init];
    _totalusersChangeArray = [[NSMutableArray alloc] init];
    _leftNumArray = [[NSMutableArray alloc] init];
    
    [_totalusersArray removeAllObjects];
    [_provinceArray removeAllObjects];
    [_stripArray removeAllObjects];
    [_totalusersChangeArray removeAllObjects];
    [_leftNumArray removeAllObjects];
    
    [TYSProgressHUD show];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    if ([self.fromWhere isEqualToString:@"欢GO"]) {
        _todayDevelopLabel.text = [NSString stringWithFormat:@">%@数",self.todayAccountLabelText];
        _accountDevelopLabel.text = [NSString stringWithFormat:@">%@变化率",self.todayAccountLabelText];
        [_todayDevelopLabel sizeToFit];
        [_accountDevelopLabel sizeToFit];
        
        _todayNumber.left = _todayDevelopLabel.right+10;
        _accountNumber.left = _accountDevelopLabel.right+10;
        _todayNumber.text = self.todayNumText;
        _accountNumber.text = self.accountNUmText;
        [_todayNumber sizeToFit];
        [_accountNumber sizeToFit];
        _userLabel.text = self.titleText;
        [_userLabel sizeToFit];
        NSMutableDictionary*dict = [[NSMutableDictionary alloc] init];
        dict[@"kpiType"]=_kpiType;
        dict[@"dateNum"]=_dateNum;
        dict[@"province"]=_provinceGH;
        dict[@"statisticDate"]=@"20150714";
        
        [manager POST:@"http://101.95.48.92:8004/clientuni/services/userStatistic/huangoSideData" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            if ([responseObject isKindOfClass:[NSDictionary class]])
            {
                
                NSArray *array = responseObject[@"sideDataList"];
       
                if (array.count) {
                    [TYSProgressHUD dismissSuccessWith:@"加载数据成功"];
                    for (NSDictionary *dict in array) {
                        [_totalusersArray addObject:dict[@"kpiValue"]];
                        [_provinceArray addObject:dict[@"city"]];
                    }
                    [self reloadsubView];
                }else{
                    [self reloadsubView];
                    [self RemoveUserPartialGraph];
                    [TYSProgressHUD dismessFailWith:@"暂无数据"];
                }
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            [TYSProgressHUD dismessFailWith:@"加载数据失败"];
            NSLog(@"error =%@",error);
        }];
        
    }
    else if ([self.fromWhere isEqualToString:@"用户服务"]){
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        dict[@"userType"]=_kpiType;
        dict[@"dateNum"]=_dateNum;
        dict[@"province"]= _province;
        [manager POST:@"http://101.95.48.92:8004/clientuni/services/userAccount/countUserService" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                
                NSArray*array = responseObject[@"clientJumpList"];
                if (array.count) {
                    [TYSProgressHUD dismissSuccessWith:@"加载数据成功"];
                    for (NSDictionary *dict in array) {
                        [_totalusersArray addObject:dict[@"kpiValue"]];
                        [_provinceArray addObject:dict[@"city"]];
                    }

                    [self reloadsubView];
                }else{
                    [self reloadsubView];
                    [self RemoveUserPartialGraph];
                    _labelContainer.hidden = YES;
                    _userLabel.top = _dataLabel.bottom+10;
                    [TYSProgressHUD dismessFailWith:@"暂无数据"];
                }
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [TYSProgressHUD dismessFailWith:@"加载失败"];
            NSLog(@"error=%@",error);
        }];
    }
    else if ([self.fromWhere isEqualToString:@"栏目动态"]){
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        dict[@"dateNum"] = _dateNum;
        dict[@"province"] = _province;
        [manager POST:@"http://101.95.48.92:8004/clientuni/services/userAccount/sortHotColumn" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                
                NSArray*array = responseObject[@"clientJumpList"];
                if (array.count) {
                    [TYSProgressHUD dismissSuccessWith:@"加载数据成功"];
                    //                    for (NSDictionary *dict in array) {
                    //                        [_totalusersArray addObject:dict[@"kpiValue"]];
                    //                        [_provinceArray addObject:dict[@"city"]];
                    //                    }
                    [self reloadsubView];
                }else{
                    [self reloadsubView];
                    [self RemoveUserPartialGraph];
                    _labelContainer.hidden = YES;
                    _userLabel.top = _dataLabel.bottom+10;
                    [TYSProgressHUD dismessFailWith:@"暂无数据"];
                }
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [TYSProgressHUD dismessFailWith:@"加载失败"];
            NSLog(@"error=%@",error);
        }];
    }else if ([self.fromWhere isEqualToString:@"热门活动"]){
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        dict[@"dateNum"] = _dateNum;
        dict[@"province"] = _province;
        [manager POST:@"http://101.95.48.92:8004/clientuni/services/userAccount/sortHotActivity" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                NSArray*array = responseObject[@"clientJumpList"];
                if (array.count) {
                    [TYSProgressHUD dismissSuccessWith:@"加载数据成功"];
                    //                    for (NSDictionary *dict in array) {
                    //                        [_totalusersArray addObject:dict[@"kpiValue"]];
                    //                        [_provinceArray addObject:dict[@"city"]];
                    //                    }
                    [self reloadsubView];
                }else{
                    [self reloadsubView];
                    [self RemoveUserPartialGraph];
                    _labelContainer.hidden = YES;
                    _userLabel.top = _dataLabel.bottom+10;
                    [TYSProgressHUD dismessFailWith:@"暂无数据"];
                }
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [TYSProgressHUD dismessFailWith:@"加载失败"];
            NSLog(@"error=%@",error);
            
        }];
    }
    else{
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        
        if ([_userType isEqualToString:@"0"]) {
            
            dict[@"userType"]=@"0";
            dict[@"province"]= _province;
        }else{
            dict[@"userType"]=_userType;
            dict[@"dateNum"]=_dateNum;
            dict[@"province"]= _province;
        }
        
        
        [manager POST:@"http://101.95.48.92:8004/clientuni/services/userAccount/countUserByCon" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                
                
                if ([responseObject[@"newUserCount"] isKindOfClass:[NSNull class]]) {
                    _todayNumber.text = @"0";
                }else{
                    _todayNumber.text = responseObject[@"newUserCount"];
                    [_todayNumber sizeToFit];
                }
                if ([responseObject[@"totalCount"] isKindOfClass:[NSNull class]]) {
                    _accountNumber.text = @"0";
                }else{
                    _accountNumber.text = responseObject[@"totalCount"];
                    [_accountNumber sizeToFit];
                }
                
                NSArray *array = responseObject[@"userCountList"];
                if (array.count !=0)
                {
                    for (NSDictionary *dict in array)
                    {
                        [_totalusersArray addObject:dict[@"totalusers"]];
                        if (_City == NO){
                            [_provinceArray addObject:dict[@"province"]];
                        }else{
                            [_provinceArray addObject:dict[@"city"]];
                        }
                        
                    }
                    [TYSProgressHUD dismissSuccessWith:@"加载成功"];
                    [self reloadsubView];
                }else{
                    [TYSProgressHUD dismessFailWith:@"暂无数据"];
                    [self RemoveUserPartialGraph];
                }
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [TYSProgressHUD dismessFailWith:@"加载失败"];
            NSLog(@"error = %@",error);
        }];

    }
    
}
- (void)reloadsubView{
    
    [_userDevelopTable removeFromSuperview];
    [self createPartialGraphAndProvinceControl:_provinceArray.count];
    _userDevelopTable.textArray = _provinceArray;
    
    if ([self.fromWhere isEqualToString:@"欢GO"]||[self.fromWhere isEqualToString:@"用户服务"]||[self.fromWhere isEqualToString:@"热门活动"]||[self.fromWhere isEqualToString:@"栏目动态"]) {
        
        int max=10;
        for (NSString *string in _totalusersArray) {
            if (max<[string intValue]) {
                max = [string intValue];
            }
        }
        //判断数值是否很大，很大就转换为以万为单位
        if(max >10000){
            //以保留小数点2位的形式转换数据
            for (NSString *string in _totalusersArray) {
                
                CGFloat y = (CGFloat)[string intValue]/10000;
                [_totalusersChangeArray addObject:[NSString stringWithFormat:@"%.2f",y]];
                
            }
            _userDevelopTable.countArray = _totalusersChangeArray;
            //计算表格右边的视图

            CGFloat mac = (CGFloat)max/10000;
                        //计算表格左侧边的数据
            for (int i= 5; i>0; i--) {
                CGFloat text = (CGFloat)mac*i/5;
                NSString *str = [NSString stringWithFormat:@"%.1f万",text];
                [_leftNumArray addObject:str];
            }
            //计算表格条状图长度百分比
            for (NSString *string in _totalusersArray) {
                int y = [string intValue];
                CGFloat precent = (CGFloat)y/max;
                NSString*str = [NSString stringWithFormat:@"%f",precent];
                [_stripArray addObject:str];
            }
            _userDevelopTable.numberArray = _leftNumArray;
            _userDevelopTable.stripArray = _stripArray;


        }else{
            _userDevelopTable.countArray = _totalusersArray;
            //计算表格左侧边的数据
            for (int i= 5; i>0; i--) {
                int text = max*i/5;
                NSString *str = [NSString stringWithFormat:@"%d",text];
                [_leftNumArray addObject:str];
            }
            //计算表格条状图长度百分比
            for (NSString *string in _totalusersArray) {
                CGFloat percent = (CGFloat)[string intValue]/max;
                [_stripArray addObject:[NSString stringWithFormat:@"%f",percent]];
            }
            _userDevelopTable.numberArray = _leftNumArray;
            _userDevelopTable.stripArray = _stripArray;
        }
       
        
    }else{
        
        //以保留小数点2位的形式转换数据
        for (NSString *string in _totalusersArray) {
            
            CGFloat y = (CGFloat)[string intValue]/10000;
            [_totalusersChangeArray addObject:[NSString stringWithFormat:@"%.2f",y]];
            
        }
        _userDevelopTable.countArray = _totalusersChangeArray;
        //计算表格右边的视图
        int max = [_totalusersArray[0] intValue];
        int ran = max/10000;
        int mac;
        if (max %10000 ==0) {
            mac = ran;
            int z = mac%5;
            while (z!= 0) {
                mac++;
                z = mac%5;
            }
        }else{
            mac = ran+1;
            int z = mac%5;
            while (z!= 0) {
                mac++;
                z = mac%5;
            }
        }
        //计算表格左侧边的数据
        for (int i= 5; i>0; i--) {
            int text = mac*i/5;
            NSString *str = [NSString stringWithFormat:@"%d万",text];
            [_leftNumArray addObject:str];
        }
        //计算表格条状图长度百分比
        for (NSString *string in _totalusersArray) {
            int y = [string intValue];
            CGFloat precent = (CGFloat)y/(mac*10000);
            NSString*str = [NSString stringWithFormat:@"%f",precent];
            [_stripArray addObject:str];
        }
        _userDevelopTable.numberArray = _leftNumArray;
        _userDevelopTable.stripArray = _stripArray;
    }

}
- (void)setInteger:(NSInteger)integer
{
    _integer = integer;

}
- (void)reloadView
{
    _userType = @"0";
    if ([self.fromWhere isEqualToString:@"欢GO"]) {
        _dateNum = @"3";
    }else{
        _dateNum = @"15";
    }
    
    _province =@"";
    
    _todayDate = [[NSDate alloc] init];
    
    _titleLabel = [ToolUtil labelWithFont:25 color:[UIColor whiteColor] bold:YES Alignment:NSTextAlignmentCenter text:_titleText];
    _titleLabel.size = CGSizeMake(160, 44);
   self.navigationItem.titleView = _titleLabel;
    
    UIView *rightView = [[UIView alloc] init];
    rightView.size = CGSizeMake(78, 44);
    UIButton*leftBtn = [ToolUtil buttonWithFrame:CGRectMake(10, 5, 34, 34) font:12 BackImage:@"small_button_bg_left" target:nil action:nil color:[UIColor whiteColor] title:@"集团"];
    leftBtn.userInteractionEnabled = NO;
    [rightView addSubview:leftBtn];
    
    _navRight = [ToolUtil buttonWithFrame:CGRectMake(44, 5, 34, 34) font:12 BackImage:@"small_button_bg_right" target:self action:@selector(navBtn:) color:[UIColor whiteColor] title:@"省份"];
    [rightView addSubview:_navRight];
    
    UIButton *leftButton = [ToolUtil buttonWithFrame:CGRectMake(0, 0, 40,40) font:12 BackImage:@"button_bg" target:self action:@selector(navBtn:) color:[UIColor whiteColor] title:@"返回"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    UILabel *dataName = [ToolUtil labelwithFrame:CGRectMake(10, 15, 40, 20) font:14 text:@"日期:"];
    [self.view addSubview:dataName];
    
    _dataLabel = [ToolUtil labelwithFrame:CGRectMake(dataName.right+10, dataName.top, UIScreenWidth-dataName.right+20, 20) font:14 text:[NSString stringWithFormat:@"%@--%@",[[_todayDate agoWithDays:14] dateToStringWithFormater:@"yyyy年MM月dd日"],[_todayDate dateToStringWithFormater:@"yyyy年MM月dd日"]]];
    _dataLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_dataLabel];
    
    _labelContainer = [[UIView alloc] initWithFrame:CGRectMake(0, dataName.bottom, UIScreenWidth, 81)];
    _labelContainer.backgroundColor = [UIColor clearColor] ;
    [self.view addSubview:_labelContainer];
    
    _todayDevelopLabel = [ToolUtil labelwithFrame:CGRectMake(dataName.left,3, 100, 20) font:14 text:@">今日用户发展:"];
    [_todayDevelopLabel sizeToFit];
    [_labelContainer addSubview:_todayDevelopLabel];
    
    _todayNumber = [ToolUtil labelwithFrame:CGRectMake(_todayDevelopLabel.right+10, _todayDevelopLabel.top, 100, 20) font:14 text:@"0"];
    _todayNumber.textColor = [UIColor redColor];
    [_todayNumber sizeToFit];
    [_labelContainer addSubview:_todayNumber];
    
    UIView *todayV = [[UIView alloc] initWithFrame:CGRectMake(_todayDevelopLabel.left, _todayDevelopLabel.bottom+3, UIScreenWidth*3/4, 15)];
    todayV.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.6];
    [_labelContainer addSubview:todayV];
    
    _todayFormData = [[UILabel alloc] initWithFrame:todayV.frame];
    _todayFormData.width = 4*_todayFormData.width/5;
    _todayFormData.backgroundColor = [UIColor orangeColor];
    [_labelContainer addSubview:_todayFormData];
    
    _accountDevelopLabel = [ToolUtil labelwithFrame:CGRectMake(todayV.left, todayV.bottom+3, 100, 20) font:14 text:@">累计用户发展:"];
    [_accountDevelopLabel sizeToFit];
    [_labelContainer addSubview:_accountDevelopLabel];
    
    _accountNumber = [ToolUtil labelwithFrame:CGRectMake(_accountDevelopLabel.right+10,_accountDevelopLabel.top, 100, 20) font:14 text:@"0"];
    _accountNumber.textColor = [UIColor redColor];
    [_accountNumber sizeToFit];
    [_labelContainer addSubview:_accountNumber];
    
    UIView *accountV = [[UIView alloc] initWithFrame:CGRectMake(_accountDevelopLabel.left, _accountDevelopLabel.bottom+3, UIScreenWidth*3/4, 15)];
    accountV.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.6];
    [_labelContainer addSubview:accountV];
    
    _accountFormDate = [[UILabel alloc] initWithFrame:accountV.frame];
    _accountFormDate.width = 2*_accountFormDate.width/3;
    _accountFormDate.backgroundColor = [UIColor greenColor];
    [_labelContainer addSubview:_accountFormDate];
    
    _userLabel = [ToolUtil labelwithFrame:CGRectMake(accountV.left, _labelContainer.bottom, 100, 20) font:12 text:@"用户发展情况"];
    [_userLabel sizeToFit];
    [self.view addSubview:_userLabel];
    

    //底部的蓝色视图
    _downView = [[UIView alloc] initWithFrame:CGRectMake(0, UIScreenHeight-144, UIScreenWidth, 80)];
    _downView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"top_bg"]];
    [self.view addSubview:_downView];
    
    [self createDownBtn:self.integer];
    
    _downImageView = [[UIImageView alloc] init];
    _downImageView.width = UIScreenWidth;
    _downImageView.height = 20;
    _downImageView.bottom = _downView.top-60*UIScreenHeight/667;
    _downImageView.image = [UIImage imageNamed:@"bottom_bg"];
    if (UIScreenWidth == 320) {
        _downImageView.bottom = _downView.top-45*UIScreenHeight/667;
    }
    [self.view addSubview:_downImageView];
    
    
    UILabel *imagLabel = [[UILabel alloc] init];
    imagLabel.width = 50;
    imagLabel.height = 17;
    imagLabel.top = _downImageView.bottom+8;
    imagLabel.right = UIScreenWidth/2;
    imagLabel.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:imagLabel];
    
    _userAcc = [ToolUtil labelwithFrame:CGRectMake(imagLabel.right+8, imagLabel.top, 0, 0) font:13 text:@"用户总计"];
    _userAcc.textColor = [UIColor blueColor];
    [_userAcc sizeToFit];
    [self.view addSubview:_userAcc];
    
    [self addgestrue];
    
    [self addleftView];

}
#pragma mark-创建中间表格视图和省份视图
- (void)createPartialGraphAndProvinceControl:(NSInteger)inter{
    //中间表格视图简图的高度
    CGFloat tableHeight = _downImageView.top - _userLabel.bottom-3;
    _userDevelopTable = [[UserPartialGraph alloc] initWithFrame:CGRectMake(0, _userLabel.bottom+3, UIScreenWidth, tableHeight)];
    _userDevelopTable.tage = 6;
    UIButton *tableBtn = [ToolUtil buttonWithFrame:_userDevelopTable.frame font:0 BackImage:nil target:self action:@selector(tableBtnClick) color:nil title:nil];
    tableBtn.top = 0;
    [_userDevelopTable addSubview:tableBtn];
    [self.view addSubview:_userDevelopTable];
    [_control removeFromSuperview];
    //点击导航栏右边省份出现
    _control = [[ProvinceControl alloc] initWithFrame:CGRectMake(UIScreenWidth-90, 0, 80, UIScreenHeight*2/3)];
    _control.layer.cornerRadius = 5;
    __weak UserDetailViewController*weakSelf = self;
    _control.cellBlcok = ^(NSString*str){
        _province = _provinceGH=str;
        _City = YES;
        [weakSelf reloadDate];
        
        weakSelf.control.hidden = !weakSelf.control.hidden;
    };
    [self.view addSubview:_control];
    _control.hidden = YES;

    
}

- (void)RemoveUserPartialGraph{
    [_userDevelopTable removeFromSuperview];
    
}
#pragma mark-创建底部按钮
- (void)createDownBtn:(NSInteger)num{
    _downLabelArray = [[NSMutableArray alloc] init];
    NSArray *imageArray = @[@"small_icon_1",@"small_icon_2",@"small_icon_3",@"small_icon_4"];
    NSArray *textArray = @[@"用户发展概况",@"新增用户统计",@"用户增速排名",@"预装用户统计"];
    if ([self.fromWhere isEqualToString:@"用户服务"]) {
        textArray = @[@"服务量统计",@"网络吐槽",@"用户增速排名",@"预装用户统计"];
    }
    CGFloat height = 40;
    if (num == 2) {
        height = 80;
    }
    for (int i=0; i<num; i++) {
        NSInteger row = i%2;
        NSInteger section = i/2;
        CGFloat width = UIScreenWidth/2;

        UIButton *btn = [ToolUtil buttonWithFrame:CGRectMake(width*row, section*height, width, height) font:17 BackImage:nil target:self action:@selector(downBtnClivk:) color:nil title:nil];
        btn.tag = 10+i;
        [_downView addSubview:btn];
        UIImageView*imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7, 25, 25)];
        imageView.image = [[UIImage imageNamed:imageArray[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        imageView.centerY = height/2;
        [btn addSubview:imageView];
        
        UILabel *label = [ToolUtil labelwithFrame:CGRectMake(imageView.right+5, 0, 10, 10) font:15 text:textArray[i]];
        label.centerY = height/2;
        label.textColor = [UIColor whiteColor];
        [label sizeToFit];
        [btn addSubview:label];
        [_downLabelArray addObject:label];
    }
}
/**
 添加左边侧推视图
 */
- (void)addleftView{
    //保存左边视图上的3个按钮的数组
    _leftBtnArray = [[NSMutableArray alloc] init];
    _leftView = [[UIView alloc] initWithFrame:CGRectMake(-190, 0, 190*UIScreenWidth/375, UIScreenHeight)];
    UIImageView *imgaeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 190*UIScreenWidth/375, UIScreenHeight)];
    _leftView.userInteractionEnabled = YES;
    imgaeView.userInteractionEnabled = YES;
    imgaeView.image = [UIImage imageNamed:@"right_view_bg"];
    [_leftView addSubview:imgaeView];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    label.centerX = 95;
    label.centerY = 37;
    label.text = @"筛选条件";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:18];
    [_leftView addSubview:label];
    NSArray *titleArray = @[@"最近一日",@"最近七日",@"最近十五日"];
    for (int i=0; i<3; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 190, 3)];
        if (i==0) {
            imageView.top = 64;
        }else{
            imageView.top = 64+i*53;
        }
        imageView.image = [UIImage imageNamed:@"dividing_line"];
        [_leftView addSubview:imageView];
        
        UIButton *btn = [ToolUtil buttonWithFrame:CGRectMake(0, 0, _leftView.width, 50) font:17 SelectBackImage:@"btnBack" target:self action:@selector(leftBtnclick1:)];
        btn.tag = 20+i;
        btn.top = 67+i*53;
        
        UILabel *label = [ToolUtil labelwithFrame:CGRectMake(20, 0, 100, 40) font:17 text:titleArray[i]];
        label.centerY = 25;
        label.textColor = [UIColor whiteColor];
        [btn addSubview:label];
        [_leftView addSubview:btn];
        if (i==2) {
            btn.selected = YES;
        }
        [_leftBtnArray addObject:btn];
    }
    
    [[[UIApplication sharedApplication] keyWindow] addSubview:_leftView];
}

/**
  添加手势
 */
- (void)addgestrue{
    UISwipeGestureRecognizer *swipe=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGestrue:)];
    swipe.direction=UISwipeGestureRecognizerDirectionRight;
    [self.navigationController.view addGestureRecognizer:swipe];
    
    _gestrueControl = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight)];
    _gestrueControl.backgroundColor = [UIColor clearColor];
    UISwipeGestureRecognizer * swip = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestrue:)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestrue:)];
    swip.direction = UISwipeGestureRecognizerDirectionLeft;
    [_gestrueControl addGestureRecognizer:swip];
    [_gestrueControl addGestureRecognizer:tap];
    [self.navigationController.view addSubview:_gestrueControl];
    _gestrueControl.hidden = YES;
}
#pragma mark-手势执行方法
-(void)swipeGestrue:(UIGestureRecognizer *)sender
{
    /*
     右滑出现左边视图。左滑和点击返回原态
     */
    if ([sender isKindOfClass:[UISwipeGestureRecognizer class]]) {
        UISwipeGestureRecognizer *swipeGesture = (UISwipeGestureRecognizer *)sender;
        if (swipeGesture.direction == UISwipeGestureRecognizerDirectionRight) {
            [UIView animateWithDuration:0.5 animations:^{
                _leftView.left = 0;
                self.navigationController.view.left = _leftView.right;
            } completion:^(BOOL finished) {
                _gestrueControl.hidden = NO;
            }];
        }else if (swipeGesture.direction == UISwipeGestureRecognizerDirectionLeft){
            [UIView animateWithDuration:0.5 animations:^{
                self.navigationController.view.left = 0;
                _leftView.left = -190*UIScreenWidth/375;
            } completion:^(BOOL finished) {
                _gestrueControl.hidden = YES;
            }];
        }
    }else if ([sender isKindOfClass:[UITapGestureRecognizer class]]){
        [UIView animateWithDuration:0.5 animations:^{
            self.navigationController.view.left = 0;
            _leftView.left = -190*UIScreenWidth/375;
        } completion:^(BOOL finished) {
            _gestrueControl.hidden = YES;
        }];
    }
}

#pragma mark -左侧边视图切换时间点击响应事件
//3个button的tag值从20～22
- (void)leftBtnclick1:(UIButton*)button
{
    for (UIButton*btn in _leftBtnArray) {
        if (btn.tag ==button.tag) {
            btn.selected = YES;
        }else{
            btn.selected = NO;
        }
    }
    if (button.tag == 20) {
        _dataLabel.text = [NSString stringWithFormat:@"%@",[_todayDate dateToStringWithFormater:@"yyyy年MM月dd日"]];

        _dateNum = @"1";
        [self reloadDate];
        
    }else if (button.tag == 21){
        _dataLabel.text = [NSString stringWithFormat:@"%@--%@",[[_todayDate agoWithDays:6] dateToStringWithFormater:@"yyyy年MM月dd日"],[_todayDate dateToStringWithFormater:@"yyyy年MM月dd日"]];
        if ([self.fromWhere isEqualToString:@"欢GO"]) {
            _dateNum = @"2";
        }else{
            _dateNum = @"7";
        }
        [self reloadDate];
        
    }else{
        _dataLabel.text = [NSString stringWithFormat:@"%@--%@",[[_todayDate agoWithDays:14] dateToStringWithFormater:@"yyyy年MM月dd日"],[_todayDate dateToStringWithFormater:@"yyyy年MM月dd日"]];
        if ([self.fromWhere isEqualToString:@"欢GO"]) {
            _dateNum = @"3";
        }else{
            _dateNum = @"15";
        }
        [self reloadDate];
    }
    
}
#pragma mark -底部4个button点击响应的事件
//4个button的tag值从10～13
- (void)downBtnClivk:(UIButton*)button{
    NSLog(@"%d",(int)button.tag);
    if (button.tag == 10) {
        
        if ([self.fromWhere isEqualToString:@"用户服务"]) {
            _kpiType = @"1";
            _titleLabel.text = @"服务量统计";
            _userLabel.text = @"服务量统计";
            [self reloadDate];
            
        }else{
        _userType = @"0";
        _titleLabel.text = @"用户发展概况";
        _todayDevelopLabel.text = @">今日用户发展:";
        _accountDevelopLabel.text = @">累计用户发展:";
        [_todayDevelopLabel sizeToFit];
        [_accountDevelopLabel sizeToFit];
        _todayNumber.left = _todayDevelopLabel.right+10;
        _accountNumber.left = _accountDevelopLabel.right+10;
        _userLabel.text = @"用户发展概况";
        [self reloadDate];
        }
    }
    else if (button.tag ==11) {
        if ([self.fromWhere isEqualToString:@"用户服务"]) {
            _kpiType = @"2";
            _titleLabel.text = @"网络吐槽";
            _userLabel.text = @"网络吐槽";
            [self reloadDate];
        }else{
        _userType = @"1";
        _dateNum = @"15";
        _titleLabel.text = @"新增用户统计";
        _todayDevelopLabel.text = @">今日新增用户:";
        _accountDevelopLabel.text = @">累计新增用户:";
        [_todayDevelopLabel sizeToFit];
        [_accountDevelopLabel sizeToFit];
        _todayNumber.left = _todayDevelopLabel.right+10;
        _accountNumber.left = _accountDevelopLabel.right+10;
        _userLabel.text = @"新增用户统计";
        [self reloadDate];
        }
    }
    else if (button.tag == 12){
        _userType = @"3";
        _dateNum = @"15";
        _titleLabel.text = @"用户增速排名";
        _todayDevelopLabel.text = @">今日新增用户:";
        _accountDevelopLabel.text = @">累计新增用户:";
        [_todayDevelopLabel sizeToFit];
        [_accountDevelopLabel sizeToFit];
        _todayNumber.left = _todayDevelopLabel.right+10;
        _accountNumber.left = _accountDevelopLabel.right+10;
        _userLabel.text = @"用户增速排名";
        [self reloadDate];

    }else{
        _userType = @"2";
        _dateNum = @"15";
        _titleLabel.text = @"预装用户统计";
        _todayDevelopLabel.text = @">今日预装机新增用户:";
        _accountDevelopLabel.text = @">累计预装机新增用户:";
        [_todayDevelopLabel sizeToFit];
        [_accountDevelopLabel sizeToFit];
        _todayNumber.left = _todayDevelopLabel.right+10;
        _accountNumber.left = _accountDevelopLabel.right+10;
        _userLabel.text = @"预装用户统计";
        [self reloadDate];
    }
}
//navigationControl上的button点击事件
- (void)navBtn:(UIButton*)button{
    
    if ([button.titleLabel.text isEqualToString:@"返回"]) {
        [self.navigationController popViewControllerAnimated:YES];
        [TYSProgressHUD dismissSuccessWith:@""];
    }else{
        _control.hidden = !_control.hidden;
    }
}

#pragma mark- 点击中间表格弹出表格全图
- (void)tableBtnClick{
    _totalGraph = [[UserTotalGraph alloc] initWithFrame:CGRectMake(0, 0, UIScreenHeight, UIScreenWidth)];
    _totalGraph.tage = _provinceArray.count;
    
    _totalGraph.textArray = _provinceArray;
    _totalGraph.numberArray = _leftNumArray;
    _totalGraph.stripArray = _stripArray;
    if ([self.fromWhere isEqualToString:@"欢GO"]) {
        _totalGraph.countArray = _totalusersArray;
    }else{
        _totalGraph.countArray = _totalusersChangeArray;
    }

    __weak UserTotalGraph*weak = _totalGraph;
    _totalGraph.block = ^(NSString*str){
        [UIView animateWithDuration:0.5 animations:^{
            weak.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [weak removeFromSuperview];
        }];
    };
    [[UIApplication sharedApplication].keyWindow addSubview:_totalGraph];
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = [UIScreen mainScreen].bounds;
        CGPoint center = CGPointMake(frame.size.width/2, frame.size.height/2);
        _totalGraph.transform = CGAffineTransformMakeRotation(M_PI/2);
        _totalGraph.center = center;
    }];

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
