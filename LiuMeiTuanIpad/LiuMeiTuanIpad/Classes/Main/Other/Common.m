//
//  Common.m
//  LiuMeiTuanIpad
//
//  Created by 刘晓晨 on 2017/5/20.
//  Copyright © 2017年 刘晓晨. All rights reserved.
//

#import "Common.h"
//定义全局常量字符串  static 描述静态全局变量/常量,只能在当前文件中使用; 如果需要常量/变量被其他文件引用,则需要去掉static,定义为全局常量/变量,别的文件需要引用该全局常量,则需要添加extern
//谁定义全局常量/变量,就应该由谁告知其他开发者常量的存在(需要将常量公开)
//项目中的全局常量不能够同名



NSString * const LXCCityDidChangeNote = @"LXCCityDidChangeNote";

NSString * const LXCCityDidChangeNoteCityName = @"LXCCityDidChangeNoteCityName";

// 切换分类通知
NSString *const LXCCategoryDidChangeNote = @"LXCCategoryDidChangeNote";
// 切换分类通知参数: 分类模型
NSString *const LXCCategoryDidChangeNoteModelKey = @"LXCCategoryDidChangeNoteModelKey";
// 切换分类通知参数: 子分类名称
NSString *const LXCCategoryDidChangeNoteSubtitleKey = @"LXCCategoryDidChangeNoteSubtitleKey";

// 切换区域通知
NSString *const LXCDistrictDidChangeNote = @"LXCDistrictDidChangeNote";
// 切换区域通知参数: 区域模型
NSString *const LXCDistrictDidChangeNoteModelKey = @"LXCDistrictDidChangeNoteModelKey";
// 切换区域通知参数: 子区域名称
NSString *const LXCDistrictDidChangeNoteSubtitleKey = @"LXCDistrictDidChangeNoteSubtitleKey";

// 切换排序通知
NSString *const LXCSortDidChangeNote = @"LXCSortDidChangeNote";
// 切换排序通知参数: 排序模型
NSString *const LXCSortDidChangeNoteModelKey = @"LXCSortDidChangeNoteModelKey";

//团购cell的宽度
CGFloat const LXCDealCellWidth = 305;


