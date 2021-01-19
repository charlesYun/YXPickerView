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

@interface YXCustomController ()<UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *actionTableView;
@property (nonatomic, strong) NSMutableArray <NSArray<YXActionSheetModel *> *>*datasArray;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, assign) CGFloat contentHeight;
@property (nonatomic, copy) CancelBlock cancelBlock;


@end

@implementation YXCustomController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden{
    return NO;
}

- (void)addViews {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.bgView];
    CGFloat height = (self.contentHeight ?: self.contentView.frame.size.height) + (self.cancelBlock ? kRowHeight : 0) + (kIPHONE_BOTTOMSAFEAREA);
    if (height > kScreenHeight - 100 ) {
        height = kScreenHeight - 100;
        _actionTableView.scrollEnabled = YES;
    }else {
        _actionTableView.scrollEnabled = NO ;
    }
    self.view.frame = CGRectMake(0, kScreenHeight, kScreenWidth, height);
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:self.view.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(15, 15)];
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    self.view.layer.mask = shape;
    [self.bgView addSubview:self.view];
}

- (void)hiddenViews {
    [self.view removeFromSuperview];
    [self.bgView removeFromSuperview];
    [self.datasArray removeAllObjects];
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
    [self.datasArray addObject:@[contentModel]];
    if (showCancel) {
        YXActionSheetModel *cancelModel = [YXActionSheetModel title:@"取消" color:[UIColor blackColor]];
        [self.datasArray addObject:@[cancelModel]];
    }
    self.cancelBlock = cancel;
    self.contentView = view;
    [self showWithAnimation];
    [self.actionTableView reloadData];
}

- (void)showCustomVc:(UIViewController *)controller contentHeight:(CGFloat)height showCancel:(BOOL)showCancel cancel:(CancelBlock)cancel {
    YXActionSheetModel *contentModel = [YXActionSheetModel view:controller.view];
    [self.datasArray addObject:@[contentModel]];
    [self addChildViewController:controller];
    if (showCancel) {
        YXActionSheetModel *cancelModel = [YXActionSheetModel title:@"取消" color:[UIColor blackColor]];
        [self.datasArray addObject:@[cancelModel]];
    }
    self.cancelBlock = cancel;
    self.contentView = controller.view;
    self.contentHeight = height;
    [self showWithAnimation];
    [self.actionTableView reloadData];
}

#pragma mark - UITableView相关
- (void)setupTableView {
    [self.view addSubview:self.actionTableView];
    self.actionTableView.estimatedRowHeight = 0;
    self.actionTableView.estimatedSectionHeaderHeight = 0;
    self.actionTableView.estimatedSectionFooterHeight = 0;
    [self.actionTableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    self.actionTableView.showsVerticalScrollIndicator = NO;
    self.actionTableView.showsHorizontalScrollIndicator = NO;
    [self.actionTableView registerClass:YXActionSheetTableViewCell.class forCellReuseIdentifier:@"YXActionSheetTableViewCell"];
    [self.actionTableView registerClass:YXCustomTableViewCell.class forCellReuseIdentifier:@"YXCustomTableViewCell"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        YXCustomTableViewCell *contentCell = [tableView dequeueReusableCellWithIdentifier:@"YXCustomTableViewCell" forIndexPath:indexPath];
        [contentCell updateActionModel:self.datasArray[indexPath.section][indexPath.row]];
        return contentCell;
    }
    YXActionSheetTableViewCell *actionCell = [tableView dequeueReusableCellWithIdentifier:@"YXActionSheetTableViewCell" forIndexPath:indexPath];
    [actionCell updateActionModel:self.datasArray[indexPath.section][indexPath.row]];
    return actionCell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.datasArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.datasArray[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return self.view.frame.size.height - (self.cancelBlock ? kRowHeight : 0) - (kIPHONE_BOTTOMSAFEAREA);
    }
    return kRowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01;
    }
    return kHeaderSectionH;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self hiddenWithAnimation];
    YXActionSheetModel *actionModel = self.datasArray[indexPath.section][indexPath.row];
    if (actionModel.clickBlock) {
        actionModel.clickBlock(indexPath.row);
    }
}

#pragma mark - UITapGestureRecognizer相关
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isDescendantOfView:self.view]) {
        return NO;
    }
    return YES;
}

#pragma mark - lazy
- (UITableView *)actionTableView {
    if (!_actionTableView) {
        _actionTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        _actionTableView.delegate = self;
        _actionTableView.dataSource = self;
        _actionTableView.scrollEnabled = NO;
    }
    return _actionTableView;
}

- (NSMutableArray <NSArray <YXActionSheetModel *> *> *)datasArray {
    if (!_datasArray) {
        _datasArray = [NSMutableArray array];
    }
    return _datasArray;
}

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
