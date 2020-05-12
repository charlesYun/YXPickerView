//
//  YXToolbar.h
//  YXPickerView
//
//  Created by 曹云霄 on 2017/7/14.
//  Copyright © 2017年 曹云霄. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXPickerManager.h"

@interface YXToolbar : UIToolbar

/**
 取消回调
 */
@property (nonatomic,copy) void(^cancelBlock)();

/**
 确认回调
 */
@property (nonatomic,copy) void(^confirmBlock)();


@end
