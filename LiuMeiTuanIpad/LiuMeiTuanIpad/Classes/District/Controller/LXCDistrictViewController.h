//
//  LXCDistrictViewController.h
//  LiuMeiTuanIpad
//
//  Created by 刘晓晨 on 2017/5/18.
//  Copyright © 2017年 刘晓晨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXCPopoverView.h"
#import "LXCCityModel.h"

@interface LXCDistrictViewController : UIViewController

@property(nonatomic,strong,readonly)LXCPopoverView *popoverView;
@property(nonatomic,strong)LXCCityModel *city;

@end
