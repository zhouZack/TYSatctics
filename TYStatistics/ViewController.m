//
//  ViewController.m
//  TYStatistics
//
//  Created by Josh.Shron on 15/11/16.
//  Copyright © 2015年 Josh.Shron. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

#define userName @"userEnterName"
#define userKey @"userEnterKey"

@interface ViewController ()<UITextFieldDelegate>
@property (nonatomic ,strong)UITextField *accountField;
@property (nonatomic ,strong)UITextField *keyField;
@property (nonatomic ,strong)UIButton *rememberBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"login_bg"]];
    [self reloadView];
}

-(void)reloadView{
    UIView *KeyBview = [[UIView alloc] init];
    KeyBview.backgroundColor = [UIColor whiteColor];
    KeyBview.top = 150*UIScreenHeight/667;
    KeyBview.width = UIScreenWidth-60;
    KeyBview.height = 100;
    KeyBview.centerX = UIScreenWidth/2;
    KeyBview.layer.cornerRadius = 5;
    [self.view addSubview:KeyBview];
    
    _accountField = [[UITextField alloc] init];
    _accountField.width = KeyBview.width-10;
    _accountField.left = 5;
    _accountField.height = 50;
    _accountField.top = 0;
    _accountField.placeholder = @"请输入用户名";
    _accountField.text = [[NSUserDefaults standardUserDefaults] objectForKey:userName];
    [KeyBview addSubview:_accountField];
    
    _keyField = [[UITextField alloc] init];
    _keyField.top = _accountField.bottom;
    _keyField.size = _accountField.size;
    _keyField.left = 5;
    _keyField.secureTextEntry = YES;
    _keyField.placeholder = @"请输入密码";
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"whetherSave"] isEqualToString:@"conserve"]){
        _keyField.text = [[NSUserDefaults standardUserDefaults] objectForKey:userKey];
    }
    
    [KeyBview addSubview:_keyField];
    
    UILabel*lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
    lineLabel.top = 50;
    lineLabel.width = KeyBview.width;
    lineLabel.height = 1;
    [KeyBview addSubview:lineLabel];
    
    
    UILabel *label = [[UILabel alloc] init];
    label.top = KeyBview.bottom+10;
    label.width = 120;
    label.height = 40;
    label.font = [UIFont boldSystemFontOfSize:18];
    label.text = @"记住密码";
    [label sizeToFit];
    label.right = KeyBview.right;
    label.textColor = [UIColor whiteColor];
    
    [self.view addSubview:label];
    
    _rememberBtn = [[UIButton alloc] init];
    [_rememberBtn setTitle:@"√" forState:UIControlStateSelected];
    _rememberBtn.selected = YES;
    _rememberBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    _rememberBtn.layer.borderWidth = 2;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0, 0,0, 1 });
    _rememberBtn.layer.borderColor =colorref;
    _rememberBtn.layer.shadowOpacity=0.8;
    _rememberBtn.layer.shadowOffset = CGSizeMake(0, 0);
    _rememberBtn.layer.shadowColor = [UIColor whiteColor].CGColor;
    [_rememberBtn addTarget:self action:@selector(_rememberBtn:) forControlEvents:UIControlEventTouchUpInside];
    _rememberBtn.top = label.top-2;
    _rememberBtn.width = _rememberBtn.height= label.height+5;
    _rememberBtn.right = label.left;
    [self.view addSubview:_rememberBtn];
    
    UIButton * enterBtn = [[UIButton alloc] init];
    [enterBtn addTarget:self action:@selector(enterBtn:) forControlEvents:UIControlEventTouchUpInside];
    enterBtn.backgroundColor = [UIColor whiteColor];
    [enterBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    enterBtn.top = _rememberBtn.bottom+60;
    enterBtn.width = KeyBview.width;
    enterBtn.height = 40;
    enterBtn.centerX  = KeyBview.centerX;
    enterBtn.layer.cornerRadius = 5;
    enterBtn.titleLabel.font = [UIFont boldSystemFontOfSize:19];
    [enterBtn setTitle:@"登入" forState:UIControlStateNormal];
    
    [self.view addSubview:enterBtn];
    
}
- (void)_rememberBtn:(UIButton*)button{
    button.selected = !button.selected;
}
- (void)enterBtn:(UIButton*)button{

    //account = @"sh_jtj";   key = @"Sh12345";

    [[NSUserDefaults standardUserDefaults] setObject:_accountField.text forKey:userName];
    if (_rememberBtn.selected == YES) {
        [[NSUserDefaults standardUserDefaults] setObject:_keyField.text forKey:userKey];
        [[NSUserDefaults standardUserDefaults] setObject:@"conserve" forKey:@"whetherSave"];
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:@"no" forKey:@"whetherSave"];
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:userKey];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [TYSProgressHUD show];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    NSString *string = [[[NSDate alloc] init] dateToStringWithFormater:@"yyyyMMddHHmmss"];
    NSString*randomNum = [NSString stringWithFormat:@"%ld",random()%1000000];
    NSString *account = _accountField.text;
    NSString *key = _keyField.text;

    NSString *signName =[NSString stringWithFormat:@"username=%@&pwd=%@&key=123456",_accountField.text,_keyField.text];
    NSString *signMD5 = [signName MD5];
    NSLog(@"signMD5 =%@",signMD5);
    dict[@"transactionId"] = [NSString stringWithFormat:@"200002001%@%@",string,randomNum];
    dict[@"channelCode"] = @"UC2002001";
    dict[@"username"] = account;
    dict[@"pwd"] = key;
    dict[@"sign"] = signMD5;

    
    [manager POST:@"http://101.95.48.92:8004/clientuni/services/userStatistic/clientLogin" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSLog(@"%@",responseObject);
            if ([responseObject[@"resCode"] isEqualToString:@"200"]) {
                [TYSProgressHUD dismissSuccessWith:@"登陆成功"];
                [self presentViewController:[[UINavigationController alloc] initWithRootViewController:[[DetailViewController alloc] init]] animated:YES completion:nil];
            }else if ([responseObject[@"resCode"] isEqualToString:@"2001"]){
                [TYSProgressHUD dismessFailWith:@"用户名或密码不正确"];
            }else if ([responseObject[@"resCode"] isEqualToString:@"2003"]){
                [TYSProgressHUD dismessFailWith:@"该用户权限不足"];
            }else{
                [TYSProgressHUD dismessFailWith:@"登陆失败"];
            }
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error = %@",error);
        [TYSProgressHUD dismessFailWith:@"网络连接失败"];
    }];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_accountField resignFirstResponder];
    [_keyField resignFirstResponder];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
