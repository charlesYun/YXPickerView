//
//  YXCustomTableViewCell.h
//  demo
//
//  Created by 曹云霄 on 2020/5/12.
//  Copyright © 2020 曹云霄. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXActionSheetModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface YXCustomTableViewCell : UITableViewCell

- (void)updateActionModel:(YXActionSheetModel *)model;
@end

NS_ASSUME_NONNULL_END
