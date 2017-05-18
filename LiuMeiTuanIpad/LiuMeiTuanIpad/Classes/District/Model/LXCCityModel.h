//
//  LXCCityModel.h
//  LiuMeiTuanIpad
//
//  Created by 刘晓晨 on 2017/5/18.
//  Copyright © 2017年 刘晓晨. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LXCDistrictModel.h"

@interface LXCCityModel : NSObject
/**
 区域名称
 */
@property(nonatomic,copy)NSString *name;

/**
 区域拼音
 */
@property(nonatomic,copy)NSString *pinYin;

/**
 区域拼音首字母
 */
@property(nonatomic,copy)NSString *pinYinHead;

/**
 子区域数据
 */
@property(nonatomic,strong)NSArray<LXCDistrictModel *> *districts;

@end
