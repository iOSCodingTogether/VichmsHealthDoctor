//
//  LFNavigationController.m
//  LoveLimitFree
//
//  Created by andezhou on 15/9/8.
//  Copyright (c) 2015年 周安德. All rights reserved.
//

#import "LFNavigationController.h"
#import "UIBarButtonItem+Helper.h"
//#import "UIImage+Helper.h"

@interface LFNavigationController ()

@end

@implementation LFNavigationController

// nav的设置只需要设置一次即可， 保证只初始化一次
+ (void)initialize {
    // 获取UINavigationBar
    UINavigationBar *navBar = [UINavigationBar appearance];
    // 设置navBar背景图片
    //    [navBar setBackgroundImage:[UIImage imageNamed:@"nav"]  forBarMetrics:UIBarMetricsDefault];
    //     设置navBar的背景颜色
    [navBar setTintColor:[UIColor whiteColor]];
    //    [navBar setBarTintColor:HEXCOLOR(0x0586E8)];
    
    
    //去除导航栏下方的横线
    [navBar setShadowImage:[UIImage new]];
    
    
    //  设置导航栏标题颜色为白色
    [navBar setTitleTextAttributes:@{
                                     NSForegroundColorAttributeName : [UIColor blackColor],
                                     NSFontAttributeName : [UIFont systemFontOfSize:18]
                                     }];
    
    
    
    //获取UIBarButtonItem
    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    
    // 设置导航栏按钮文字常规效果
    [barItem setTitleTextAttributes:@{
                                      NSForegroundColorAttributeName : [UIColor blackColor],
                                      NSFontAttributeName : [UIFont systemFontOfSize:17]
                                      } forState:UIControlStateNormal];
    //    // 设置导航栏按钮文字的高亮效果
    [barItem setTitleTextAttributes:@{
                                      NSForegroundColorAttributeName : [UIColor blackColor],
                                      NSFontAttributeName : [UIFont systemFontOfSize:17],
                                      
                                      } forState:UIControlStateHighlighted];
    
    // 设置导航栏返回按钮的背景图片
    //    [barItem setBackButtonBackgroundImage:[UIImage imageNamed:@"buttonbar_back"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    //    [barItem setBackButtonBackgroundImage:[UIImage imageNamed:@"buttonbar_back"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


// 重写push方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断是否为根据控制器，如果不是跟控制器酒把tabBar隐藏并添加返回按钮
     if (self.viewControllers.count) {
         // 隐藏TabBar
         viewController.hidesBottomBarWhenPushed = YES;
        
         UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithTitle:@"" backgroundImage:[UIImage imageNamed:@"blackBack"] target:self action:@selector(backAction)];

         viewController.navigationItem.leftBarButtonItem = leftBtn;

     }
    
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)childViewControllerForStatusBarStyle{
    return self.visibleViewController;
}



- (void)backAction {
//    [self.navigationController popViewControllerAnimated:YES];
    [self popViewControllerAnimated:YES];
}


- (void)backToAction {
    [self popToRootViewControllerAnimated:YES];
}

- (void)dealloc {
    
}
@end
