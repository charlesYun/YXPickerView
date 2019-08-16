## YXPickerView

###项目中经常会用到选择器，比如省市区选择、筛选项选择、日期选择、时间选择等等，此项目做了一个封装以方便使用。

通过cocoapods找到它：`pod search YXPickerView`
使用：
`pod 'YXPickerView'`
`pod install`

#### 1、自定义选择使用示例
```objective-c
[[YXPickerManager shareManager] showCustomPickerViewDataArray:@[@"1",@"2",@"3",@"4"] selectIndex:3 confirm:^(NSString *title, NSInteger index) {
NSLog(@"%@ - %ld",title,index);
} cancel:^{
NSLog(@"取消");
}];
```
<img src="https://github.com/caoyunxiao/YXPickerView/blob/master/images/Simulator%20Screen%20Shot%20-%20iPhone%20XS%20-%202019-08-16%20at%2012.01.16.png"  height="667" width="375">

#### 2、省市区选择使用示例
```objective-c
[[YXPickerManager shareManager] showAddressPickerViewSelected:@"上海市-市辖区-闵行区" confirm:^(NSString *address, NSString *zipcode) {
NSLog(@"%@ - %@",address,zipcode);
} cancel:^{
NSLog(@"取消");
}];
```
<img src="https://github.com/caoyunxiao/YXPickerView/blob/master/images/Simulator%20Screen%20Shot%20-%20iPhone%20XS%20-%202019-08-16%20at%2012.01.12.png"  height="667" width="375">

#### 3、日期选择使用示例
```objective-c
[[YXPickerManager shareManager] showDatePickerViewMinimumDate:nil maximumDate:nil defaultDate:@"2019-05-08" confirm:^(NSString *dateStr, NSDate *date) {
NSLog(@"%@ - %@",dateStr,date);
} cancel:^{
NSLog(@"取消");
}];
```
<img src="https://github.com/caoyunxiao/YXPickerView/blob/master/images/Simulator%20Screen%20Shot%20-%20iPhone%20XS%20-%202019-08-16%20at%2012.01.09.png"  height="667" width="375">

#### 4、时间选择使用示例
```objective-c
[[YXPickerManager shareManager] showTimePickerViewMinimumDate:nil maximumDate:nil defaultDate:@"15:00:00" confirm:^(NSString *dateStr, NSDate *date) {
NSLog(@"%@ - %@",dateStr,date);
} cancel:^{
NSLog(@"取消");
}];
```

#### 5、日期和时间选择使用示例
```objective-c
[[YXPickerManager shareManager] showDateAndTimePickerViewMinimumDate:nil maximumDate:nil defaultDate:@"2019-08-08 12:00:00" confirm:^(NSString *dateStr, NSDate *date) {
NSLog(@"%@ - %@",dateStr,date);
} cancel:^{
NSLog(@"取消");
}];
```
<img src="https://github.com/caoyunxiao/YXPickerView/blob/master/images/Simulator%20Screen%20Shot%20-%20iPhone%20XS%20-%202019-08-16%20at%2012.01.18.png"  height="667" width="375">

#### 5、仿微信弹框
```objective-c
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
```
<img src="https://github.com/caoyunxiao/YXPickerView/blob/master/images/Simulator%20Screen%20Shot%20-%20iPhone%20XS%20-%202019-08-16%20at%2012.01.20.png"  height="667" width="375">

<img src="https://github.com/caoyunxiao/YXPickerView/blob/master/images/Simulator%20Screen%20Shot%20-%20iPhone%20XS%20-%202019-08-16%20at%2012.01.22.png"  height="667" width="375">

### End
