//
//  ViewController.m
//  YXPickerView
//
//  Created by 曹云霄 on 2017/7/14.
//  Copyright © 2017年 曹云霄. All rights reserved.
//

#import "ViewController.h"
#import "YXToolbar.h"
#import "YXPickerView.h"
#import "YXPickerManager.h"
@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *inputTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    YXToolbar *toolBar = [[YXToolbar alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 44)];
    toolBar.translucent = NO;
    self.inputTextField.inputAccessoryView = toolBar;
    
//    YXPickerView *pickerView = [[YXPickerView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 200)];
//    [self.view addSubview:pickerView];

}


- (IBAction)clickAction:(UIButton *)sender {
    [[YXPickerManager shareManager] showAddressPickerView:[UIColor redColor] defaultAddress:nil commitBlock:^(NSString *address, NSString *zipcode) {
        NSLog(@"%@------>%@",address,zipcode);
    } cancelBlock:^{
        NSLog(@"取消");
    }];
    
}


@end
