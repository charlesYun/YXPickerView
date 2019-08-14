//
//  YXPickerManager.h
//  YXPickerView
//
//  Created by 曹云霄 on 2017/7/14.
//  Copyright © 2017年 曹云霄. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "YXPickerViewHeader.h"
#import "YXActionSheetModel.h"


@interface YXPickerManager : NSObject

/***************************自定义***************************/

@property (nonatomic, strong) UIColor *cancelColor;
@property (nonatomic, copy) NSString *cancelStr;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, assign) BOOL titleHide;

@property (nonatomic, strong) UIColor *confirmColor;
@property (nonatomic, copy) NSString *confirmStr;

@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, assign) BOOL lineHide;

/**
 默认中文
 */
@property (nonatomic, strong) NSLocale *locale;
/***************************自定义***************************/

+ (YXPickerManager *)shareManager;

/**
 显示省市区选择框
 
 @param address      默认地址
 @param confirm      确认回调
 @param cancel       取消回调
 */
- (void)showAddressPickerViewSelected:(NSString *)address confirm:(void(^)(NSString *address,NSString *zipcode))confirm cancel:(CancelBlock)cancel;

/**
 显示选择框（自定义数据）
 
 @param dataArray       默认选中
 @param selectIndex     默认选中下标
 @param confirm         确认回调
 @param cancel          取消回调
 */
- (void)showCustomPickerViewDataArray:(NSArray<NSString *> *)dataArray selectIndex:(NSInteger)selectIndex confirm:(void (^)(NSString *title,NSInteger index))confirm cancel:(CancelBlock)cancel;

/**
 显示时间选择框（UIDatePickerModeDateAndTime）
 
 @param minimumDate  最小时间
 @param maximumDate  最大时间
 @param defaultDate  默认时间
 @param confirm      确认回调
 @param cancel       取消回调
 */
- (void)showDateAndTimePickerViewMinimumDate:(NSDate *)minimumDate maximumDate:(NSDate *)maximumDate defaultDate:(NSString *)defaultDate confirm:(DateConfirmBlock)confirm cancel:(CancelBlock)cancel;

/**
 显示时间选择框（UIDatePickerModeTime）
 
 @param minimumDate  最小时间
 @param maximumDate  最大时间
 @param defaultDate  默认时间
 @param confirm      确认回调
 @param cancel       取消回调
 */
- (void)showTimePickerViewMinimumDate:(NSDate *)minimumDate maximumDate:(NSDate *)maximumDate defaultDate:(NSString *)defaultDate confirm:(DateConfirmBlock)confirm cancel:(CancelBlock)cancel;

/**
 显示时间选择框（UIDatePickerModeDate）
 
 @param minimumDate  最小时间
 @param maximumDate  最大时间
 @param defaultDate  默认时间
 @param confirm      确认回调
 @param cancel       取消回调
 */
- (void)showDatePickerViewMinimumDate:(NSDate *)minimumDate maximumDate:(NSDate *)maximumDate defaultDate:(NSString *)defaultDate confirm:(DateConfirmBlock)confirm cancel:(CancelBlock)cancel;

/**
 仿微信弹出框

 @param array YXActionSheetModel list
 @param title 标题
 */
- (void)showActionSheetView:(NSArray<YXActionSheetModel *> *)array title:(NSString *)title;



@end
