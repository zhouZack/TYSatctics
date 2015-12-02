//
//  TYGlobal.h
//  TYStatistics
//
//  Created by Josh.Shron on 15/11/16.
//  Copyright © 2015年 Josh.Shron. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ProjectBaseFrame/ProjectBaseFrame.h>

#import "AFNetworking.h"
#import "ToolUtil.h"
#import "TYSProgressHUD.h"

#define UIScreenWidth [[UIScreen mainScreen] bounds].size.width
#define UIScreenHeight [[UIScreen mainScreen] bounds].size.height
//条形图的颜色代码
#define ColorArr @[[UIColor colorWithRed:108/255.0f green:121/255.0f blue:152/255.0f alpha:1],[UIColor colorWithRed:251/255.0f green:185/255.0f blue:11/255.0f alpha:1],[UIColor colorWithRed:219/255.0f green:119/255.0f blue:86/255.0f alpha:1],[UIColor colorWithRed:214/255.0f green:237/255.0f blue:253/255.0f alpha:1],[UIColor colorWithRed:248/255.0f green:153/255.0f blue:51/255.0f alpha:1]]

@interface TYGlobal : NSObject

@end
