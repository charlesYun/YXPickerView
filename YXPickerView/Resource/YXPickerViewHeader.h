//
//  YXPickerViewHeader.h
//  demo
//
//  Created by 曹云霄 on 2019/8/8.
//  Copyright © 2019 曹云霄. All rights reserved.
//

#ifndef YXPickerViewHeader_h
#define YXPickerViewHeader_h
#import "NSDate+YXCategory.h"

typedef void(^CancelBlock)(void);
typedef void(^DateConfirmBlock)(NSString *dateStr, NSDate *date);
typedef void(^ClickBlock)(NSInteger index);

#define kYXPickerManager [YXPickerManager shareManager]
#define kScreenHeight   ([UIScreen mainScreen].bounds.size.height)
#define kScreenWidth    ([UIScreen mainScreen].bounds.size.width)
#define kToolbarRect    CGRectMake(0, 0, kScreenWidth, 44)
#define kYXPickerRect   CGRectMake(0, kToolbarRect.size.height, kScreenWidth, 216)
#define kLineColor      [UIColor colorWithRed:0.804  green:0.804  blue:0.804 alpha:0.5]
#define kClickBgColor   [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:0.9]
#define kRowHeight      55
#define kHeaderSectionH 7

#define kIPhoneXAll ([[UIApplication sharedApplication] statusBarFrame].size.height == 44)
#define kIPHONEX_INDICATOR_HEIGHT 34
#define kIPHONE_BOTTOMSAFEAREA kIPhoneXAll ? kIPHONEX_INDICATOR_HEIGHT : 0


#endif /* YXPickerViewHeader_h */














