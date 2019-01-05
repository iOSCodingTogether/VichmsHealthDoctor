//
//  BaseTabBarViewController.m
//  XiangjianiOS
//
//  Created by  licc on 2018/8/1.
//  Copyright © 2018年 AnyOne. All rights reserved.
//

#import "BaseTabBarViewController.h"
#import "BaseNavViewController.h"
#import "UIColor+CCategory.h"

@interface BaseTabBarViewController ()

@end

@implementation BaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self initTabBarcontrollers];
    self.tabBar.backgroundColor = [UIColor whiteColor];
    self.tabBar.translucent = NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
