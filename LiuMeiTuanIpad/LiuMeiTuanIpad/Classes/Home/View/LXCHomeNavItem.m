//
//  LXCHomeNavItem.m
//  LiuMeiTuanIpad
//
//  Created by 刘晓晨 on 2017/5/17.
//  Copyright © 2017年 刘晓晨. All rights reserved.
//

#import "LXCHomeNavItem.h"

@interface LXCHomeNavItem ()

@property (weak, nonatomic) IBOutlet UIButton *iconBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *subTiltLab;

@end

@implementation LXCHomeNavItem

+(instancetype)homeNav {
    
    //从xib中获取
    return [[NSBundle mainBundle] loadNibNamed:@"LXCHomeNavItem" owner:nil options:nil].lastObject;
}

-(void)setTitleStr:(NSString *)titleStr {
    _titleStr = titleStr;
    _titleLab.text = titleStr;
}
-(void)setSubTitleStr:(NSString *)subTitleStr {
    _subTitleStr = subTitleStr;
    _subTiltLab.text = subTitleStr;
}
-(void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    [_iconBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}
-(void)setHightLightedImageName:(NSString *)hightLightedImageName {
    _hightLightedImageName = hightLightedImageName;
    [_iconBtn setImage:[UIImage imageNamed:hightLightedImageName] forState:UIControlStateHighlighted];
}

- (IBAction)ButtonClick:(UIButton *)sender {
    
    //点击按钮触发事件
    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
}


@end
