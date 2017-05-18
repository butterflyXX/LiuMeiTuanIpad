//
//  LXCHomeNavItem.h
//  LiuMeiTuanIpad
//
//  Created by 刘晓晨 on 2017/5/17.
//  Copyright © 2017年 刘晓晨. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXCHomeNavItem : UIControl

+(instancetype)homeNav;

@property(nonatomic,copy)NSString *imageName;
@property(nonatomic,copy)NSString *hightLightedImageName;
@property(nonatomic,copy)NSString *titleStr;
@property(nonatomic,copy)NSString *subTitleStr;




@end
