//
//  YXCustomController.h
//  demo
//
//  Created by 曹云霄 on 2020/5/12.
//  Copyright © 2020 曹云霄. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXPickerViewHeader.h"

@interface YXCustomController : UIViewController


- (void)showCustomView:(UIView *)view showCancel:(BOOL)showCancel cancel:(CancelBlock)cancel;
- (void)showCustomVc:(UIViewController *)controller contentHeight:(CGFloat)height showCancel:(BOOL)showCancel cancel:(CancelBlock)cancel;
- (void)hiddenWithAnimation;
@end

