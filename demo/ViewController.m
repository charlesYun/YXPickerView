//
//  ViewController.m
//  YXPickerView
//
//  Created by 曹云霄 on 2017/7/14.
//  Copyright © 2017年 曹云霄. All rights reserved.
//

#import "ViewController.h"
#import "YXToolbar.h"
#import "YXPickerManager.h"
@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *inputTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (IBAction)clickAction:(UIButton *)sender {
//    [[YXPickerManager shareManager] showAddressPickerView:[UIColor redColor] defaultAddress:@"上海市-市辖区-闵行区" commitBlock:^(NSString *address, NSString *zipcode) {
//        NSLog(@"%@------>%@",address,zipcode);
//    } cancelBlock:^{
//        NSLog(@"取消");
//    }];
    
    [[YXPickerManager shareManager] showDatePickerView:[UIColor redColor] datePickerModel:UIDatePickerModeDate minimumDate:[NSDate date] maximumDate:nil defaultDate:@"2017-10-01 00:00:00" commitBlock:^(NSString *date) {
        NSLog(@"%@",date);
    } cancelBlock:^{
        
    }];
}


@end
