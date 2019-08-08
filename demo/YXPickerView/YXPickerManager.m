//
//  YXPickerManager.m
//  YXPickerView
//
//  Created by 曹云霄 on 2017/7/14.
//  Copyright © 2017年 曹云霄. All rights reserved.
//

#import "YXPickerManager.h"
#import "YXAddressPickerView.h"
#import "YXDatePickerView.h"
#import "YXCustomPickerView.h"

@interface YXPickerManager()

@property (nonatomic, strong) YXAddressPickerView *addressPickerView;
@property (nonatomic, strong) YXDatePickerView *datePickerView;
@property (nonatomic, strong) YXCustomPickerView *customPickerView;

@end

@implementation YXPickerManager

+ (YXPickerManager *)shareManager {
    static YXPickerManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[YXPickerManager alloc] init];
    });
    return manager;
}

/**
 显示省市区选择框
 
 @param address      默认地址
 @param confirm      确认回调
 @param cancel       取消回调
 */
- (void)showAddressPickerViewSelected:(NSString *)address confirm:(void(^)(NSString *address,NSString *zipcode))confirm cancel:(CancelBlock)cancel {
    [self.addressPickerView showAddressPickerViewSelected:address confirm:confirm cancel:cancel];
}

/**
 显示选择框（自定义数据）
 
 @param dataArray       默认选中
 @param selectIndex     默认选中下标
 @param confirm         确认回调
 @param cancel          取消回调
 */
- (void)showCustomPickerViewDataArray:(NSArray<NSString *> *)dataArray selectIndex:(NSInteger)selectIndex confirm:(void (^)(NSString *title,NSInteger index))confirm cancel:(CancelBlock)cancel {
    [self.customPickerView showCustomPickerViewDataArray:dataArray selectIndex:selectIndex confirm:confirm cancel:cancel];
}

/**
 显示时间选择框（UIDatePickerModeDateAndTime）
 
 @param minimumDate  最小时间
 @param maximumDate  最大时间
 @param defaultDate  默认时间
 @param confirm      确认回调
 @param cancel       取消回调
 */
- (void)showDateAndTimePickerViewMinimumDate:(NSDate *)minimumDate maximumDate:(NSDate *)maximumDate defaultDate:(NSString *)defaultDate confirm:(DateConfirmBlock)confirm cancel:(CancelBlock)cancel {
    [self.datePickerView showDateAndTimePickerViewMinimumDate:minimumDate maximumDate:maximumDate defaultDate:defaultDate confirm:confirm cancel:cancel];
}

/**
 显示时间选择框（UIDatePickerModeTime）
 
 @param minimumDate  最小时间
 @param maximumDate  最大时间
 @param defaultDate  默认时间
 @param confirm      确认回调
 @param cancel       取消回调
 */
- (void)showTimePickerViewMinimumDate:(NSDate *)minimumDate maximumDate:(NSDate *)maximumDate defaultDate:(NSString *)defaultDate confirm:(DateConfirmBlock)confirm cancel:(CancelBlock)cancel {
    [self.datePickerView showTimePickerViewMinimumDate:minimumDate maximumDate:maximumDate defaultDate:defaultDate confirm:confirm cancel:cancel];
}

/**
 显示时间选择框（UIDatePickerModeDate）
 
 @param minimumDate  最小时间
 @param maximumDate  最大时间
 @param defaultDate  默认时间
 @param confirm      确认回调
 @param cancel       取消回调
 */
- (void)showDatePickerViewMinimumDate:(NSDate *)minimumDate maximumDate:(NSDate *)maximumDate defaultDate:(NSString *)defaultDate confirm:(DateConfirmBlock)confirm cancel:(CancelBlock)cancel {
    [self.datePickerView showDatePickerViewMinimumDate:minimumDate maximumDate:maximumDate defaultDate:defaultDate confirm:confirm cancel:cancel];
}

#pragma mark - lazy
- (YXAddressPickerView *)addressPickerView {
    if (!_addressPickerView) {
        _addressPickerView = [[YXAddressPickerView alloc] init];
    }
    return _addressPickerView;
}

- (YXDatePickerView *)datePickerView {
    if (!_datePickerView) {
        _datePickerView = [[YXDatePickerView alloc] init];
    }
    return _datePickerView;
}

- (YXCustomPickerView *)customPickerView {
    if (!_customPickerView) {
        _customPickerView = [[YXCustomPickerView alloc] init];
    }
    return _customPickerView;
}








@end
