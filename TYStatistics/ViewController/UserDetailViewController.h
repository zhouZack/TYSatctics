//
//  UserDetailViewController.h
//  TYStatistics
//
//  Created by Zc_zhou on 15/11/17.
//  Copyright © 2015年 Josh.Shron. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserDetailViewController : UIViewController

//通过integer来判断底部应该出现几个按钮
@property (nonatomic ,assign)NSInteger integer;
//通过fromWhere来判断从那个界面跳转过来
@property (nonatomic ,strong)NSString *fromWhere;
//欢GO界面请求数据的参数
@property (nonatomic ,strong)NSString *kpiType;
@property (nonatomic ,strong)NSString *provinceGH;
@property (nonatomic ,strong)NSString *todayNumText;
@property (nonatomic ,strong)NSString *accountNUmText;
@property (nonatomic ,strong)NSString *todayAccountLabelText;
@property (nonatomic ,strong)NSString *titleText;

@end
