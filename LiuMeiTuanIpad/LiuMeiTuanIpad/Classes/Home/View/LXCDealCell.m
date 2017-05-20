//
//  LXCDealCell.m
//  MeiTuanHD
//
//  Created by apple on 16/3/6.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "LXCDealCell.h"
#import "LXCDateFormater.h"
#import <UIImageView+WebCache.h>

@interface LXCDealCell ()
//图片
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
//标题
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//描述
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
//当前价格
@property (weak, nonatomic) IBOutlet UILabel *currentPriceLabel;
//原价
@property (weak, nonatomic) IBOutlet UILabel *listPriceLabel;
//已售数
@property (weak, nonatomic) IBOutlet UILabel *purchaseCountLabel;
//新单图标
@property (weak, nonatomic) IBOutlet UIImageView *dealNewImageView;

@end

@implementation LXCDealCell


- (void)setDealModel:(LXCDealModel *)dealModel{

    _dealModel = dealModel;
    //设置控件数据
    self.titleLabel.text = _dealModel.title;
    self.descLabel.text = _dealModel.desc;
    //设置图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:_dealModel.s_image_url] placeholderImage:[UIImage imageNamed:@"placeholder_deal"]];
    //设置现价 获取到价格/数量等float类型的数据,使用float类型来接近,使用NSNumber进行转换,去掉小数点后多余的位数
    self.currentPriceLabel.text = [NSString stringWithFormat:@"%@", [NSNumber numberWithFloat:_dealModel.current_price]];
    self.listPriceLabel.text = [NSString stringWithFormat:@"%@", [NSNumber numberWithFloat:_dealModel.list_price]];
    //设置已售数量
    self.purchaseCountLabel.text = [NSString stringWithFormat:@"已售%d", _dealModel.purchase_count];
    //设置新单  自定义规则: 发布日期(NSString) >= 当前日期(NSDate),显示新单
//    LXCLog(@"%@", _dealModel.publish_date);
    //创建日期格式化对象 创建/设置格式时性能消耗很大   使用时注意: 1> 不要频繁创建 2> 不要频繁修改格式
    LXCDateFormater *dateFormater = [LXCDateFormater sharedIntance];
    //NSDate转NSString
    NSString *nowString = [dateFormater stringFromDate:[NSDate date]];
    //根据日期比较显隐新单图片
    self.dealNewImageView.hidden = ([_dealModel.publish_date compare:nowString] != NSOrderedAscending) ? NO : YES;
}

@end
