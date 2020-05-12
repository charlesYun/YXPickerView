//
//  YXActionSheetViewController.h
//  demo
//
//  Created by 曹云霄 on 2019/8/12.
//  Copyright © 2019 曹云霄. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXActionSheetModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YXActionSheetViewController : UIViewController


- (void)showActionSheetView:(NSArray<YXActionSheetModel *> *)array title:(NSString *)title cancel:(CancelBlock)cancel;
- (void)hiddenWithAnimation;
@end

NS_ASSUME_NONNULL_END
