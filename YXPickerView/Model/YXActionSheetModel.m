//
//  YXActionSheetModel.m
//  demo
//
//  Created by 曹云霄 on 2019/8/12.
//  Copyright © 2019 曹云霄. All rights reserved.
//

#import "YXActionSheetModel.h"

@implementation YXActionSheetModel



+ (instancetype)title:(NSString *)title color:(UIColor *)color {
    return [[self alloc] initWithTitle:title color:color icon:nil];
}

+ (instancetype)title:(NSString *)title color:(UIColor *)color icon:(NSString *)icon {
    return [[self alloc] initWithTitle:title color:color icon:icon];
}

- (instancetype)initWithTitle:(NSString *)title color:(UIColor *)color icon:(NSString *)icon {
    if (self = [super init]) {
        self.title = title;
        self.color = color;
        self.iconName = icon;
    }
    return self;
}

+ (instancetype)view:(UIView *)view {
    return [[self alloc] initWithView:view];
}

- (instancetype)initWithView:(UIView *)view {
    if (self = [super init]) {
        self.contentView = view;
    }
    return self;
}

@end
