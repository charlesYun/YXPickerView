//
//  YXActionSheetTableViewCell.m
//  demo
//
//  Created by 曹云霄 on 2019/8/12.
//  Copyright © 2019 曹云霄. All rights reserved.
//

#import "YXActionSheetTableViewCell.h"
#import "UIButton+Category.h"


@interface YXActionSheetTableViewCell()

@property (nonatomic, strong) UIButton *button;

@end

@implementation YXActionSheetTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectedBackgroundView = [UIView new];
        self.selectedBackgroundView.backgroundColor = kClickBgColor;
        _button = [UIButton buttonWithType:UIButtonTypeSystem];
        _button.enabled = NO;
        _button.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [_button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_button horizontalCenterImageAndTitle:10];
        _button.frame = CGRectMake(0, 0, kScreenWidth, kRowHeight);
        [self.contentView addSubview:_button];
    }
    return self;
}

- (void)updateActionModel:(YXActionSheetModel *)model {
    [self.button setTitle:model.title forState:UIControlStateNormal];
    [self.button setTitleColor:model.color forState:UIControlStateNormal];
    if (model.iconName) {
        [self.button setImage:[UIImage imageNamed:model.iconName] forState:UIControlStateNormal];
    }
    self.accessoryType = model.isSelected ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
}

@end
