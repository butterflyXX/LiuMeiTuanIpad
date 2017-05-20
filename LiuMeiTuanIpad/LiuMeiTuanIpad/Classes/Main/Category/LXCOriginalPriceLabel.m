//
//  LXCOriginalPriceLabel.m
//  LiuMeiTuanIpad
//
//  Created by 刘晓晨 on 2017/5/20.
//  Copyright © 2017年 刘晓晨. All rights reserved.
//

#import "LXCOriginalPriceLabel.h"

@implementation LXCOriginalPriceLabel

- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, rect.size.height * 0.5)];
    [path addLineToPoint:CGPointMake(rect.size.width, rect.size.height * 0.5)];
    [[UIColor darkGrayColor] setStroke];
    
    [path stroke];
    
}


@end
