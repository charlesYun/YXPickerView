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
            [[YXPickerManager shareManager] showDatePickerViewMinimumDate:nil maximumDate:nil defaultDate:@"2019-05-08" confirm:^(NSString *dateStr, NSDate *date) {
                NSLog(@"%@ - %@",dateStr,date);
            } cancel:^{
                NSLog(@"取消");
            }];
        }
            break;
        case 3: {
            [[YXPickerManager shareManager] showTimePickerViewMinimumDate:nil maximumDate:nil defaultDate:@"15:00:00" confirm:^(NSString *dateStr, NSDate *date) {
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
        default:
            break;
    }
}



@end
