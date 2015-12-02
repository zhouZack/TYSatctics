//
//  HttpRequestHelper.h
//  TYStatistics
//
//  Created by Zc_zhou on 15/11/20.
//  Copyright © 2015年 Josh.Shron. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^HttpSuccessBlock)(id JSON);
typedef void (^HttpFailureBlock)(NSError *error);

@interface HttpRequestHelper : NSObject

@end
