//
//  DataAccessHelper.m
//  AppScenicSpot
//
//  Created by GUZUQIANG on 1/8/14.
//  Copyright (c) 2014 edonesoft. All rights reserved.
//

#import "DataAccessHelper.h"

@implementation DataAccessHelper


/**
 *判断字符串是否为空
 *
 */
+ (BOOL)stringIsNullOrEmpty:(NSString *)src {
    //空对象
    if (src == nil) {
        return YES;
    }
    //长度为0
    if (src.length == 0) {
        return YES;
    }
    return NO;
}

/**
 *日期转换为毫秒数
 *
 */
+ (double)getIntervalFromDate:(NSDate *)date {
    return [date timeIntervalSince1970];
}
/**
 *日期转换为字符串格式
 *
 */
+ (NSString *)dateToString:(NSDate *)date format:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:date];
}
/**
 *毫秒数转换为字符串日期
 *
 */
+ (NSString *)dateIntervalToString:(double)interval format:(NSString *)format {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval/1000];
    return [DataAccessHelper dateToString:date format:format];
}
/**
 *秒数转换为字符串日期
 *
 */
+ (double)intervalFromDateString:(NSString *)dateString format:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:format];
    NSDate *date = [dateFormatter dateFromString:dateString];
    return [date timeIntervalSince1970];
}



+ (NSString *)maskedIDCard:(NSString *)idcard {
    if ([idcard length] < 8) {
        return idcard;
    }
    return [NSString stringWithFormat:@"%@****%@", [idcard substringToIndex:6], [idcard substringFromIndex:idcard.length-4]];
}



@end
