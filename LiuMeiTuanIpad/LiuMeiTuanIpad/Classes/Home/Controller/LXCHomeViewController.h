//
//  LXCHomeViewController.h
//  LiuMeiTuanIpad
//
//  Created by 刘晓晨 on 2017/5/17.
//  Copyright © 2017年 刘晓晨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXCCityModel.h"
#import "LXCCityGroupsModel.h"
#import "LXCCategoryModel.h"

@interface LXCHomeViewController : UICollectionViewController

@property(nonatomic,strong,readonly)NSArray<LXCCategoryModel *> *categoryDataArr;
@property(nonatomic,strong,readonly)NSArray *districtDataArr;
@property(nonatomic,strong,readonly)NSArray *citygroupDataArr;


@end
