//
//  YXActionSheetModel.h
//  demo
//
//  Created by 曹云霄 on 2019/8/12.
//  Copyright © 2019 曹云霄. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXPickerViewHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface YXActionSheetModel : NSObject

+ (instancetype)title:(NSString *)title color:(UIColor *)color;
+ (instancetype)title:(NSString *)title color:(UIColor *)color icon:(NSString *)icon;
+ (instancetype)view:(UIView *)view;

/**
 文字
 */
@property (nonatomic, copy) NSString *title;

/**
 文字颜色
 */
@property (nonatomic, copy) UIColor *color;

/**
 图片名称
 */
@property (nonatomic, copy) NSString *iconName;

/**
 是否选中
 */
@property (nonatomic, assign) BOOL isSelected;

/**
 content view
*/
@property (nonatomic, strong) UIView *contentView;

/**
 点击回调
 */
@property (nonatomic, copy) ClickBlock clickBlock;

@end

NS_ASSUME_NONNULL_END
