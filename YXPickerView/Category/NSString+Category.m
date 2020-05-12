//
//  NSString+Category.m
//  demo
//
//  Created by 曹云霄 on 2019/8/12.
//  Copyright © 2019 曹云霄. All rights reserved.
//

#import "NSString+Category.h"

@implementation NSString (Category)

/**
 *  计算字符串高度 （多行）
 *
 *  @param width 字符串的宽度
 *  @param font  字体大小
 *
 *  @return 字符串的尺寸
 */
- (CGSize)heightWithWidth:(CGFloat)width andFont:(UIFont *)font {
    NSDictionary *attribute = @{NSFontAttributeName: font};
    CGSize  size = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)  options:NSStringDrawingUsesLineFragmentOrigin  |NSStringDrawingUsesFontLeading |NSStringDrawingTruncatesLastVisibleLine attributes:attribute context:nil].size;
    return size;
}

@end
