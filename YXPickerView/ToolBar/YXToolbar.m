//
//  YXToolbar.m
//  YXPickerView
//
//  Created by 曹云霄 on 2017/7/14.
//  Copyright © 2017年 曹云霄. All rights reserved.
//


#import "YXToolbar.h"

@interface YXToolbar()

@property (nonatomic, strong) UIBarButtonItem *cancelButtonItem;
@property (nonatomic, strong) UIBarButtonItem *commitButtonItem;
@property (nonatomic, strong) UIBarButtonItem *titleButtonItem;

@end

@implementation YXToolbar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        UIBarButtonItem *leftFixBar = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
        leftFixBar.width = 15;
        
        UIBarButtonItem *rightFixBar = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
        rightFixBar.width = 15;
        
        UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textColor = [YXPickerManager shareManager].titleColor;
        titleLabel.text = [YXPickerManager shareManager].title;
        _titleButtonItem = [[UIBarButtonItem alloc] initWithCustomView:titleLabel];

        _cancelButtonItem = [[UIBarButtonItem alloc] initWithTitle:[YXPickerManager shareManager].cancelStr ?: @"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelButtonClickAction)];
        _cancelButtonItem.tintColor = [YXPickerManager shareManager].cancelColor;
        
        _commitButtonItem = [[UIBarButtonItem alloc] initWithTitle:[YXPickerManager shareManager].confirmStr ?: @"确认" style:UIBarButtonItemStyleDone target:self action:@selector(commitButtonClickAction)];
        _commitButtonItem.tintColor = [YXPickerManager shareManager].confirmColor;

        self.items = @[leftFixBar,self.cancelButtonItem,spaceItem,self.titleButtonItem,spaceItem,self.commitButtonItem,rightFixBar];
        
        if (![YXPickerManager shareManager].lineHide) {
            UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, kToolbarRect.size.height - 0.5, kScreenWidth, 0.5)];
            bottomLineView.backgroundColor = [YXPickerManager shareManager].lineColor ?: kLineColor;
            [self addSubview:bottomLineView];
            [self bringSubviewToFront:bottomLineView];
        }
    }
    return self;
}

- (void)cancelButtonClickAction {
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

- (void)commitButtonClickAction {
    if (self.confirmBlock) {
        self.confirmBlock();
    }
}




@end
