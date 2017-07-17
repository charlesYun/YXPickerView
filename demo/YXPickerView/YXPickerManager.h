//
//  YXPickerManager.h
//  YXPickerView
//
//  Created by 曹云霄 on 2017/7/14.
//  Copyright © 2017年 曹云霄. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YXAddressPickerView.h"
#import "YXDatePickerView.h"

@interface YXPickerManager : NSObject

+ (YXPickerManager *)shareManager;

@property (nonatomic, strong) YXAddressPickerView *addressPickerView;
@property (nonatomic, strong) YXDatePickerView *datePickerView;


/**
 显示省市区选择框
 
 @param tintColor    主题颜色
 @param address      默认地址
 @param commitBlock  确认回调
 @param cancelBlock  取消回调
 */
- (void)showAddressPickerView:(UIColor *)tintColor defaultAddress:(NSString *)address commitBlock:(void(^)(NSString *address,NSString *zipcode))commitBlock cancelBlock:(void(^)())cancelBlock;

/**
 显示时间选择框
 
 @param tintColor    主题颜色
 @param model        NSDate类型
 @param minimumDate  最小时间
 @param maximumDate  最大时间
 @param dateString   默认时间字符串
 @param commitBlock  确认回调
 @param cancelBlock  取消回调
 */
- (void)showDatePickerView:(UIColor *)tintColor datePickerModel:(UIDatePickerMode)model minimumDate:(NSDate *)minimumDate maximumDate:(NSDate *)maximumDate defaultDate:(NSString *)dateString commitBlock:(void(^)(NSString *date))commitBlock cancelBlock:(void(^)())cancelBlock;

@end
