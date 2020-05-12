//
//  ViewController.m
//  YXPickerView
//
//  Created by 曹云霄 on 2017/7/14.
//  Copyright © 2017年 曹云霄. All rights reserved.
//

#import "ViewController.h"
#import "YXPickerManager.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *inputTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [YXPickerManager shareManager].cancelColor = [UIColor redColor];
    [YXPickerManager shareManager].title = @"请选择";
    [YXPickerManager shareManager].titleColor = [UIColor purpleColor];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0: {
            [[YXPickerManager shareManager] showCustomPickerViewDataArray:@[@"1",@"2",@"3",@"4"] selectIndex:3 confirm:^(NSString *title, NSInteger index) {
                NSLog(@"%@ - %ld",title,index);
            } cancel:^{
                NSLog(@"取消");
            }];
        }
            break;
        case 1: {
            [[YXPickerManager shareManager] showAddressPickerViewSelected:@"上海市-市辖区-闵行区" confirm:^(NSString *address, NSString *zipcode) {
                NSLog(@"%@ - %@",address,zipcode);
            } cancel:^{
                NSLog(@"取消");
            }];
        }
            break;
        case 2: {
            [[YXPickerManager shareManager] showDatePickerViewMinimumDate:nil maximumDate:nil defaultDate:@"2019-05" confirm:^(NSString *dateStr, NSDate *date) {
                NSLog(@"%@ - %@",dateStr,date);
            } cancel:^{
                NSLog(@"取消");
            }];
        }
            break;
        case 3: {
            [[YXPickerManager shareManager] showTimePickerViewMinimumDate:nil maximumDate:nil defaultDate:@"15:00" confirm:^(NSString *dateStr, NSDate *date) {
                NSLog(@"%@ - %@",dateStr,date);
            } cancel:^{
                NSLog(@"取消");
            }];
        }
            break;
        case 4: {
            [[YXPickerManager shareManager] showDateAndTimePickerViewMinimumDate:nil maximumDate:nil defaultDate:@"2019-08-08 12:00:00" confirm:^(NSString *dateStr, NSDate *date) {
                NSLog(@"%@ - %@",dateStr,date);
            } cancel:^{
                NSLog(@"取消");
            }];
        }
            break;
        case 5: {
            YXActionSheetModel *photoModel = [YXActionSheetModel title:@"相册" color:[UIColor blackColor]];
            [photoModel setClickBlock:^(NSInteger index) {
                NSLog(@"点击");
            }];
            YXActionSheetModel *cameraModel = [YXActionSheetModel title:@"相机" color:[UIColor blackColor]];
            [cameraModel setClickBlock:^(NSInteger index) {
                NSLog(@"点击");
            }];
            YXActionSheetModel *viewModel = [YXActionSheetModel title:@"查看大图" color:[UIColor blackColor]];
            [viewModel setClickBlock:^(NSInteger index) {
                NSLog(@"点击");
            }];
            [[YXPickerManager shareManager] showActionSheetView:@[photoModel,cameraModel,viewModel] title:@"设置个人头像"];
        }
            break;
        case 6: {
            YXActionSheetModel *photoModel = [YXActionSheetModel title:@"相册" color:[UIColor blackColor] icon:@"相册"];
            [photoModel setClickBlock:^(NSInteger index) {
                NSLog(@"点击");
            }];
            YXActionSheetModel *cameraModel = [YXActionSheetModel title:@"相机" color:[UIColor blackColor] icon:@"相机"];
            [cameraModel setClickBlock:^(NSInteger index) {
                NSLog(@"点击");
            }];
            YXActionSheetModel *viewModel = [YXActionSheetModel title:@"查看大图" color:[UIColor blackColor] icon:@"查看"];
            [viewModel setClickBlock:^(NSInteger index) {
                NSLog(@"点击");
            }];
            [[YXPickerManager shareManager] showActionSheetView:@[photoModel,cameraModel,viewModel] title:nil];
        }
            break;
        default:
            break;
    }
}



@end
