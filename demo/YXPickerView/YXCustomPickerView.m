//
//  YXCustomPickerView.m
//  demo
//
//  Created by 曹云霄 on 2017/9/22.
//  Copyright © 2017年 曹云霄. All rights reserved.
//

#import "YXCustomPickerView.h"
#import "YXToolbar.h"

@interface YXCustomPickerView()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) YXToolbar *toolbar;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) NSArray *datasArray;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, copy) CancelBlock cancelBlock;

@end

@implementation YXCustomPickerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:kYXPickerRect];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.delegate = self;
        self.dataSource = self;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    }
    return self;
}

- (void)showWithAnimation {
    [self addViews];
    self.containerView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    CGFloat height = self.bgView.frame.size.height;
    self.bgView.center = CGPointMake(kScreenWidth / 2, kScreenHeight + height / 2);
    [UIView animateWithDuration:0.25 animations:^{
        self.bgView.center = CGPointMake(kScreenWidth / 2, kScreenHeight - height / 2);
        self.containerView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    }];
}

- (void)hiddenWithAnimation {
    CGFloat height = self.bgView.frame.size.height;
    [UIView animateWithDuration:0.25 animations:^{
        self.bgView.center = CGPointMake(kScreenWidth / 2, kScreenHeight + height / 2);
        self.containerView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    } completion:^(BOOL finished) {
        [self hiddenViews];
        if (self.cancelBlock) {
            self.cancelBlock();
        }
    }];
}

- (void)addViews {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.containerView];
    [window addSubview:self.bgView];
    [self.bgView addSubview:self.toolbar];
    [self.bgView addSubview:self];
}

- (void)hiddenViews {
    [self removeFromSuperview];
    [self.toolbar removeFromSuperview];
    [self.bgView removeFromSuperview];
    [self.containerView removeFromSuperview];
}

/**
 显示选择框（自定义数据）
 
 @param dataArray       默认选中
 @param selectIndex     默认选中下标
 @param confirm         确认回调
 @param cancel          取消回调
 */
- (void)showCustomPickerViewDataArray:(NSArray<NSString *> *)dataArray selectIndex:(NSInteger)selectIndex confirm:(void (^)(NSString *title,NSInteger index))confirm cancel:(CancelBlock)cancel {
    self.datasArray = dataArray;
    self.cancelBlock = cancel;
    [self reloadAllComponents];
    if (selectIndex >= 0 && selectIndex < dataArray.count) {
        [self selectRow:selectIndex inComponent:0 animated:NO];
    }
    [self showWithAnimation];
    __weak typeof(self) weakSelf = self;
    self.toolbar.cancelBlock = ^ {
        [weakSelf hiddenWithAnimation];
        if (cancel) {
            cancel();
        }
    };
    self.toolbar.confirmBlock = ^{
        [weakSelf hiddenWithAnimation];
        if (confirm) {
            confirm(weakSelf.datasArray[weakSelf.selectedIndex],weakSelf.selectedIndex);
        }
    };
}

#pragma mark -<UIPickerViewDelegate,UIPickerViewDataSource>
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.datasArray[row];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.datasArray.count;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selectedIndex = row;
}

#pragma mark - lazy
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - self.frame.size.height - kToolbarRect.size.height, kScreenWidth, self.frame.size.height + kToolbarRect.size.height)];
    }
    return _bgView;
}

- (YXToolbar *)toolbar {
    if (!_toolbar) {
        _toolbar = [[YXToolbar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kToolbarRect.size.height)];
        _toolbar.translucent = NO;
    }
    return _toolbar;
}

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _containerView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        _containerView.userInteractionEnabled = YES;
        [_containerView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenWithAnimation)]];
    }
    return _containerView;
}





















@end
