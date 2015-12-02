//
//  HttpTool.m
//  TYStatistics
//
//  Created by Zc_zhou on 15/11/20.
//  Copyright © 2015年 Josh.Shron. All rights reserved.
//

#import "HttpTool.h"
#import "Util.h"

@implementation HttpTool
//+(void)requestForTheTokenNewWithToken:(NSDictionary*)theNeededParameters  result:(TokenIsReady)theResoult {
//    
//    NSMutableString *mobleStr = theNeededParameters[@"Mobile"]?theNeededParameters[@"Mobile"]:@"";
//    NSString *desMobileStr = [DES3Util encrypt:(NSString*)mobleStr];
//    NSString *apnStr = @"";
//    NSString *brandStr = @"Apple";
//    NSString *mobileTypeStr = [Util platformString];
//    NSString *osTypeStr = @"iOS";
//    NSString *clientTypeStr = [UserHelper shareSingleton].AppChannel;
//    NSDate *date = [NSDate date];
//    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
//    [dateFormat setDateFormat:@"yyyyMMddHHmmssSSS"];
//    NSString *reqTimeStr =[dateFormat stringFromDate:date];
//    
//    NSString *versionStr = @"1.0.2";
//    // NSString *goVersionStr = @"1.0";//需要传来的
//    NSString *goVersionStr = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
//    NSString *imeiStr = @"";
//    NSString *signStartStr = [NSString stringWithFormat:@"mobileType=%@&osType=%@&clientType=%@&key=huango135790",mobileTypeStr,osTypeStr,clientTypeStr];
//    
//    NSString *signLastStr = [[Util md5:signStartStr]lowercaseString ];
//    
//    NSDictionary *paramsDic =@{@"mobile":desMobileStr,
//                               @"apn":apnStr,
//                               @"brand":brandStr,
//                               @"mobileType":mobileTypeStr,
//                               @"osType":osTypeStr,
//                               @"clientType":clientTypeStr,
//                               @"reqTime":reqTimeStr,
//                               @"version":versionStr,
//                               @"goVersion":goVersionStr,
//                               @"imei":imeiStr,
//                               @"sign":signLastStr
//                               };
//    
//    [HttpTool postWithPath:@"/clientuni/services/user/oauth"
//                    params:paramsDic
//                isReqParam:YES
//                   success:^(id json){
//                       NSDictionary *dic = json;
//                       
//                       
//                       if ([[dic objectForKey:@"resCode"]integerValue ]==200) {
//                           //保存：
//                           NSString *token = [dic objectForKey:@"token"];
//                           if (token == nil || ![token isKindOfClass:[NSString class]]) {
//                               token = @"";
//                           }
//                           [UserHelper shareSingleton].token = token;
//                           [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"token"] forKey:kLoggedInfo_Token];
//                           
//                           NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
//                           [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//                           NSString *saveDateString = [dateFormat stringFromDate:[NSDate date]];
//                           
//                           [[NSUserDefaults standardUserDefaults] setObject:saveDateString forKey:kLoggedInfo_Time];
//                           NSString *province = [dic objectForKey:@"province"];
//                           [UserHelper shareSingleton].province = province;
//                           [[NSUserDefaults standardUserDefaults] setObject:province
//                                                                     forKey:kLoggedInfo_Province];
//                           NSString *city = [dic objectForKey:@"city"];
//                           [UserHelper shareSingleton].city = city;
//                           [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"city"]
//                                                                     forKey:kLoggedInfo_City];
//                           [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"area"]
//                                                                     forKey:kLoggedInfo_Area];
//                           
//                           [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"areaCode"]
//                                                                     forKey:kLoggedInfo_AreaCode];
//                           
//                           [[NSUserDefaults standardUserDefaults] synchronize];
//                           theResoult(YES);
//                       }else{
//                           theResoult(NO);
//                       }
//                       
//                       
//                   }
//                   failure:^(NSError *error){
//                       
//                       theResoult(NO);
//                       
//                   }];
//    
//    
//}

@end
