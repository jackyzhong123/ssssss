//
//  DataAccessHelper.h
//  AppScenicSpot
//
//  Created by GUZUQIANG on 1/8/14.
//  Copyright (c) 2014 edonesoft. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DataAccessHelper : NSObject


+ (BOOL)stringIsNullOrEmpty:(NSString *)src;


+ (double)getIntervalFromDate:(NSDate *)date;

+ (NSString *)dateIntervalToString:(double)interval format:(NSString *)format;

+ (NSString *)dateToString:(NSDate *)date format:(NSString *)format;

+ (double)intervalFromDateString:(NSString *)dateString format:(NSString *)format;

+ (NSString *)maskedIDCard:(NSString *)idcard;


@end

