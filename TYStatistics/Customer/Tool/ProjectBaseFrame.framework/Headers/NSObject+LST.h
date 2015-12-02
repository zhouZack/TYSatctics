//
//  NSObject+LST.h
//  LiftStyle
//
//  Created by JoshShron on 14-11-18.
//  Copyright (c) 2014年 JoshShron. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIScrollView+MJRefresh.h"

@interface NSObject (LST)

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary dictionAryay:(NSDictionary *)keys toObject:(BOOL)toObject;

- (void)saveWithFileName:(NSString *)name;

+ (id)fileWithFileName:(NSString *)name;

+ (NSString *)pathWithName:(NSString *)name;

//字典转对象
- (void) dictionaryToEntity:(NSDictionary *)dict;

//字典转对象
- (void)dictionaryToEntity:(NSDictionary *)dict keys:(NSDictionary *)keys;

- (NSDictionary *)entityToDictionaryWithKeyDic:(NSDictionary *)keyDic;

//对象转字典
- (NSDictionary *) entityToDictionary;

//获取对象属性名
- (NSArray *)getAllProperties;

#pragma mark - showLoading

- (void)showLoading;
- (void)showLoadingWithText:(NSString *)text;
- (void)hideLoading;
- (void)showWithSuccess:(NSString *)success;
- (void)showWithSuccess:(NSString *)success afterTimer:(NSTimeInterval)time;
- (void)showWithError:(NSString *)error;
- (void)showWithError:(NSString *)error afterTimer:(NSTimeInterval)time;
#pragma mark - RefreashView
- (void)createTheRefreshWithTableList:(UITableView *)tableView headerType:(NSInteger)headerType beginRefreash:(NSInteger)beginRefreash blockTask:(void (^)(BOOL isRefresh))blockTask;
- (void)hiddentRefreash;

@end


@interface NSString (JSONKit)

- (id)objectFromJSONString;

@end

@interface NSObject (JSONKit)

- (NSString *)JSONResult;

@end

