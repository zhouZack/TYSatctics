//
//  DetailViewController.m
//  TYStatistics
//
//  Created by Zc_zhou on 15/11/16.
//  Copyright © 2015年 Josh.Shron. All rights reserved.
//

#import "DetailViewController.h"
#import "DTButton.h"
#import "UserDetailViewController.h"
#import "HuanGoAccountController.h"
#import "ResponseSpeedController.h"

@interface DetailViewController ()<UIScrollViewDelegate>
@property (nonatomic ,strong)UIScrollView *scrollView;
@property (nonatomic ,strong)UIPageControl *pageControl;


@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"top_bg"]]];
    [self reloadView];
}
- (void)reloadView
{
    UIView*titleView = [[UIView alloc] init];
    titleView.size = CGSizeMake(150, 44);
    titleView.backgroundColor = [UIColor clearColor];
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 30, 30)];
    imageView.image = [UIImage imageNamed:@"icon_title"];
    [titleView addSubview:imageView];
    UILabel *label = [[UILabel alloc] init];
    label.text = @"天翼客服";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:19];
    label.size = CGSizeMake(100, 44);
    label.right = 145;
    [titleView addSubview:label];
    self.navigationItem.titleView = titleView;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, (UIScreenHeight-64)/3)];
    _scrollView.delegate  = self;
    _scrollView.contentSize = CGSizeMake(UIScreenWidth*2, 0);
    _scrollView.showsVerticalScrollIndicator = _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    NSArray*imageArray = @[@"banner",@"banner_2"];
    for (int i = 0; i<imageArray.count; i++) {
        UIImageView*imageView = [[UIImageView alloc] init];
        imageView.size = _scrollView.size;
        imageView.left = i*UIScreenWidth;
        imageView.image = [UIImage imageNamed:imageArray[i]];
        [_scrollView addSubview:imageView];
    }
    [self.view addSubview:_scrollView];
    
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.width = UIScreenWidth/6;
    _pageControl.height = 20;
    _pageControl.right = UIScreenWidth;
    _pageControl.bottom = _scrollView.height;
    _pageControl.numberOfPages = 2;
    _pageControl.pageIndicatorTintColor=[UIColor blackColor];
    _pageControl.currentPageIndicatorTintColor=[UIColor whiteColor];
    _pageControl.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gray_bg"]];
    [self.view addSubview:_pageControl];
    
    UIView *detailView = [[UIView alloc] initWithFrame:CGRectMake(3, _scrollView.bottom+3, UIScreenWidth-6, UIScreenHeight/2)];
    detailView.backgroundColor = [[UIColor cyanColor] colorWithAlphaComponent:0.3];
    NSArray*DownImage = @[@"icon_6",@"icon_1",@"icon_2",@"icon_3",@"icon_4",@"icon_5"];
    NSArray*titleArray = @[@"欢GO统计",@"用户发展",@"用户服务",@"栏目动态",@"热门活动",@"响应测速"];
    for (int i = 0; i<DownImage.count; i++) {
        NSInteger viewRow = i%3;
        NSInteger viewSection = i/3;
        CGFloat width = detailView.width/3;
        CGFloat height = detailView.height/2;
        DTButton * button = [[DTButton alloc] initWithFrame:CGRectMake(viewRow*width, viewSection*height, width, height)];
        [button setImage:[[UIImage imageNamed:DownImage[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
        [detailView addSubview:button];
        
    }
    [self.view addSubview:detailView];
    
                                                                 
}
- (void)btnclick:(UIButton*)btn{
    NSLog(@"%@",btn.titleLabel.text);
    if ([btn.titleLabel.text isEqualToString:@"用户发展"]||[btn.titleLabel.text isEqualToString:@"用户服务"]||[btn.titleLabel.text isEqualToString:@"栏目动态"]||[btn.titleLabel.text isEqualToString:@"热门活动"])
    {
        
        UserDetailViewController *user = [[UserDetailViewController alloc] init];
        if ([btn.titleLabel.text isEqualToString:@"用户服务"]) {
            user.integer = 2;
            user.kpiType = @"1";
            user.fromWhere = @"用户服务";
        }else if ([btn.titleLabel.text isEqualToString:@"热门活动"]){
            user.integer = 0;
            user.fromWhere = @"热门活动";
        }else if ([btn.titleLabel.text isEqualToString:@"栏目动态"]){
            user.integer = 0;
            user.fromWhere = @"栏目动态";
        }
        else{
            user.integer = 4;
        }
        user.titleText = btn.titleLabel.text;
        [self.navigationController pushViewController:user animated:YES];
    }
    if ([btn.titleLabel.text isEqualToString:@"欢GO统计"]) {
        [self.navigationController pushViewController:[[HuanGoAccountController alloc]init] animated:YES];
    }
    if ([btn.titleLabel.text isEqualToString:@"响应测速"]) {
        [self.navigationController pushViewController:[[ResponseSpeedController alloc] init] animated:YES];
    }
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int page = scrollView.contentOffset.x/scrollView.width+0.5;
    _pageControl.currentPage = page;
 
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
