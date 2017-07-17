//
//  YXPickerManager.h
//  YXPickerView
//
//  Created by 曹云霄 on 2017/7/14.
//  Copyright © 2017年 曹云霄. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YXPickerView.h"

@interface YXPickerManager : NSObject

+ (YXPickerManager *)shareManager;

@property (nonatomic, strong) YXPickerView *addressPickerView;


/**
 显示省市区选择框
 
 @param tintColor    主题颜色
 @param address      默认地址
 @param commitBlock  确认回调
 @param cancelBlock  取消回调
 */
- (void)showAddressPickerView:(UIColor *)tintColor defaultAddress:(NSString *)address commitBlock:(void(^)(NSString *address,NSString *zipcode))commitBlock cancelBlock:(void(^)())cancelBlock;

@end
