//
//  TestViewController.m
//  TYStatistics
//
//  Created by Zc_zhou on 15/11/18.
//  Copyright © 2015年 Josh.Shron. All rights reserved.
//

#import "TestViewController.h"
@interface TestViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong)UIScrollView *scrollView;

@property (nonatomic,strong)NSArray *provenceArray;

@property (nonatomic ,strong)NSString *str;


@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    userStatistic/clientuni/services/userAccount/countUserByCon?userType=0,province=上海
    self.view.backgroundColor = [UIColor whiteColor];

//    [self post];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    btn.top = UIScreenHeight-20;
    btn.left =20;
    [self.view addSubview:btn];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [btn2 addTarget:self action:@selector(click2:) forControlEvents:UIControlEventTouchUpInside];
    btn2.top = UIScreenHeight-20;
    btn2.left =150;
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [btn3 addTarget:self action:@selector(click3:) forControlEvents:UIControlEventTouchUpInside];
    btn3.top = UIScreenHeight-20;
    btn3.left =200;
    [self.view addSubview:btn3];
    
    NSInteger x = 2556788;
    NSInteger y = 2600000;
    
    CGFloat z = (CGFloat)x/y;
    
    NSLog(@"%f",z);
//    [self progress];
}
- (void)click:(UIButton*)btn{
//    [ProgressHUD showOnView:self.view];
    [TYSProgressHUD show];
    
}
- (void)click2:(UIButton*)btn{
//    [ProgressHUD hideAfterSuccessOnView:self.view];

    [TYSProgressHUD dismissSuccessWith:@"加载成功"];
}
- (void)click3:(UIButton*)btn{
//    [ProgressHUD hideAfterFailOnView:self.view];
    [TYSProgressHUD dismessFailWith:@"加载失败"];
    
}
- (void)progress{
   
    
}
- (void)post{
    [TYSProgressHUD show];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    dict[@"userType"]=@"0";
    dict[@"province"]= @"";
    
    [manager POST:@"http://101.95.48.92:8004/clientuni/services/userAccount/countUserByCon" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            _str = responseObject[@"totalCount"];
            NSLog(@"%@",_str);
            _provenceArray = responseObject[@"userCountList"];
            for (NSDictionary *dict in _provenceArray) {
                NSLog(@"%@",dict[@"province"]);
            }
        }
        [TYSProgressHUD dismissSuccessWith:@"加载成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error = %@",error);
    }];
    
    //    [mg setRequestSerializer:[AFJSONRequestSerializer serializer]];
    //    mg.requestSerializer = [AFJSONRequestSerializer serializer];
    //    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://101.95.48.92:8004/clientuni/services/userAccount/countUserService"]];
    //    [request setHTTPMethod:@"POST"];
    //    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    //    [request setHTTPBody:data];
    //    [mg HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
    //        NSLog(@"%@",responseObject);
    //    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //        NSLog(@"%@",error.description);
    //    }];
    //  dict[@"statisticDate"]=@"20150601";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)ccccc{
//    _todayDevelopLabel = [ToolUtil labelwithFrame:CGRectMake(dataName.left, dataName.bottom+3, 100, 20) font:14 text:@">今日用户发展:"];
//    [_todayDevelopLabel sizeToFit];
//    [self.view addSubview:_todayDevelopLabel];
//    
//    _todayNumber = [ToolUtil labelwithFrame:CGRectMake(_todayDevelopLabel.right+10, _todayDevelopLabel.top, 100, 20) font:14 text:@"0"];
//    _todayNumber.textColor = [UIColor redColor];
//    [_todayNumber sizeToFit];
//    [self.view addSubview:_todayNumber];
//    
//    UIView *todayV = [[UIView alloc] initWithFrame:CGRectMake(_todayDevelopLabel.left, _todayDevelopLabel.bottom+3, UIScreenWidth*3/4, 15)];
//    todayV.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.6];
//    [self.view addSubview:todayV];
//    
//    _todayFormData = [[UILabel alloc] initWithFrame:todayV.frame];
//    _todayFormData.width = 4*_todayFormData.width/5;
//    _todayFormData.backgroundColor = [UIColor orangeColor];
//    [self.view addSubview:_todayFormData];
//    
//    _accountDevelopLabel = [ToolUtil labelwithFrame:CGRectMake(todayV.left, todayV.bottom+3, 100, 20) font:14 text:@">累计用户发展:"];
//    [_accountDevelopLabel sizeToFit];
//    [self.view addSubview:_accountDevelopLabel];
//    
//    _accountNumber = [ToolUtil labelwithFrame:CGRectMake(_accountDevelopLabel.right+10,_accountDevelopLabel.top, 100, 20) font:14 text:@"0"];
//    _accountNumber.textColor = [UIColor redColor];
//    [_accountNumber sizeToFit];
//    [self.view addSubview:_accountNumber];
//    
//    UIView *accountV = [[UIView alloc] initWithFrame:CGRectMake(_accountDevelopLabel.left, _accountDevelopLabel.bottom+3, UIScreenWidth*3/4, 15)];
//    accountV.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.6];
//    [self.view addSubview:accountV];
//    
//    _accountFormDate = [[UILabel alloc] initWithFrame:accountV.frame];
//    _accountFormDate.width = 2*_accountFormDate.width/3;
//    _accountFormDate.backgroundColor = [UIColor greenColor];
//    [self.view addSubview:_accountFormDate];

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
