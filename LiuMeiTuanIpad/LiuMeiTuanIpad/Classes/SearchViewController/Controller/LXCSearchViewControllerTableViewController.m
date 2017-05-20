//
//  LXCSearchViewControllerTableViewController.m
//  LiuMeiTuanIpad
//
//  Created by 刘晓晨 on 2017/5/19.
//  Copyright © 2017年 刘晓晨. All rights reserved.
//

#import "LXCSearchViewControllerTableViewController.h"
#import "LXCHomeViewController.h"

@interface LXCSearchViewControllerTableViewController ()

@property(nonatomic,strong)NSMutableArray<LXCCityModel *> *searchRes;

@end

@implementation LXCSearchViewControllerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

-(void)searchWithStr:(NSString *)str {
    
    //清空结果集
    self.searchRes = nil;
    
    //转换为小写
    str = [str lowercaseString];
    
    //获取homeVc
    LXCHomeViewController *homeVc = [UIApplication sharedApplication].keyWindow.rootViewController.childViewControllers[0];
    
    for (LXCCityModel *cityModel in homeVc.districtDataArr) {
        //查询
        if ([cityModel.name containsString:str] || [cityModel.pinYin containsString:str] || [cityModel.pinYinHead containsString:str]) {
            [self.searchRes addObject:cityModel];
        }
    }
    
    //刷新列表
    [self.tableView reloadData];
    
}

-(NSMutableArray *)searchRes {
    if (!_searchRes) {
        _searchRes = [NSMutableArray new];
    }
    
    return _searchRes;
}

#pragma mark - 代理数据源方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchRes.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LXCCityModel *model = self.searchRes[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = model.name;
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"查询到%zd条结果",self.searchRes.count];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //选择的城市发送通知
    [LXCNoteCenter postNotificationName:LXCCityDidChangeNote object:nil userInfo:@{LXCCityDidChangeNoteCityName:self.searchRes[indexPath.row].name}];
    
    //移除控制器
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
