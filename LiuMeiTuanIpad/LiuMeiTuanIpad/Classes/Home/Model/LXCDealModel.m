//
//  LXCDealModel.m
//  MeiTuanHD
//
//  Created by apple on 16/8/4.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "LXCDealModel.h"

@implementation LXCDealModel

/**
 自定义模型的属性的匹配Key
 */
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"desc"  : @"description"};
}

@end
