//
//  YXCustomController.m
//  demo
//
//  Created by 曹云霄 on 2020/5/12.
//  Copyright © 2020 曹云霄. All rights reserved.
//

#import "YXCustomController.h"
#import "YXActionSheetModel.h"
#import "YXActionSheetTableViewCell.h"
#import "YXCustomTableViewCell.h"

@interface YXCustomController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, assign) CGFloat contentHeight;
@property (nonatomic, copy) CancelBlock cancelBlock;


@end

@implementation YXCustomController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden{
    return NO;
}

- (void)addViews {
    CGFloat height = (self.contentHeight ?: self.contentView.frame.size.height)  + (kIPHONE_BOTTOMSAFEAREA);
    if (height > kScreenHeight - 100 ) {
        height = kScreenHeight - 100;
    }
    self.view.frame = CGRectMake(0, kScreenHeight, kScreenWidth, height);
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:self.view.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(15, 15)];
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    self.view.layer.mask = shape;
    [self.view addSubview:self.contentView];
    [self.bgView addSubview:self.view];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.bgView];
}

- (void)hiddenViews {
    [self.view removeFromSuperview];
    [self.bgView removeFromSuperview];
}

- (void)showWithAnimation {
    [self addViews];
    [UIView animateWithDuration:0.25 animations:^{
        self.bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        CGRect frame = self.view.frame;
        frame.origin.y = kScreenHeight - self.view.frame.size.height;
        self.view.frame = frame;
    }];
}

- (void)hiddenWithAnimation {
    [UIView animateWithDuration:0.25 animations:^{
        self.bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
        CGRect frame = self.view.frame;
        frame.origin.y = kScreenHeight;
        self.view.frame = frame;
    } completion:^(BOOL finished) {
        [self hiddenViews];
        if (self.cancelBlock) {
            self.cancelBlock();
        }
    }];
}

- (void)showCustomView:(UIView *)view showCancel:(BOOL)showCancel cancel:(CancelBlock)cancel {
    YXActionSheetModel *contentModel = [YXActionSheetModel view:view];
    self.cancelBlock = cancel;
    self.contentView = view;
    [self showWithAnimation];
}

- (void)showCustomVc:(UIViewController *)controller contentHeight:(CGFloat)height showCancel:(BOOL)showCancel cancel:(CancelBlock)cancel {
    YXActionSheetModel *contentModel = [YXActionSheetModel view:controller.view];
    [self addChildViewController:controller];
    self.cancelBlock = cancel;
    self.contentView = controller.view;
    self.contentHeight = height;
    [self showWithAnimation];
}

#pragma mark - UITapGestureRecognizer相关
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isDescendantOfView:self.view]) {
        return NO;
    }
    return YES;
}

#pragma mark - lazy
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenWithAnimation)];
        tap.delegate = self;
        [_bgView addGestureRecognizer:tap];
    }
    return _bgView;
}

@end
