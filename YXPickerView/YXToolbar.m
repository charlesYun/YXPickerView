//
//  YXToolbar.m
//  YXPickerView
//
//  Created by 曹云霄 on 2017/7/14.
//  Copyright © 2017年 曹云霄. All rights reserved.
//


#import "YXToolbar.h"



@implementation YXToolbar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIBarButtonItem *leftFixBar = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
        leftFixBar.width = 15;
        UIBarButtonItem *rightFixBar = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
        rightFixBar.width = 15;
        UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        self.titleButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"请选择" style:UIBarButtonItemStyleDone target:self action:nil];
        self.titleButtonItem.enabled = NO;
        [self.titleButtonItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15],
                                                NSForegroundColorAttributeName : [UIColor lightGrayColor]} forState:UIControlStateNormal];
        self.cancelButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelButtonClickAction)];
        self.commitButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确认" style:UIBarButtonItemStyleDone target:self action:@selector(commitButtonClickAction)];
        self.items = @[leftFixBar,self.cancelButtonItem,spaceItem,self.titleButtonItem,spaceItem,self.commitButtonItem,rightFixBar];
        self.tintColor = [UIColor redColor];
        UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 43.5, WIDTH, 0.5)];
        bottomLineView.backgroundColor = COLOR;
        [self addSubview:bottomLineView];
        [self bringSubviewToFront:bottomLineView];
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    if (self.titleButtonItem) {
        self.titleButtonItem.title = title;
    }
}

- (void)setTitleColor:(UIColor *)titleColor
{
    if (self.titleButtonItem) {
        self.titleButtonItem.tintColor = titleColor;
    }
}

- (void)setToolBarTintColor:(UIColor *)toolBarTintColor
{
    self.tintColor = toolBarTintColor;
}

- (void)setCancelTitle:(NSString *)cancelTitle
{
    if (self.cancelButtonItem) {
        self.cancelButtonItem.title = cancelTitle;
    }
}

- (void)setCancelTitleColor:(UIColor *)cancelTitleColor
{
    if (self.cancelButtonItem) {
        self.cancelButtonItem.tintColor = cancelTitleColor;
    }
}

- (void)setCommitTitle:(NSString *)commitTitle
{
    if (self.commitButtonItem) {
        self.commitButtonItem.title = commitTitle;
    }
}

- (void)setCommitTitleColor:(UIColor *)commitTitleColor
{
    if (self.commitButtonItem) {
        self.commitButtonItem.tintColor = commitTitleColor;
    }
}

- (void)cancelButtonClickAction
{
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

- (void)commitButtonClickAction
{
    if (self.commitBlock) {
        self.commitBlock();
    }
}




@end
