//
//  LXCDistrictModel.h
//  LiuMeiTuanIpad
//
//  Created by 刘晓晨 on 2017/5/18.
//  Copyright © 2017年 刘晓晨. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXCDistrictModel : NSObject

/**
 城市名称
 */
@property(nonatomic,copy)NSString *name;

/**
 区域数据
 */
@property(nonatomic,strong)NSArray *subdistricts;


@end
