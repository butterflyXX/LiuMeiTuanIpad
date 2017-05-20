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
#import "LXCSearchCityControllerViewController.h"
#import "LXCBaseNavigationController.h"

@interface LXCDistrictViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,assign)NSInteger selectedRow;

@property(nonatomic,strong)UIView *topView;

@end

static NSString *leftCell = @"leftCell";
static NSString *rightCell = @"rightCell";
static CGFloat TOPVIEWHEIGHT = 40;

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
    
    [self.view addSubview:_topView];
    _topView.backgroundColor = [UIColor whiteColor];
    UIButton *changeCityButton = [UIButton new];
    [_topView addSubview:changeCityButton];
    [changeCityButton setTitle:@"切换城市" forState:UIControlStateNormal];
    [changeCityButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [changeCityButton setImage:[UIImage imageNamed:@"btn_changeCity"] forState:UIControlStateNormal];
    [changeCityButton setImage:[UIImage imageNamed:@"btn_changeCity_selected"] forState:UIControlStateHighlighted];
    changeCityButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [changeCityButton addTarget:self action:@selector(changeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [changeCityButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.offset(TOPVIEWHEIGHT);
    }];

    
}

-(void) changeBtnClick {
    
    //移除区域控制器
    [self dismissViewControllerAnimated:YES completion:nil];
    LXCSearchCityControllerViewController *searchVc = [LXCSearchCityControllerViewController new];
    LXCBaseNavigationController *nav = [[LXCBaseNavigationController alloc] initWithRootViewController:searchVc];
    
    nav.modalPresentationStyle = UIModalPresentationFormSheet;
    nav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
    
}

#pragma mark - 懒加载控件
-(LXCPopoverView *)popoverView {
    if (!_popoverView) {
        _popoverView = [LXCPopoverView popoverView];
        
        //添加到视图上
        [self.view addSubview:_popoverView];
        
        _popoverView.y = TOPVIEWHEIGHT;
        
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
        
        //判断是否有二级数据
        if (self.city.districts[indexPath.row].subdistricts) {
            
            //有二级菜单
            self.selectedRow = indexPath.row;
            [_popoverView.rightTableView reloadData];
            
        } else {
            
            //没有二级菜单
            //发送通知,移除控制器
            [LXCNoteCenter postNotificationName:LXCDistrictDidChangeNote object:nil userInfo:@{LXCDistrictDidChangeNoteModelKey:self.city.districts[indexPath.row]}];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    } else {
        //选中二级菜单
        //发送通知,移除控制器
        [LXCNoteCenter postNotificationName:LXCDistrictDidChangeNote object:nil userInfo:@{LXCDistrictDidChangeNoteModelKey:self.city.districts[self.selectedRow],LXCDistrictDidChangeNoteSubtitleKey:self.city.districts[self.selectedRow].subdistricts[indexPath.row]}];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    
}




@end




