//
//  LXCHomeViewController.m
//  LiuMeiTuanIpad
//
//  Created by 刘晓晨 on 2017/5/17.
//  Copyright © 2017年 刘晓晨. All rights reserved.
//

#import "LXCHomeViewController.h"
#import "UIBarButtonItem+HMCategory.h"
#import "LXCHomeNavItem.h"
#import "LXCCategoryViewController.h"
#import "UIView+HMCategory.h"
#import <YYModel.h>
#import "LXCCategoryModel.h"
#import "LXCDistrictViewController.h"
#import "LXCCityModel.h"

@interface LXCHomeViewController ()

@property(nonatomic,strong)NSArray<LXCCategoryModel *> *categoryDataArr;
@property(nonatomic,strong)NSArray *districtDataArr;
@property(nonatomic,copy)NSString *currenCity;

@end

@implementation LXCHomeViewController

- (instancetype)init
{
    self = [super initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    if (self) {
        self.collectionView.backgroundColor = LXCHomeColor(228, 228, 228);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNav];
    
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupNav {
    
//    UIButton *mapBUtton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [mapBUtton setImage:[UIImage imageNamed:@"icon_map_highlighted"] forState:UIControlStateHighlighted];
//    [mapBUtton setImage:[UIImage imageNamed:@"icon_map"] forState:UIControlStateNormal];
//    
//    mapBUtton.frame = CGRectMake(0, 0, 40, 40);
    
    UIBarButtonItem *mapItem = [UIBarButtonItem barBuutonItemWithTarget:self action:@selector(mapClick) icon:@"icon_map" highlighticon:@"icon_map_highlighted"];
    
     UIBarButtonItem *sreachItem = [UIBarButtonItem barBuutonItemWithTarget:self action:@selector(searchClick) icon:@"icon_search" highlighticon:@"icon_search_highlighted"];
    
    self.navigationItem.rightBarButtonItems = @[mapItem,sreachItem];
    
    //logoItem
    UIBarButtonItem *logoItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_meituan_logo"] style:UIBarButtonItemStylePlain target:self action:nil];
    
    //禁用logoItem的响应事件
    logoItem.enabled = NO;
    
    //设置分类,区域,排序
    LXCHomeNavItem *categoryView = [LXCHomeNavItem homeNav];
    [categoryView addTarget:self action:@selector(categoryClick) forControlEvents:UIControlEventTouchUpInside];
    categoryView.titleStr = @"全部分类";
    categoryView.subTitleStr = nil;
    categoryView.imageName = @"icon_category_-1";
    categoryView.hightLightedImageName = @"icon_category_highlighted_-1";
    UIBarButtonItem *categoryItem = [[UIBarButtonItem alloc] initWithCustomView:categoryView];
    
    LXCHomeNavItem *districtView = [LXCHomeNavItem homeNav];
    [districtView addTarget:self action:@selector(districtClick) forControlEvents:UIControlEventTouchUpInside];
    districtView.titleStr = @"北京分类";
    districtView.subTitleStr = nil;
    districtView.imageName = @"icon_district";
    districtView.hightLightedImageName = @"icon_district_highlighted";
    UIBarButtonItem *districtItem = [[UIBarButtonItem alloc] initWithCustomView:districtView];
    
    LXCHomeNavItem *sortView = [LXCHomeNavItem homeNav];
    [sortView addTarget:self action:@selector(sortClick) forControlEvents:UIControlEventTouchUpInside];
    sortView.titleStr = @"排序";
    sortView.subTitleStr = @"默认排序";
    sortView.imageName = @"icon_sort";
    sortView.hightLightedImageName = @"icon_sort_highlighted";
    UIBarButtonItem *sortItem = [[UIBarButtonItem alloc] initWithCustomView:sortView];
    
    //添加item
    self.navigationItem.leftBarButtonItems = @[logoItem,categoryItem,districtItem,sortItem];
    
}

//地图按钮
-(void)mapClick {
    LxcLog(@"点击地图了");
}

//搜索按钮
-(void)searchClick {
    LxcLog(@"点击搜索了");
    
}

//点击分类按钮
-(void)categoryClick {
    LxcLog(@"点击分类了");
    
    //跳转category控制器(popover)
    LXCCategoryViewController *categoryVc = [LXCCategoryViewController new];
    categoryVc.categoryArr = self.categoryDataArr;
    categoryVc.modalPresentationStyle = UIModalPresentationPopover;
    
    UIPopoverPresentationController *popover = categoryVc.popoverPresentationController;
    
    //设置参考视图
    popover.barButtonItem = self.navigationItem.leftBarButtonItems[1];
    
    //设置大小
    categoryVc.preferredContentSize = CGSizeMake(categoryVc.popoverView.width, categoryVc.popoverView.height);
    
    [self presentViewController:categoryVc animated:YES completion:nil];
    
}

//点击区域按钮
-(void)districtClick {
    
    //跳转category控制器(popover)
    LXCDistrictViewController *districtVc = [LXCDistrictViewController new];
    districtVc.city = [self cityWithCityName:self.currenCity];
    districtVc.modalPresentationStyle = UIModalPresentationPopover;
    
    UIPopoverPresentationController *popover = districtVc.popoverPresentationController;
    
    //设置参考视图
    popover.barButtonItem = self.navigationItem.leftBarButtonItems[2];
    
    //设置大小
    districtVc.preferredContentSize = CGSizeMake(districtVc.popoverView.width, CGRectGetMaxY(districtVc.popoverView.frame));
    
    [self presentViewController:districtVc animated:YES completion:nil];
    
}

//点击排序按钮
-(void)sortClick {
    LxcLog(@"点击排序了");
}

-(void)loadData {
    
    //解析category数据
    NSString *categoryPath = [[NSBundle mainBundle] pathForResource:@"categories.plist" ofType:nil];
    NSArray *categoryTempArr = [NSArray arrayWithContentsOfFile:categoryPath];
    self.categoryDataArr = [NSArray yy_modelArrayWithClass:[LXCCategoryModel class] json:categoryTempArr];
    
    //解析city数据
    NSString *cityPath = [[NSBundle mainBundle] pathForResource:@"cities.plist" ofType:nil];
    NSArray *cityTempArr = [NSArray arrayWithContentsOfFile:cityPath];
    self.districtDataArr = [NSArray yy_modelArrayWithClass:[LXCCityModel class] json:cityTempArr];
    
    self.currenCity = @"北京";
    
}

//根据城市名称返回数城市数据
-(LXCCityModel *)cityWithCityName:(NSString *)cityName {
    
    for (LXCCityModel *cityModel in self.districtDataArr) {
        
        if ([cityName isEqualToString:cityModel.name]) {
            return cityModel;
        }
    }
    
    return nil;
}


@end









