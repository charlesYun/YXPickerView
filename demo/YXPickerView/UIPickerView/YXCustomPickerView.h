//
//  YXCustomPickerView.h
//  demo
//
//  Created by 曹云霄 on 2017/9/22.
//  Copyright © 2017年 曹云霄. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXPickerViewHeader.h"

@interface YXCustomPickerView : UIPickerView

/**
 显示选择框（自定义数据）
 
 @param dataArray       默认选中
 @param selectIndex     默认选中下标
 @param confirm         确认回调
 @param cancel          取消回调
 */
- (void)showCustomPickerViewDataArray:(NSArray<NSString *> *)dataArray selectIndex:(NSInteger)selectIndex confirm:(void (^)(NSString *title,NSInteger index))confirm cancel:(CancelBlock)cancel;

- (void)hiddenWithAnimation;
@end
