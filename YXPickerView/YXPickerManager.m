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

- (YXPickerView *)addressPickerView
{
    if (!_addressPickerView) {
        _addressPickerView = [[YXPickerView alloc] init];
    }
    return _addressPickerView;
}


- (void)showAddressPickerView:(UIColor *)tintColor defaultAddress:(NSString *)address commitBlock:(void (^)(NSString *, NSString *))commitBlock cancelBlock:(void (^)())cancelBlock
{
    [self.addressPickerView showAddressPickerView:tintColor defaultAddress:address commitBlock:^(NSString *address, NSString *zipcode) {
        commitBlock(address,zipcode);
    } cancelBlock:^{
        cancelBlock();
    }];
}














@end
