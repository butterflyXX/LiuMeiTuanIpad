//
//  LXCCategoryModel.h
//  LiuMeiTuanIpad
//
//  Created by 刘晓晨 on 2017/5/18.
//  Copyright © 2017年 刘晓晨. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXCCategoryModel : NSObject

//高亮图片
@property(nonatomic,copy)NSString *highlighted_icon;

//普通图片
@property(nonatomic,copy)NSString *icon;

//分类名称
@property(nonatomic,copy)NSString *name;

//高亮小图
@property(nonatomic,copy)NSString *small_highlighted_icon;

//普通小图
@property(nonatomic,copy)NSString *small_icon;

//地图图标
@property(nonatomic,copy)NSString *map_icon;

//二级数据
@property(nonatomic,strong)NSArray *subcategories;

@end
