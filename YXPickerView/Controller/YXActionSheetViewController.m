//
//  YXActionSheetViewController.m
//  demo
//
//  Created by 曹云霄 on 2019/8/12.
//  Copyright © 2019 曹云霄. All rights reserved.
//

#import "YXActionSheetViewController.h"
#import "YXActionSheetTableViewCell.h"
#import "YXPickerViewHeader.h"
#import "NSString+Category.h"


@interface YXActionSheetViewController ()<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITableView *actionTableView;
@property (nonatomic, strong) NSMutableArray <NSArray<YXActionSheetModel *> *>*datasArray;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, assign) CGFloat headerHeight;
@property (nonatomic, copy) CancelBlock cancelBlock;

@end

@implementation YXActionSheetViewController

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
    CGFloat height = (self.datasArray[0].count + 1) * kRowHeight + kHeaderSectionH + (kIPHONE_BOTTOMSAFEAREA);
    if (height > kScreenHeight - 100 ) {
        height = kScreenHeight - 100;
        _actionTableView.scrollEnabled = YES;
    }else {
        _actionTableView.scrollEnabled = NO ;
    }
    self.view.frame = CGRectMake(0, kScreenHeight, kScreenWidth, height + self.headerHeight);
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

- (void)showActionSheetView:(NSArray<YXActionSheetModel *> *)array title:(NSString *)title cancel:(CancelBlock)cancel {
    [self.datasArray addObject:array];
    YXActionSheetModel *cancelModel = [YXActionSheetModel title:@"取消" color:[UIColor blackColor]];
    [self.datasArray addObject:@[cancelModel]];
    self.cancelBlock = cancel;
    UIView *headerView = nil;
    if (title) {
        CGSize size = [title heightWithWidth:kScreenWidth - 100 andFont:[UIFont systemFontOfSize:16]];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:16];
        label.text = title;
        label.textColor = [UIColor grayColor];
        headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, size.height + 30)];
        headerView.backgroundColor = [UIColor whiteColor];
        [headerView addSubview:label];
        label.center = headerView.center;
        self.headerHeight = headerView.frame.size.height;
        self.actionTableView.tableHeaderView = headerView;
    }
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
    [self.actionTableView registerClass:YXActionSheetTableViewCell.class forCellReuseIdentifier:@"YXActionSheetTableViewCell"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
