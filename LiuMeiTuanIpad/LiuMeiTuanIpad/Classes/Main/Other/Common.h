//
//  Common.h
//  LiuMeiTuanIpad
//
//  Created by 刘晓晨 on 2017/5/20.
//  Copyright © 2017年 刘晓晨. All rights reserved.
//

#import <Foundation/Foundation.h>

//引用全局常量(定义全局常量的文件,需要在其.h中再引用该全局常量)
//UIKIT_EXTERN 相当于extern 但是可以区分c/oc/c++中不同的写法


//城市切换通知
UIKIT_EXTERN NSString * const LXCCityDidChangeNote;

//城市切换通知key: 城市名
UIKIT_EXTERN NSString * const LXCCityDidChangeNoteCityName;


// 切换分类通知
UIKIT_EXTERN NSString *const LXCCategoryDidChangeNote;
// 切换分类通知参数: 分类模型
UIKIT_EXTERN NSString *const LXCCategoryDidChangeNoteModelKey;
// 切换分类通知参数: 子分类名称
UIKIT_EXTERN NSString *const LXCCategoryDidChangeNoteSubtitleKey;

// 切换区域通知
UIKIT_EXTERN NSString *const LXCDistrictDidChangeNote;
// 切换区域通知参数: 区域模型
UIKIT_EXTERN NSString *const LXCDistrictDidChangeNoteModelKey;
// 切换区域通知参数: 子区域名称
UIKIT_EXTERN NSString *const LXCDistrictDidChangeNoteSubtitleKey;

// 切换排序通知
UIKIT_EXTERN NSString *const LXCSortDidChangeNote;
// 切换排序通知参数: 排序模型
UIKIT_EXTERN NSString *const LXCSortDidChangeNoteModelKey;

//团购cell的宽度
UIKIT_EXTERN CGFloat const LXCDealCellWidth;

