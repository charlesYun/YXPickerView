//
//  YXAddressPickerView.h
//  YXAddressPickerView
//
//  Created by 曹云霄 on 2017/7/14.
//  Copyright © 2017年 曹云霄. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXPickerViewHeader.h"

@interface YXAddressPickerView : UIPickerView

/**
 显示省市区选择框
 
 @param address      默认地址
 @param confirm      确认回调
 @param cancel       取消回调
 */
- (void)showAddressPickerViewSelected:(NSString *)address confirm:(void(^)(NSString *address,NSString *zipcode))confirm cancel:(CancelBlock)cancel;

- (void)hiddenWithAnimation;
@end
