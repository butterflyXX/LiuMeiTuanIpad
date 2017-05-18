//
//  LXCCategoryViewController.m
//  LiuMeiTuanIpad
//
//  Created by 刘晓晨 on 2017/5/17.
//  Copyright © 2017年 刘晓晨. All rights reserved.
//

#import "LXCCategoryViewController.h"



@interface LXCCategoryViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

static NSString *leftCell = @"leftCell";
static NSString *rightCell = @"rightCell";

@implementation LXCCategoryViewController

@synthesize popoverView = _popoverView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
}

-(LXCPopoverView *)popoverView {
    if (!_popoverView) {
        //创建popoverView
        _popoverView = [LXCPopoverView popoverView];
        [self.view addSubview:_popoverView];
        
        //设置数据源
        _popoverView.leftTableView.delegate = self;
        _popoverView.leftTableView.dataSource = self;
  
    }
    
    return _popoverView;
}

#pragma mark -UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.categoryArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:leftCell];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:leftCell];
        
        //设置背景图片
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_dropdown_leftpart"]];
        cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_dropdown_left_selected"]];
    }
    
    cell.imageView.image = [UIImage imageNamed:self.categoryArr[indexPath.row].small_icon];
    cell.imageView.highlightedImage = [UIImage imageNamed:self.categoryArr[indexPath.row].small_highlighted_icon];
    cell.textLabel.text = self.categoryArr[indexPath.row].name;
    
    //设置箭头
    if (self.categoryArr[indexPath.row].subcategories.count) {
        cell.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}




@end







