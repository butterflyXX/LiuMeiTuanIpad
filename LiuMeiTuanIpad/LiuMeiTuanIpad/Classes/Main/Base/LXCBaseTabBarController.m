//
//  LXCBaseTabBarController.m
//  LiuMeiTuanIpad
//
//  Created by 刘晓晨 on 2017/5/17.
//  Copyright © 2017年 刘晓晨. All rights reserved.
//

#import "LXCBaseTabBarController.h"
#import "LXCHomeViewController.h"
#import "LXCBaseNavigationController.h"

@interface LXCBaseTabBarController ()

@end

@implementation LXCBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    LXCHomeViewController *rootVc = [LXCHomeViewController new];
    
    LXCBaseNavigationController *nav = [[LXCBaseNavigationController alloc] initWithRootViewController:rootVc];
    
    [self addChildViewController:nav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
