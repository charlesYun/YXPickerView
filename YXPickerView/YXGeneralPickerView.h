//
//  YXGeneralPickerView.h
//  demo
//
//  Created by 曹云霄 on 2017/9/22.
//  Copyright © 2017年 曹云霄. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXToolbar.h"

@interface YXGeneralPickerView : UIPickerView



@property (nonatomic, strong) YXToolbar *toolbar;

/**
 显示选择框
 
 @param tintColor       主题颜色
 @param defaultString   默认选中
 @param commitBlock     确认回调
 @param cancelBlock     取消回调
 */
- (void)showGeneralPickerView:(UIColor *)tintColor dataArray:(NSArray<NSString *> *)dataArray defaultString:(NSString *)defaultString commitBlock:(void (^)(NSString *selectedItem,NSInteger index))commitBlock cancelBlock:(void (^)())cancelBlock;
@end
