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
    
    [[YXPickerManager shareManager] showGeneralPickerView:[UIColor redColor] dataArray:@[@"测试1",@"测试2",@"测试3",@"测试4",@"测试5"] defaultString:@"测试5" commitBlock:^(NSString *selectedItem,NSInteger index) {
        NSLog(@"%@",selectedItem);
    } cancelBlock:^{
        
    }];
}


@end
