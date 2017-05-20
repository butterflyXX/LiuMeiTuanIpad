//
//  LXCSortController.m
//  LiuMeiTuanIpad
//
//  Created by 刘晓晨 on 2017/5/20.
//  Copyright © 2017年 刘晓晨. All rights reserved.
//

#import "LXCSortController.h"
#import <YYModel.h>
#import "LXCSortModel.h"
#import "UIView+HMCategory.h"

@interface LXCSortController ()

@property(nonatomic,strong)NSArray *sortArray;

@end

@implementation LXCSortController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //1. 加载 plist 文件, 转模型
    NSArray *sortPlist = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"sorts.plist" ofType:nil]];
    
    self.sortArray = [NSArray yy_modelArrayWithClass:[LXCSortModel class] json:sortPlist];
    
    //2. 循环创建7个按钮
    NSInteger count = self.sortArray.count;
    
    // frame
    CGFloat width = 100;
    CGFloat height = 30;
    CGFloat margin = 15;
    
    // 创建按钮
    for (int i = 0; i < count; i++) {
        // 初始化
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        // 取出sort模型数据
        LXCSortModel *sortModel = self.sortArray[i];
        
        // 设置标题
        [button setTitle:sortModel.label forState:UIControlStateNormal];
        
        // 设置文字颜色
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        // 设置背景图片
        [button setBackgroundImage:[UIImage imageNamed:@"btn_filter_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"btn_filter_selected"] forState:UIControlStateHighlighted];
        
        // 设置frame
        button.width = width;
        button.height = height;
        button.x = margin;
        button.y = margin + (button.height + margin) * i;
        
        // 绑定tag --> 区分点击了哪一个按钮
        button.tag = i;
        
        // 添加方法
        [button addTarget:self action:@selector(sortButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:button];
    }
    
    //3. 设置 popover 大小
    CGFloat contentWidth = 2 * margin + width;
    CGFloat contentHeight = (margin + height) * count + margin;
    self.preferredContentSize = CGSizeMake(contentWidth, contentHeight);
}


#pragma mark 按钮点击方法
- (void)sortButtonClick:(UIButton *)button
{
    // 发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:LXCSortDidChangeNote object:nil userInfo:@{LXCSortDidChangeNoteModelKey : self.sortArray[button.tag]}];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}@end
