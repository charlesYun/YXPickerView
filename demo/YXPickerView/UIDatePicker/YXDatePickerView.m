//
//  YXDatePickerView.m
//  demo
//
//  Created by 曹云霄 on 2017/7/17.
//  Copyright © 2017年 曹云霄. All rights reserved.
//

#import "YXDatePickerView.h"
#import "YXToolbar.h"

@interface YXDatePickerView()

@property (nonatomic, strong) YXToolbar *toolbar;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, copy) CancelBlock cancelBlock;

@end

@implementation YXDatePickerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:kYXPickerRect];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        self.locale = [YXPickerManager shareManager].locale ?: locale;
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

- (void)showPickerViewDatePickerModel:(UIDatePickerMode)model minimumDate:(NSDate *)minimumDate maximumDate:(NSDate *)maximumDate defaultDate:(NSString *)defaultDate confirm:(DateConfirmBlock)confirm cancel:(CancelBlock)cancel {
    switch (model) {
        case UIDatePickerModeTime: {
            if (defaultDate) {
                self.date = [NSDate dateFormatHHmmss:defaultDate];
            }
        }
            break;
        case UIDatePickerModeDate: {
            if (defaultDate) {
                self.date = [NSDate dateFormatyyyyMMdd:defaultDate];
            }
        }
            break;
        case UIDatePickerModeDateAndTime: {
            if (defaultDate) {
                self.date = [NSDate dateFormatyyyyMMddHHmmss:defaultDate];
            }
        }
            break;
        default:
            break;
    }
    self.datePickerMode = model;
    self.minimumDate = minimumDate;
    self.maximumDate = maximumDate;
    self.cancelBlock = cancel;
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
            switch (model) {
                case UIDatePickerModeTime: {
                    confirm([NSDate strFormatHHmmss:weakSelf.date],weakSelf.date);
                }
                    break;
                case UIDatePickerModeDate: {
                    confirm([NSDate strFormatyyyyMMdd:weakSelf.date],weakSelf.date);
                }
                    break;
                case UIDatePickerModeDateAndTime: {
                    confirm([NSDate strFormatyyyyMMddHHmmss:weakSelf.date],weakSelf.date);
                }
                    break;
                default:
                    confirm([NSDate strFormatyyyyMMddHHmmss:weakSelf.date],weakSelf.date);
                    break;
            }
        }
    };
}

/**
 显示时间选择框（UIDatePickerModeDateAndTime）
 
 @param minimumDate  最小时间
 @param maximumDate  最大时间
 @param defaultDate  默认时间
 @param confirm      确认回调
 @param cancel       取消回调
 */
- (void)showDateAndTimePickerViewMinimumDate:(NSDate *)minimumDate maximumDate:(NSDate *)maximumDate defaultDate:(NSString *)defaultDate confirm:(DateConfirmBlock)confirm cancel:(CancelBlock)cancel {
    [self showPickerViewDatePickerModel:UIDatePickerModeDateAndTime minimumDate:minimumDate maximumDate:maximumDate defaultDate:defaultDate confirm:confirm cancel:cancel];
}

/**
 显示时间选择框（UIDatePickerModeTime）
 
 @param minimumDate  最小时间
 @param maximumDate  最大时间
 @param defaultDate  默认时间
 @param confirm      确认回调
 @param cancel       取消回调
 */
- (void)showTimePickerViewMinimumDate:(NSDate *)minimumDate maximumDate:(NSDate *)maximumDate defaultDate:(NSString *)defaultDate confirm:(DateConfirmBlock)confirm cancel:(CancelBlock)cancel {
    [self showPickerViewDatePickerModel:UIDatePickerModeTime minimumDate:minimumDate maximumDate:maximumDate defaultDate:defaultDate confirm:confirm cancel:cancel];
}

/**
 显示时间选择框（UIDatePickerModeDate）
 
 @param minimumDate  最小时间
 @param maximumDate  最大时间
 @param defaultDate  默认时间
 @param confirm      确认回调
 @param cancel       取消回调
 */
- (void)showDatePickerViewMinimumDate:(NSDate *)minimumDate maximumDate:(NSDate *)maximumDate defaultDate:(NSString *)defaultDate confirm:(DateConfirmBlock)confirm cancel:(CancelBlock)cancel {
    [self showPickerViewDatePickerModel:UIDatePickerModeDate minimumDate:minimumDate maximumDate:maximumDate defaultDate:defaultDate confirm:confirm cancel:cancel];
}

/**
 显示时间选择框（UIDatePickerModeCountDownTimer）
 
 @param minimumDate  最小时间
 @param maximumDate  最大时间
 @param defaultDate  默认时间
 @param confirm      确认回调
 @param cancel       取消回调
 */
- (void)showTimerPickerViewMinimumDate:(NSDate *)minimumDate maximumDate:(NSDate *)maximumDate defaultDate:(NSString *)defaultDate confirm:(DateConfirmBlock)confirm cancel:(CancelBlock)cancel {
    [self showPickerViewDatePickerModel:UIDatePickerModeCountDownTimer minimumDate:minimumDate maximumDate:maximumDate defaultDate:defaultDate confirm:confirm cancel:cancel];
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
