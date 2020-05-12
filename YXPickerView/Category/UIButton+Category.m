//
//  UIButton+Category.m
//  demo
//
//  Created by 曹云霄 on 2019/8/12.
//  Copyright © 2019 曹云霄. All rights reserved.
//

#import "UIButton+Category.h"

@implementation UIButton (Category)

- (void)horizontalCenterImageAndTitle:(CGFloat)spacing {
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0,  0.0, 0.0,  - spacing/2);
    self.imageEdgeInsets = UIEdgeInsetsMake(0.0, - spacing/2, 0.0, 0.0);
}

@end
