//
//  LXCCityModel.m
//  LiuMeiTuanIpad
//
//  Created by 刘晓晨 on 2017/5/18.
//  Copyright © 2017年 刘晓晨. All rights reserved.
//

#import "LXCCityModel.h"

@implementation LXCCityModel

// 返回容器类中的所需要存放的数据类型 (以 Class 或 Class Name 的形式)。
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"districts" : [LXCDistrictModel class]
             };
}

@end
