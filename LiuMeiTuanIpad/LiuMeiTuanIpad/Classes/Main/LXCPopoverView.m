//
//  LXCPopoverView.m
//  LiuMeiTuanIpad
//
//  Created by 刘晓晨 on 2017/5/17.
//  Copyright © 2017年 刘晓晨. All rights reserved.
//

#import "LXCPopoverView.h"

@implementation LXCPopoverView

+(instancetype)popoverView {
    return [[NSBundle mainBundle] loadNibNamed:@"LXCPopoverView" owner:nil options:nil].lastObject;
}

@end
