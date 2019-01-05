//
//  AppDelegate.m
//  Doctor
//
//  Created by  licc on 2018/8/21.
//  Copyright © 2018年 AnyOne. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseTabBarViewController.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "LoginVC.h"
#import "VHDTabbarVC.h"
#import "UserInfoManager.h"
#import <NIMSDK/NIMSDK.h>
#import "MBProgressHUD+SimpleLoad.h"

@interface AppDelegate () <NIMLoginManagerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

#if DEBUG
    [[NSBundle bundleWithPath:@"/Applications/InjectionIII.app/Contents/Resources/iOSInjection10.bundle"] load];
#endif
    
    // 键盘配置
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    // 云信配置
    NIMSDKOption *option = [NIMSDKOption optionWithAppKey:@"47a23dbd2d737a031570d5a153a04a4e"];
    [[NIMSDK sharedSDK] registerWithOption:option];
    
    // 初始化UI
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    if ([UserInfoManager shareInstance].user) {
        // 自动登录云信
        [[[NIMSDK sharedSDK] loginManager] autoLogin:[UserInfoManager shareInstance].user.accid
                                               token:[UserInfoManager shareInstance].user.tokenyx];
        
        VHDTabbarVC *tabVC = [[VHDTabbarVC alloc] init];
        self.window.rootViewController = tabVC;
    } else {
        self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[LoginVC new]];
    }
    
    [self.window makeKeyAndVisible];

    
    return YES;
}

#pragma mark - 云信
// 云信自动登录失败回调
- (void)onAutoLoginFailed:(NSError *)error {
    if (!error) {
        return;
    }
    
    [MBProgressHUD showLoadingWithTitle:@"账号异常，请重新登录"];
    [UIApplication sharedApplication].delegate.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[LoginVC new]];
    [[UserInfoManager shareInstance] logoutUser];
}

// 被踢的回调
- (void)onKick:(NIMKickReason)code clientType:(NIMLoginClientType)clientType {
    [MBProgressHUD showLoadingWithTitle:@"账号在其他设备登录，请重新登录"];
    [UIApplication sharedApplication].delegate.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[LoginVC new]];
    [[UserInfoManager shareInstance] logoutUser];
}

// 当用户在某个客户端登录时，其他没有被踢掉的端会触发回调:
- (void)onMultiLoginClientsChanged {
    
}

#pragma mark - 系统
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options NS_AVAILABLE_IOS(9_0){
    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
