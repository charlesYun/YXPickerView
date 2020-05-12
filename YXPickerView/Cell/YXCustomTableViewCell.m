//
//  YXCustomTableViewCell.m
//  demo
//
//  Created by 曹云霄 on 2020/5/12.
//  Copyright © 2020 曹云霄. All rights reserved.
//

#import "YXCustomTableViewCell.h"

@implementation YXCustomTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)updateActionModel:(YXActionSheetModel *)model {
    [self.contentView addSubview:model.contentView];
    model.contentView.frame = self.contentView.bounds;
}

@end
