//
//  ProgressHUD.h
//  TYStatistics
//
//  Created by Zc_zhou on 15/11/25.
//  Copyright © 2015年 Josh.Shron. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TYSProgressHUD : UIView


+(void)show;
+(void)dismissSuccessWith:(NSString*)str;
+(void)dismessFailWith:(NSString*)str;

@end
