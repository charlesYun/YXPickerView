//
//  YXPickerManager.m
//  YXPickerView
//
//  Created by 曹云霄 on 2017/7/14.
//  Copyright © 2017年 曹云霄. All rights reserved.
//

#import "YXPickerManager.h"

@implementation YXPickerManager

+ (YXPickerManager *)shareManager
{
    static YXPickerManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[YXPickerManager alloc] init];
    });
    return manager;
}

- (YXAddressPickerView *)addressPickerView
{
    if (!_addressPickerView) {
        _addressPickerView = [[YXAddressPickerView alloc] init];
    }
    return _addressPickerView;
}

- (YXDatePickerView *)datePickerView
{
    if (!_datePickerView) {
        _datePickerView = [[YXDatePickerView alloc] init];
    }
    return _datePickerView;
}



- (void)showAddressPickerView:(UIColor *)tintColor defaultAddress:(NSString *)address commitBlock:(void (^)(NSString *, NSString *))commitBlock cancelBlock:(void (^)())cancelBlock
{
    [self.addressPickerView showAddressPickerView:tintColor defaultAddress:address commitBlock:^(NSString *address, NSString *zipcode) {
        commitBlock(address,zipcode);
    } cancelBlock:^{
        cancelBlock();
    }];
}


- (void)showDatePickerView:(UIColor *)tintColor datePickerModel:(UIDatePickerMode)model minimumDate:(NSDate *)minimumDate maximumDate:(NSDate *)maximumDate defaultDate:(NSString *)dateString commitBlock:(void (^)(NSString *))commitBlock cancelBlock:(void (^)())cancelBlock
{
    [self.datePickerView showDatePickerView:tintColor datePickerModel:model minimumDate:minimumDate maximumDate:maximumDate defaultDate:dateString commitBlock:^(NSString *date) {
        commitBlock(date);
    } cancelBlock:^{
        cancelBlock();
    }];
}










@end
