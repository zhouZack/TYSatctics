//
//  HttpTool.h
//  TYStatistics
//
//  Created by Zc_zhou on 15/11/20.
//  Copyright © 2015年 Josh.Shron. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpTool : NSObject
typedef void (^TokenIsReady)(BOOL tokenBool);

//请求新的token
+(void)requestForTheTokenNewWithToken:(NSDictionary*)theNeededParameters  result:(TokenIsReady)theResoult;

@end
