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

#import "LXCDistrictViewController.h"
#import "LXCSortController.h"
#import "LXCSortModel.h"
#import "LXCDealCell.h"
#import "AwesomeMenu.h"
#import "LXCDetailViewController.h"


@interface LXCHomeViewController ()<DPRequestDelegate,AwesomeMenuDelegate>

@property(nonatomic,copy)NSString *currenCity;
@property(nonatomic,copy)NSString *currendistrict;
@property(nonatomic,copy)NSString *currencategory;
@property(nonatomic,strong)NSNumber *currenSort;
@property(nonatomic,strong)NSArray *dataArr;
@property(nonatomic,weak)AwesomeMenu *awesomeMenu;

@end

static NSString * const reuseIdentifier = @"dealCell";

@implementation LXCHomeViewController

- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(LXCDealCellWidth, LXCDealCellWidth);
    
    self = [super initWithCollectionViewLayout:layout];
    
    if (self) {
        self.collectionView.backgroundColor = LXCHomeColor(228, 228, 228);
    
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"LXCDealCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self setupNav];
    
    [self loadData];
    
    [self addObserver];
    
    [self setAwesomeMenu];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setAwesomeMenu {
    
    //startItem
    AwesomeMenuItem *startItem = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"icon_pathMenu_background_normal"] highlightedImage:[UIImage imageNamed:@"icon_pathMenu_background_highlighted"] ContentImage:[UIImage imageNamed:@"icon_pathMenu_mainMine_normal"] highlightedContentImage:[UIImage imageNamed:@"icon_pathMenu_mainMine_highlighted"]];
    
    //2. 添加其他几个按钮
    AwesomeMenuItem *item0 = [[AwesomeMenuItem alloc]
                              initWithImage:[UIImage imageNamed:@"bg_pathMenu_black_normal"]
                              highlightedImage:nil
                              ContentImage:[UIImage imageNamed:@"icon_pathMenu_mainMine_normal"]
                              highlightedContentImage:[UIImage imageNamed:@"icon_pathMenu_mainMine_highlighted"]];
    
    AwesomeMenuItem *item1 = [[AwesomeMenuItem alloc]
                              initWithImage:[UIImage imageNamed:@"bg_pathMenu_black_normal"]
                              highlightedImage:nil
                              ContentImage:[UIImage imageNamed:@"icon_pathMenu_collect_normal"]
                              highlightedContentImage:[UIImage imageNamed:@"icon_pathMenu_collect_highlighted"]];
    
    AwesomeMenuItem *item2 = [[AwesomeMenuItem alloc]
                              initWithImage:[UIImage imageNamed:@"bg_pathMenu_black_normal"]
                              highlightedImage:nil
                              ContentImage:[UIImage imageNamed:@"icon_pathMenu_scan_normal"]
                              highlightedContentImage:[UIImage imageNamed:@"icon_pathMenu_scan_highlighted"]];
    
    AwesomeMenuItem *item3 = [[AwesomeMenuItem alloc]
                              initWithImage:[UIImage imageNamed:@"bg_pathMenu_black_normal"]
                              highlightedImage:nil
                              ContentImage:[UIImage imageNamed:@"icon_pathMenu_more_normal"]
                              highlightedContentImage:[UIImage imageNamed:@"icon_pathMenu_more_highlighted"]];
    
    NSArray *items = @[item0, item1, item2, item3];
    
    AwesomeMenu *awesomeMenu = [[AwesomeMenu alloc] initWithFrame:CGRectZero startItem:startItem menuItems:items];
    awesomeMenu.menuWholeAngle = M_PI_2;
    awesomeMenu.rotateAddButton = NO;
    awesomeMenu.delegate = self;
    awesomeMenu.alpha = 0.5;
    [self.view addSubview:awesomeMenu];
    
    self.awesomeMenu = awesomeMenu;
}

//开始awesomeMenu
- (void)awesomeMenuWillAnimateOpen:(AwesomeMenu *)menu {
    
    menu.startButton.contentImageView.image = [UIImage imageNamed:@"icon_pathMenu_cross_normal"];
    menu.startButton.contentImageView.highlightedImage = [UIImage imageNamed:@"icon_pathMenu_cross_highlighted"];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.awesomeMenu.alpha = 1;
    }];
}
//结束awesomeMenu
- (void)awesomeMenuWillAnimateClose:(AwesomeMenu *)menu {
    
    menu.startButton.contentImageView.image = [UIImage imageNamed:@"icon_pathMenu_mainMine_normal"];
    menu.startButton.contentImageView.highlightedImage = [UIImage imageNamed:@"icon_pathMenu_mainMine_highlighted"];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.awesomeMenu.alpha = 0.5;
    }];
}

-(void)addObserver {
    
    //城市改变
    [LXCNoteCenter addObserver:self selector:@selector(changeCity:) name:LXCCityDidChangeNote object:nil];
    
    //分类改变
    [LXCNoteCenter addObserver:self selector:@selector(changeCategory:) name:LXCCategoryDidChangeNote object:nil];
    
    //区域改变
    [LXCNoteCenter addObserver:self selector:@selector(changeDistrict:) name:LXCDistrictDidChangeNote object:nil];
    
    //排序方式改变
    [LXCNoteCenter addObserver:self selector:@selector(changeSort:) name:LXCSortDidChangeNote object:nil];
    
    //监听屏幕方向
    [LXCNoteCenter addObserver:self selector:@selector(orientationDidChanged) name:UIDeviceOrientationDidChangeNotification object:nil];
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
    districtView.titleStr = @"北京-分类";
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
    
    //跳转category控制器(popover)
    LXCSortController *sortVc = [LXCSortController new];
    
    sortVc.modalPresentationStyle = UIModalPresentationPopover;
    
    UIPopoverPresentationController *popover = sortVc.popoverPresentationController;
    
    //设置参考视图
    popover.barButtonItem = self.navigationItem.leftBarButtonItems[3];
    
    //设置大小
//    districtVc.preferredContentSize = CGSizeMake(districtVc.popoverView.width, CGRectGetMaxY(districtVc.popoverView.frame));
    
    [self presentViewController:sortVc animated:YES completion:nil];
    
}

#pragma mark - 监听事件
-(void)changeCity:(NSNotification *)noti {
    
    //城市item跟着变化
    LXCHomeNavItem *cityItem = self.navigationItem.leftBarButtonItems[2].customView;
    cityItem.titleStr = [NSString stringWithFormat:@"%@-全部",noti.userInfo[LXCCityDidChangeNoteCityName]];
    
    //记录当前城市
    self.currenCity = noti.userInfo[LXCCityDidChangeNoteCityName];
    
    [self requestData];
    
}

-(void)changeCategory:(NSNotification *)noti {
    
    //获取一级分类
    LXCCategoryModel *category = noti.userInfo[LXCCategoryDidChangeNoteModelKey];
    
    //获取二级分类
    NSString *subTitle = noti.userInfo[LXCCategoryDidChangeNoteSubtitleKey];
    
    //改变item
    LXCHomeNavItem *categoryView = self.navigationItem.leftBarButtonItems[1].customView;
    categoryView.titleStr = category.name;
    categoryView.subTitleStr = [subTitle isEqualToString:@"全部"]?nil:subTitle;

    //记录当前的分类
    if ([category.name isEqualToString:@"全部"]) {
        //不需要传递参数
        self.currencategory = nil;
    } else if (subTitle == nil || [subTitle isEqualToString:@"全部"]) {
        
        //传递一级菜单
        self.currencategory = category.name;
    } else {
        
        //传递二级菜单
        self.currencategory = subTitle;
    }
    
    [self requestData];
}

-(void)changeDistrict:(NSNotification *)noti {
    
    //获取一级分类
    LXCDistrictModel *district = noti.userInfo[LXCDistrictDidChangeNoteModelKey];
    
    //获取二级分类
    NSString *subTitle = noti.userInfo[LXCDistrictDidChangeNoteSubtitleKey];
    
    //改变item
    LXCHomeNavItem *categoryView = self.navigationItem.leftBarButtonItems[2].customView;
    categoryView.titleStr = [NSString stringWithFormat:@"%@-%@",self.currenCity,district.name];
    categoryView.subTitleStr = [subTitle isEqualToString:@"全部"]?nil:subTitle;
    
    //记录当前的分类
    if ([district.name isEqualToString:@"全部"]) {
        //不需要传递参数
        self.currendistrict = nil;
    } else if (subTitle == nil || [subTitle isEqualToString:@"全部"]) {
        
        //传递一级菜单
        self.currendistrict = district.name;
    } else {
        
        //传递二级菜单
        self.currendistrict = subTitle;
    }
    
    [self requestData];
    
}

-(void)changeSort:(NSNotification *)noti {
    
    LXCSortModel *sortModel = noti.userInfo[LXCSortDidChangeNoteModelKey];
    
    LXCHomeNavItem *sortView = self.navigationItem.leftBarButtonItems[3].customView;
    
    sortView.subTitleStr = sortModel.label;
    
    //记录当前排序方式
    self.currenSort = sortModel.value;
    
    [self requestData];
    
}

-(void)orientationDidChanged {
    
    //判断列数
    int columCount = UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation)?2:3;
    
    //判断间隙
    CGFloat margin = (LXCRealScreenWidth - LXCDealCellWidth * columCount)/(columCount + 1);
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
    
    //设置行间距
    layout.minimumLineSpacing = margin;
    
    //设置内边距
    layout.sectionInset = UIEdgeInsetsMake(margin, margin, margin, margin);
    
    //修改awesomeMenu的位置
    self.awesomeMenu.startPoint = CGPointMake(80, LXCRealScreenHeight - 80 - LXCNavigationBarHeight);
    
}

-(void)loadData {
    
    //解析category数据
    NSString *categoryPath = [[NSBundle mainBundle] pathForResource:@"categories.plist" ofType:nil];
    NSArray *categoryTempArr = [NSArray arrayWithContentsOfFile:categoryPath];
    _categoryDataArr = [NSArray yy_modelArrayWithClass:[LXCCategoryModel class] json:categoryTempArr];
    
    //解析city数据
    NSString *cityPath = [[NSBundle mainBundle] pathForResource:@"cities.plist" ofType:nil];
    NSArray *cityTempArr = [NSArray arrayWithContentsOfFile:cityPath];
    _districtDataArr = [NSArray yy_modelArrayWithClass:[LXCCityModel class] json:cityTempArr];
    
    self.currenCity = @"北京";
    
    //解析cityGroup数据
    NSString *cityGroupPath = [[NSBundle mainBundle] pathForResource:@"cityGroups.plist" ofType:nil];
    NSArray *dictArr = [NSArray arrayWithContentsOfFile:cityGroupPath];
    _citygroupDataArr = [NSArray yy_modelArrayWithClass:[LXCCityGroupsModel class] json:dictArr];
    
    [self requestData];
    
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

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LXCDealCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.dealModel = self.dataArr[indexPath.row];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LXCDetailViewController *detilVc = [LXCDetailViewController new];
    
    detilVc.dealModel = self.dataArr[indexPath.row];
    
    [self presentViewController:detilVc animated:YES completion:nil];
}

-(void)requestData {
    
    //设置参数
    NSMutableDictionary *param = [NSMutableDictionary new];
    
    //设置城市 必须设置
    [param setValue:self.currenCity forKey:@"city"];
    //设置分类
    if (self.currencategory != nil) { //设置了分类
        
        [param setValue:self.currencategory forKey:@"category"];
    }
    //设置区域
    if (self.currendistrict != nil) {
        
        [param setValue:self.currendistrict forKey:@"region"];
    }
    //设置排序
    [param setValue:self.currenSort forKey:@"sort"];
    
    //发送请求
    [[DPAPI new] requestWithURL:@"v1/deal/find_deals" params:param delegate:self];
    
    
}

//获取收失败
- (void)request:(DPRequest *)request didFailWithError:(NSError *)error {
    LxcLog(@"获取数据失败");
}

//获取数据成功
- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result {
    
    //返回的是json数据
    NSArray *dictArr = result[@"deals"];
    //字典转模型
    self.dataArr = [NSArray yy_modelArrayWithClass:[LXCDealModel class] json:dictArr];
    //刷新界面
    [self.collectionView reloadData];
}

#pragma mark - 懒加载
-(NSNumber *)currenSort {
    if (!_currenSort) {
        _currenSort = @1;
    }
    
    return _currenSort;
}


@end









