//
//  NSDate+YXCategory.h
//  demo
//
//  Created by 曹云霄 on 2019/8/8.
//  Copyright © 2019 曹云霄. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface NSDate (YXCategory)


/***********内部对部分异常字符串做了处理***********/

+ (NSDate *)dateFormatyyyyMMddHHmmss:(NSString *)dateStr;
+ (NSDate *)dateFormatyyyyMMdd:(NSString *)dateStr;
+ (NSDate *)dateFormatHHmmss:(NSString *)dateStr;

/***********内部对部分异常字符串做了处理***********/



+ (NSString *)strFormatyyyyMMddHHmmss:(NSDate *)date;
+ (NSString *)strFormatyyyyMMdd:(NSDate *)date;
+ (NSString *)strFormatHHmmss:(NSDate *)date;


@end

