//
//  LXCDateFormater.h
//  LiuMeiTuanIpad
//
//  Created by 刘晓晨 on 2017/5/20.
//  Copyright © 2017年 刘晓晨. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXCDateFormater : NSDateFormatter

//单例
+ (instancetype)sharedIntance;

//设置格式
- (void)setupDateFormatFromString:(NSString *)dateString;

@end
