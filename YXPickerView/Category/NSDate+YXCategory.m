//
//  NSDate+YXCategory.m
//  demo
//
//  Created by 曹云霄 on 2019/8/8.
//  Copyright © 2019 曹云霄. All rights reserved.
//

#import "NSDate+YXCategory.h"

@implementation NSDate (YXCategory)

+ (NSString *)strFormatyyyyMMddHHmmss:(NSDate *)date {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *string = [format stringFromDate:date];
    return string;
}

+ (NSString *)strFormatyyyyMMdd:(NSDate *)date {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd";
    NSString *string = [format stringFromDate:date];
    return string;
}

+ (NSString *)strFormatHHmmss:(NSDate *)date {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"HH:mm:ss";
    NSString *string = [format stringFromDate:date];
    return string;
}

+ (NSDate *)dateFormatyyyyMMddHHmmss:(NSString *)dateStr {
    NSString *regex = @"^[0-9]{4}\\-[0-9]{2}\\-[0-9]{2}\\s[0-9]{2}\\:[0-9]{2}\\:[0-9]{2}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL result = [predicate evaluateWithObject:dateStr];
    if (!result) {
        NSRange range = [dateStr rangeOfString:regex options:NSRegularExpressionSearch];
        if (range.location != NSNotFound) {
            dateStr = [dateStr substringWithRange:range];
        }else{
            NSString *regex1 = @"^[0-9]{4}\\-[0-9]{2}\\-[0-9]{2}\\s[0-9]{2}\\:[0-9]{2}";
            NSRange range = [dateStr rangeOfString:regex1 options:NSRegularExpressionSearch];
            if (range.location != NSNotFound) {
                dateStr = [NSString stringWithFormat:@"%@:00",[dateStr substringWithRange:range]];
            }else {
                return [NSDate date];
            }
        }
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    return date;
}

+ (NSDate *)dateFormatyyyyMMdd:(NSString *)dateStr {
    NSString *regex = @"^[0-9]{4}\\-[0-9]{2}\\-[0-9]{2}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL result = [predicate evaluateWithObject:dateStr];
    if (!result) {
        NSRange range = [dateStr rangeOfString:regex options:NSRegularExpressionSearch];
        if (range.location != NSNotFound) {
            dateStr = [dateStr substringWithRange:range];
        }else{
            NSString *regex1 = @"^[0-9]{4}\\-[0-9]{2}";
            NSRange range = [dateStr rangeOfString:regex1 options:NSRegularExpressionSearch];
            if (range.location != NSNotFound) {
                dateStr = [NSString stringWithFormat:@"%@-01",[dateStr substringWithRange:range]];
            }else {
                return [NSDate date];
            }
        }
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    return date;
}

+ (NSDate *)dateFormatHHmmss:(NSString *)dateStr {
    NSString *regex = @"^[0-9]{2}\\:[0-9]{2}\\:[0-9]{2}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL result = [predicate evaluateWithObject:dateStr];
    if (!result) {
        NSRange range = [dateStr rangeOfString:regex options:NSRegularExpressionSearch];
        if (range.location != NSNotFound) {
            dateStr = [dateStr substringWithRange:range];
        }else{
            NSString *regex1 = @"^[0-9]{2}\\:[0-9]{2}";
            NSRange range = [dateStr rangeOfString:regex1 options:NSRegularExpressionSearch];
            if (range.location != NSNotFound) {
                dateStr = [NSString stringWithFormat:@"%@:00",[dateStr substringWithRange:range]];
            }else {
                return [NSDate date];
            }
        }
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    return date;
}

@end
