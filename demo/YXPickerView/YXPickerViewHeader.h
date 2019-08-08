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


#define kScreenHeight   ([UIScreen mainScreen].bounds.size.height)
#define kScreenWidth    ([UIScreen mainScreen].bounds.size.width)
#define kToolbarRect    CGRectMake(0, 0, kScreenWidth, 44)
#define kYXPickerRect   CGRectMake(0, kToolbarRect.size.height, kScreenWidth, 216)
#define kLineColor      [UIColor colorWithRed:0.804  green:0.804  blue:0.804 alpha:0.5]
#endif /* YXPickerViewHeader_h */
