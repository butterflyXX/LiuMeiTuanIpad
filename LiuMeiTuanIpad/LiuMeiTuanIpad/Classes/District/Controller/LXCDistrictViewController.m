//
//  LXCDistrictViewController.m
//  LiuMeiTuanIpad
//
//  Created by 刘晓晨 on 2017/5/18.
//  Copyright © 2017年 刘晓晨. All rights reserved.
//

#import "LXCDistrictViewController.h"
#import <Masonry.h>
#import "UIView+HMCategory.h"

@interface LXCDistrictViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,assign)NSInteger selectedRow;

@property(nonatomic,strong)UIView *topView;

@end

static NSString *leftCell = @"leftCell";
static NSString *rightCell = @"rightCell";

@implementation LXCDistrictViewController

@synthesize popoverView = _popoverView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupUI {
    
    //创建上部view
    _topView = [UIView new];
    _topView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_topView];
    
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.offset(40);
    }];

    
}

#pragma mark - 懒加载控件
-(LXCPopoverView *)popoverView {
    if (!_popoverView) {
        _popoverView = [LXCPopoverView popoverView];
        
        //添加到视图上
        [self.view addSubview:_popoverView];
        
        _popoverView.y = _topView.height;
        
        //设置数据源代理
        _popoverView.leftTableView.delegate = self;
        _popoverView.leftTableView.dataSource = self;
        _popoverView.rightTableView.delegate = self;
        _popoverView.rightTableView.dataSource = self;
    }
    
    return _popoverView;
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == _popoverView.leftTableView) {
        return self.city.districts.count;
    } else {
        return self.city.districts[self.selectedRow].subdistricts.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    if (tableView == _popoverView.leftTableView) {
        cell = [tableView dequeueReusableCellWithIdentifier:leftCell];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:leftCell];
            
            //设置背景图片
            cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_dropdown_leftpart"]];
            cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_dropdown_left_selected"]];
        }
//        
//        cell.imageView.image = [UIImage imageNamed:self.categoryArr[indexPath.row].small_icon];
//        cell.imageView.highlightedImage = [UIImage imageNamed:self.categoryArr[indexPath.row].small_highlighted_icon];
        cell.textLabel.text = self.city.districts[indexPath.row].name;
        
        //设置箭头
        if (self.city.districts[indexPath.row].subdistricts.count) {
            cell.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:rightCell];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rightCell];
            
            //设置背景图片
            cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_dropdown_rightpart"]];
            cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_dropdown_right_selected"]];
        }
        
        cell.textLabel.text = self.city.districts[self.selectedRow].subdistricts[indexPath.row];
        
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //记录选中的一级菜单
    if (tableView == _popoverView.leftTableView) {
        self.selectedRow = indexPath.row;
        [_popoverView.rightTableView reloadData];
    } else {
        LxcLog(@"%@",self.city.districts[self.selectedRow].subdistricts[indexPath.row]);
    }
}




@end




