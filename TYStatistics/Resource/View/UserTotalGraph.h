//
//  UserTotalGraph.h
//  TYStatistics
//
//  Created by Zc_zhou on 15/11/21.
//  Copyright © 2015年 Josh.Shron. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserTotalGraph : UIView

@property (nonatomic ,copy)void(^block)(NSString*);

@property (nonatomic ,assign)NSInteger tage;

//条形表格，市区名字，用户发展数量着三个可变的数据用以下三个数组接收
@property (nonatomic ,strong)NSArray *stripArray;
@property (nonatomic ,strong)NSArray *textArray;
@property (nonatomic ,strong)NSArray *numberArray;
@property (nonatomic ,strong)NSArray *countArray;

@end
