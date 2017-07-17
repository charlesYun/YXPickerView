//
//  YXPickerView.m
//  YXPickerView
//
//  Created by 曹云霄 on 2017/7/14.
//  Copyright © 2017年 曹云霄. All rights reserved.
//

#import "YXPickerView.h"
#import "YXCityModel.h"

@interface YXPickerView()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) NSMutableArray *datasArray;


/**
 选中省
 */
@property (nonatomic, assign) NSInteger selectedIndex_province;

/**
 选中市
 */
@property (nonatomic, assign) NSInteger selectedIndex_city;

/**
 选中区
 */
@property (nonatomic, assign) NSInteger selectedIndex_area;

@end


@implementation YXPickerView

#pragma mark -lazy

- (NSMutableArray *)datasArray
{
    if (!_datasArray) {
        _datasArray = [NSMutableArray array];
    }
    return _datasArray;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    [self initToolBar];
    [self initContainerView];
    
    CGRect initialFrame;
    if (CGRectIsEmpty(frame)) {
        initialFrame = CGRectMake(0, self.toolbar.frame.size.height, WIDTH, 216);
    } else {
        initialFrame = frame;
    }
    self = [super initWithFrame:initialFrame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.delegate = self;
        self.dataSource = self;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self initBgView];
        [self getDatas];
    }
    return self;
}

- (void)initBgView
{
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT - self.frame.size.height - 44, WIDTH, self.frame.size.height + self.toolbar.frame.size.height)];
}

- (void)initToolBar
{
    self.toolbar = [[YXToolbar alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 44)];
    self.toolbar.translucent = NO;
}

- (void)initContainerView
{
    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    self.containerView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    self.containerView.userInteractionEnabled = YES;
    [self.containerView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenWithAnimation)]];
}

- (void)showWithAnimation {
    [self addViews];
    self.containerView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    CGFloat height = self.bgView.frame.size.height;
    self.bgView.center = CGPointMake(WIDTH / 2, HEIGHT + height / 2);
    [UIView animateWithDuration:0.25 animations:^{
        self.bgView.center = CGPointMake(WIDTH / 2, HEIGHT - height / 2);
        self.containerView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    }];
    
}

- (void)hiddenWithAnimation {
    CGFloat height = self.bgView.frame.size.height;
    [UIView animateWithDuration:0.25 animations:^{
        self.bgView.center = CGPointMake(WIDTH / 2, HEIGHT + height / 2);
        self.containerView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    } completion:^(BOOL finished) {
        [self hiddenViews];
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


#pragma mark -解析省市区JSON数据
- (void)getDatas
{
    NSBundle *bundlePath = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[YXPickerView class]] pathForResource:@"YXBundle" ofType:@"bundle"]];
    NSData *data = [NSData dataWithContentsOfFile:[bundlePath pathForResource:@"city" ofType:@"json"]];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *provinceArray = dict[@"root"][@"province"];
    for (NSDictionary *cityDict in provinceArray) {
        YXCityModel *model = [[YXCityModel alloc] init];
        [model setValuesForKeysWithDictionary:cityDict];
        [self.datasArray addObject:model];
    }
    [self reloadAllComponents];
}

#pragma mark - 开始选择

- (void)showAddressPickerView:(UIColor *)tintColor defaultAddress:(NSString *)address commitBlock:(void (^)(NSString *, NSString *))commitBlock cancelBlock:(void (^)())cancelBlock
{
    [self showDefaultAddress:address];
    self.toolbar.tintColor = tintColor;
    [self showWithAnimation];
    __weak typeof(self) weakSelf = self;
    self.toolbar.cancelBlock = ^ {
        if (cancelBlock) {
            [weakSelf hiddenWithAnimation];
            cancelBlock();
        }
    };
    
    self.toolbar.commitBlock = ^{
        if (commitBlock) {
            [weakSelf hiddenWithAnimation];
            YXCityModel *model = weakSelf.datasArray[weakSelf.selectedIndex_province];
            NSDictionary *dict = model.city[weakSelf.selectedIndex_city];
            id object = dict[@"district"];
            NSDictionary *dict1 = nil;
            if ([object isKindOfClass:[NSDictionary class]]) {
                dict1 = object;
            }else {
                dict1 = dict[@"district"][self.selectedIndex_area];
            }
            NSString *address = [NSString stringWithFormat:@"%@-%@-%@",model.name,dict[@"name"],dict1[@"name"]];
            NSString *zipcode = [NSString stringWithFormat:@"%@-%@-%@",model.zipcode,dict[@"zipcode"],dict1[@"zipcode"]];
            commitBlock(address, zipcode);
        }
    };
}

#pragma mark -显示默认地址
- (void)showDefaultAddress:(NSString *)address
{
    if (!address) {
        return;
    }
    NSArray *addressArray = [address componentsSeparatedByString:@"-"];
    [self.datasArray enumerateObjectsUsingBlock:^(YXCityModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.name isEqualToString:addressArray.firstObject]) {
            self.selectedIndex_province = idx;
            [obj.city enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([dict[@"name"] isEqualToString:addressArray[1]]) {
                    self.selectedIndex_city = idx;
                    id object = dict[@"district"];
                    if ([object isKindOfClass:[NSDictionary class]]) {
                        self.selectedIndex_area = 0;
                    }else {
                        [object enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                            if ([obj[@"name"] isEqualToString:[addressArray lastObject]]) {
                                self.selectedIndex_area = idx;
                                *stop = YES;
                            }
                        }];
                    }
                }
            }];
        }
    }];
    
    [self selectRow:self.selectedIndex_province inComponent:0 animated:NO];
    [self selectRow:self.selectedIndex_city inComponent:1 animated:NO];
    [self selectRow:self.selectedIndex_area inComponent:2 animated:NO];
}




#pragma mark -<UIPickerViewDelegate,UIPickerViewDataSource>
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component) {
        case 0:
        {
            YXCityModel *model = self.datasArray[row];
            return model.name;
        }
            break;
        case 1:
        {
            YXCityModel *model = self.datasArray[self.selectedIndex_province];
            NSDictionary *dict = model.city[row];
            return dict[@"name"];
        }
            break;
        case 2:
        {
            YXCityModel *model = self.datasArray[self.selectedIndex_province];
            NSDictionary *dict = model.city[self.selectedIndex_city];
            id object = dict[@"district"];
            if ([object isKindOfClass:[NSDictionary class]]) {
                return object[@"name"];
            }
            NSDictionary *dict1 = dict[@"district"][row];
            return dict1[@"name"];
        }
            break;
            
        default:
            break;
    }
    return @"";
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    switch (component) {
        case 0:
        {
            return self.datasArray.count;
        }
            break;
        case 1:
        {
            YXCityModel *model = self.datasArray[self.selectedIndex_province];
            return model.city.count;
        }
            break;
        case 2:
        {
            YXCityModel *model = self.datasArray[self.selectedIndex_province];
            NSDictionary *dict = model.city[self.selectedIndex_city];
            id object = dict[@"district"];
            if ([object isKindOfClass:[NSDictionary class]]) {
                return 1;
            }
            return [dict[@"district"] count];
        }
            break;
            
        default:
            break;
    }
    return 10;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (component) {
        case 0:
            self.selectedIndex_province = row;
            self.selectedIndex_city = 0;
            self.selectedIndex_area = 0;
            [pickerView reloadComponent:1];
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:1 animated:NO];
            [pickerView selectRow:0 inComponent:2 animated:NO];
            break;
        case 1:
            self.selectedIndex_city = row;
            self.selectedIndex_area = 0;
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:2 animated:NO];
            break;
        case 2:
            self.selectedIndex_area = row;
            break;
        default:
            break;
    }
}



















@end
