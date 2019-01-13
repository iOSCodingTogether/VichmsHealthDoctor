//
//  VHDTabbarVC.m
//  Doctor
//
//  Created by zt on 2019/1/4.
//  Copyright © 2019年 AnyOne. All rights reserved.
//

#import "VHDTabbarVC.h"
#pragma mark - views
#import "ChatHomeVC.h"
#import "PersonalSettingVC.h"
#import "BookingVC.h"
#import "MyServiceVC.h"
#import "AccompanyVC.h"
#import "LFNavigationController.h"
#import "BookingExpertVC.h"

#pragma mark - utils
#import "UserInfoManager.h"

@interface VHDTabbarVC ()

@end

@implementation VHDTabbarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 医生
    [self initTabbar];
}

- (void)initTabbar {
    // 首页
    ChatHomeVC *homeVC = [ChatHomeVC new];
    UINavigationController *homeNaVC = [[UINavigationController alloc] initWithRootViewController:homeVC];
    UITabBarItem *homeItem = [[UITabBarItem alloc] initWithTitle:@"首页"
                                                           image:[[UIImage imageNamed:@"home_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                   selectedImage:[[UIImage imageNamed:@"home_highlight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    homeNaVC.tabBarItem = homeItem;
    
    // 我的预约
    BookingVC *bookingVC = [BookingVC new];
    LFNavigationController *bookingNaVC = [[LFNavigationController alloc] initWithRootViewController:bookingVC];
    UITabBarItem *bookingItem = [[UITabBarItem alloc] initWithTitle:@"我的预约"
                                                              image:[[UIImage imageNamed:@"booking_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                      selectedImage:[[UIImage imageNamed:@"booking_highlight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    bookingNaVC.tabBarItem = bookingItem;
    
    // 预约专家
    BookingExpertVC *bookingExpertVC = [BookingExpertVC new];
    LFNavigationController *bookingExpertNaVC = [[LFNavigationController alloc] initWithRootViewController:bookingExpertVC];
    UITabBarItem *bookingIExperitem = [[UITabBarItem alloc] initWithTitle:@"预约专家"
                                                                    image:[[UIImage imageNamed:@"booking_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                            selectedImage:[[UIImage imageNamed:@"booking_highlight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    bookingExpertNaVC.tabBarItem = bookingIExperitem;
    
    // 我的服务
    MyServiceVC *serviceVC = [MyServiceVC new];
    LFNavigationController *serviceNaVC = [[LFNavigationController alloc] initWithRootViewController:serviceVC];
    UITabBarItem *serviceItem = [[UITabBarItem alloc] initWithTitle:@"我的服务单"
                                                              image:[[UIImage imageNamed:@"service_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                      selectedImage:[[UIImage imageNamed:@"service_highlight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    serviceNaVC.tabBarItem = serviceItem;
    
    // 陪诊
    AccompanyVC *accompanyVC = [AccompanyVC new];
    LFNavigationController *accompanyNaVC = [[LFNavigationController alloc] initWithRootViewController:accompanyVC];
    UITabBarItem *accompanyItem = [[UITabBarItem alloc] initWithTitle:@"陪诊"
                                                                image:[[UIImage imageNamed:@"accompany_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                        selectedImage:[[UIImage imageNamed:@"accompany_highlight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    accompanyNaVC.tabBarItem = accompanyItem;
    
    // 个人设置
    PersonalSettingVC *settingVC = [PersonalSettingVC new];
    LFNavigationController *settingNaVC = [[LFNavigationController alloc] initWithRootViewController:settingVC];
    UITabBarItem *settingItem = [[UITabBarItem alloc] initWithTitle:@"个人设置"
                                                              image:[[UIImage imageNamed:@"setting_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                      selectedImage:[[UIImage imageNamed:@"setting_highlight"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    settingNaVC.tabBarItem = settingItem;
    
    NSMutableArray *tabBarVCArr = [NSMutableArray array];
    
    if ([UserInfoManager shareInstance].returnUserType == UserType_Doctor) {
        // 医生
        [tabBarVCArr addObjectsFromArray:@[bookingNaVC, serviceNaVC, settingNaVC]];
    } else if ([UserInfoManager shareInstance].returnUserType == UserType_Accompany) {
        // 陪诊
        [tabBarVCArr addObjectsFromArray:@[accompanyNaVC, settingNaVC]];
    } else if ([UserInfoManager shareInstance].returnUserType == UserType_Service) {
        // 客服
        [tabBarVCArr addObjectsFromArray:@[bookingNaVC, bookingExpertNaVC, accompanyNaVC, settingNaVC]];
    }
   
    self.viewControllers = tabBarVCArr;
}

@end
