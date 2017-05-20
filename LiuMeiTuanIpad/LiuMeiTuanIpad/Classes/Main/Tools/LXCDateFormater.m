//
//  LXCDateFormater.m
//  LiuMeiTuanIpad
//
//  Created by 刘晓晨 on 2017/5/20.
//  Copyright © 2017年 刘晓晨. All rights reserved.
//

#import "LXCDateFormater.h"

@implementation LXCDateFormater

+ (instancetype)sharedIntance{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [self new];
        //设置格式 2017-02-16
        [instance setupDateFormatFromString:@"yyyy-MM-dd"];
    });
    
    return instance;
}

//设置格式
- (void)setupDateFormatFromString:(NSString *)dateString{
    
    self.dateFormat = dateString;
}

@end
