//
//  YXDatePickerView.h
//  demo
//
//  Created by 曹云霄 on 2017/7/17.
//  Copyright © 2017年 曹云霄. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXPickerViewHeader.h"

@interface YXDatePickerView : UIDatePicker

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

- (void)hiddenWithAnimation;

@end
