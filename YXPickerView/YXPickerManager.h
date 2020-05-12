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
#import "YXAddressPickerView.h"
#import "YXDatePickerView.h"
#import "YXCustomPickerView.h"
#import "YXActionSheetViewController.h"
#import "YXCustomController.h"

@interface YXPickerManager : NSObject

@property (nonatomic, strong) YXAddressPickerView *addressPickerView;
@property (nonatomic, strong) YXDatePickerView *datePickerView;
@property (nonatomic, strong) YXCustomPickerView *customPickerView;
@property (nonatomic, strong) YXActionSheetViewController *actionSheetView;
@property (nonatomic, strong) YXCustomController *customView;

/***************************可自定义属性***************************/

//取消按钮文字颜色
@property (nonatomic, strong) UIColor *cancelColor;
//取消按钮文字
@property (nonatomic, copy) NSString *cancelStr;
//ToolBars标题
@property (nonatomic, copy) NSString *title;
//ToolBars标题颜色
@property (nonatomic, strong) UIColor *titleColor;
//ToolBar标题是否隐藏
@property (nonatomic, assign) BOOL titleHide;
//ToolBar下方线条颜色
@property (nonatomic, strong) UIColor *lineColor;
//ToolBar下方线条隐藏
@property (nonatomic, assign) BOOL lineHide;
//确认按钮文字颜色
@property (nonatomic, strong) UIColor *confirmColor;
//确认按钮文字
@property (nonatomic, copy) NSString *confirmStr;
//语言
@property (nonatomic, strong) NSLocale *locale;


/**
 单例模式

 @return YXPickerManager
 */
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
 显示时间选择框（UIDatePickerModeCountDownTimer）
 
 @param minimumDate  最小时间
 @param maximumDate  最大时间
 @param defaultDate  默认时间
 @param confirm      确认回调
 @param cancel       取消回调
 */
- (void)showTimerPickerViewMinimumDate:(NSDate *)minimumDate maximumDate:(NSDate *)maximumDate defaultDate:(NSString *)defaultDate confirm:(DateConfirmBlock)confirm cancel:(CancelBlock)cancel;

/**
 仿微信弹出框
 
 @param array YXActionSheetModel list
 */
- (void)showActionSheetView:(NSArray<YXActionSheetModel *> *)array;

/**
 仿微信弹出框

 @param array YXActionSheetModel list
 @param title 标题
 */
- (void)showActionSheetView:(NSArray<YXActionSheetModel *> *)array title:(NSString *)title;

/**
 自定义弹出框（UIView）

 @param view UIView
 @param cancel cancel
 */
- (void)showCustomView:(UIView *)view cancel:(CancelBlock)cancel;

/**
 自定义弹出框（UIViewController）

 @param controller UIViewController
 @param height UIViewController 高度
 @param cancel cancel
 */
- (void)showCustomVc:(UIViewController *)controller contentHeight:(CGFloat)height cancel:(CancelBlock)cancel;


/// 隐藏弹出框
- (void)hiddenWithAnimation;


@end
