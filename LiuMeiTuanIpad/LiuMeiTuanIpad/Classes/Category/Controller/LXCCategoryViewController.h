//
//  LXCCategoryViewController.h
//  LiuMeiTuanIpad
//
//  Created by 刘晓晨 on 2017/5/17.
//  Copyright © 2017年 刘晓晨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXCPopoverView.h"
#import "LXCCategoryModel.h"

@interface LXCCategoryViewController : UIViewController

@property(nonatomic,strong,readonly)LXCPopoverView *popoverView;
@property(nonatomic,strong)NSArray<LXCCategoryModel *> *categoryArr;

@end
