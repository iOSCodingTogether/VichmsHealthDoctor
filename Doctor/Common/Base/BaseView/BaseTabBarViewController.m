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
#ifdef DEBUG

    UIImageView *imageview= [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];;
    imageview.alpha= 0.3;
    [self.view addSubview:imageview];
    imageview.animationImages = @[[UIColor whiteColor].createImage,[UIColor blueColor].createImage];
    [imageview startAnimating];

#endif
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
