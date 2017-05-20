//
//  LXCSearchCityControllerViewController.m
//  LiuMeiTuanIpad
//
//  Created by 刘晓晨 on 2017/5/19.
//  Copyright © 2017年 刘晓晨. All rights reserved.
//

#import "LXCSearchCityControllerViewController.h"
#import "UIBarButtonItem+HMCategory.h"
#import "LXCHomeViewController.h"
#import <Masonry.h>
#import "LXCSearchViewControllerTableViewController.h"

@interface LXCSearchCityControllerViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property (strong, nonatomic) UISearchBar *searchBar;

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) UIButton *shadowButton;

@property(nonatomic,strong)NSArray<LXCCityGroupsModel *> *cityGroups;

@property(nonatomic,strong)LXCSearchViewControllerTableViewController *searchVc;

@end

static NSString *cellID = @"cellID";

@implementation LXCSearchCityControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"切换城市";
    
    [self setupNav];
    
    [self setupUI];
}

-(void)setupUI {
    
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.backgroundImage = [UIImage imageNamed:@"bg_login_textfield"];
    self.searchBar.placeholder = @"请输入城市名称";
    [self.view addSubview:self.searchBar];
    
    self.tableView = [UITableView new];
    [self.view addSubview:self.tableView];
    
    self.shadowButton = [UIButton new];
    [self.view addSubview:self.shadowButton];
    self.shadowButton.backgroundColor = [UIColor blackColor];
    self.shadowButton.alpha = 0.3;
    self.shadowButton.hidden = YES;
    [self.shadowButton addTarget:self action:@selector(clickShadowButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addChildViewController:self.searchVc];
    [self.view addSubview:self.searchVc.tableView];
    [self.searchVc didMoveToParentViewController:self];
    self.searchVc.view.hidden = YES;
    
    //布局
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(15);
        make.right.offset(-15);
        make.height.offset(44);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
        make.top.equalTo(self.searchBar.mas_bottom).offset(15);
    }];
    [self.shadowButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.tableView);
    }];
    [self.searchVc.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.tableView);
    }];
    //代理
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.searchBar.delegate = self;
    
    //注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    
    //设置索引栏字体颜色
    self.tableView.sectionIndexColor = LXCHomeColor(87, 186, 175);
    
    //设置消除按钮颜色
    self.searchBar.tintColor = LXCHomeColor(87, 186, 175);;
}

-(void)setupNav {
    UIBarButtonItem *dismissItem = [UIBarButtonItem barBuutonItemWithTarget:self action:@selector(dismissView) icon:@"btn_navigation_close" highlighticon:@"btn_navigation_close_hl"];
    
    self.navigationItem.leftBarButtonItem = dismissItem;
}

-(void)dismissView {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)clickShadowButton:(UIButton *)sender {
    
    [self didEndEditing];
    
}

#pragma mark - UISearchBarDelegate

//开始编辑文本
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    //隐藏导航栏
    self.navigationController.navigationBarHidden = YES;
    
    //显示删除按钮
    searchBar.showsCancelButton = YES;
    
    //修改背景图片
    searchBar.backgroundImage = [UIImage imageNamed:@"bg_login_textfield_hl"];
    
    //显示罩层
    self.shadowButton.hidden = NO;
    
}

//点击取消按钮
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    [self didEndEditing];
    
    //清空搜索栏
    self.searchBar.text = nil;
    
    //隐藏搜索展示栏
    self.searchVc.view.hidden = YES;
    
}

-(void)didEndEditing {
    
    //显示导航栏
    self.navigationController.navigationBarHidden = NO;
    
    //隐藏删除按钮
    self.searchBar.showsCancelButton = NO;
    
    //修改背景图片
    self.searchBar.backgroundImage = [UIImage imageNamed:@"bg_login_textfield"];
    
    //隐藏罩层
    self.shadowButton.hidden = YES;
    
    //取消编辑
    [self.searchBar endEditing:YES];
}

//内容改变调用
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    
    //判断是否有内容
    if (searchBar.text.length) {
        self.searchVc.view.hidden = NO;
        [self.searchVc searchWithStr:searchText];
    } else {
        self.searchVc.view.hidden = YES;
    }
    
}


#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cityGroups.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cityGroups[section].cities.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.textLabel.text = self.cityGroups[indexPath.section].cities[indexPath.row];
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.cityGroups[section].title;
}

-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [self.cityGroups valueForKey:@"title"];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //选择的城市发送通知
    [LXCNoteCenter postNotificationName:LXCCityDidChangeNote object:nil userInfo:@{LXCCityDidChangeNoteCityName:self.cityGroups[indexPath.section].cities[indexPath.row]}];
    
    //移除控制器
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 懒加载控件
-(NSArray<LXCCityGroupsModel *> *)cityGroups {
    
    if (!_cityGroups) {
        LXCHomeViewController *homeVc = [UIApplication sharedApplication].keyWindow.rootViewController.childViewControllers[0];
        _cityGroups = homeVc.citygroupDataArr;
    }
    
    return _cityGroups;
    
}

-(LXCSearchViewControllerTableViewController *)searchVc {
    if (!_searchVc) {
        _searchVc = [LXCSearchViewControllerTableViewController new];
    }
    
    return _searchVc;
}


@end
