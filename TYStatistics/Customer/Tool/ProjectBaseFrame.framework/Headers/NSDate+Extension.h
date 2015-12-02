//
//  NSDate+Extension.h
//  TestTestFramework
//
//  Created by JoshShron on 15-1-30.
//  Copyright (c) 2015年 . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

- (NSDateComponents *)compoents;

+ (NSDate *)stringToDate:(NSString *)string;
- (NSString *)dateToStringWithFormater:(NSString *)formatter;
- (NSString *)year;
- (NSString *)month;
- (NSString *)day;
- (NSString *)hour;
- (NSString *)minute;
- (NSString *)second;
- (NSInteger)dayOfMonth;
- (NSString *)weekday;
- (NSDate *)agoWithDays:(NSInteger)day;
- (NSDate *)laterWithDays:(NSInteger)day;
- (NSDate *)startDate;
- (NSDate *)endDate;
- (NSDictionary *)monthFromStartDate:(NSDate *)startDate;
- (NSDate *)dateFromYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day animation:(BOOL)animation;

@end
