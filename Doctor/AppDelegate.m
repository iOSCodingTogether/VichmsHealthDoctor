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
#import "VHDChatDataManger.h"
#import "VHDChatCellLayoutConfig.h"
#import "NSDictionary+NTESJson.h"
#import "NTESTeamMeetingCalleeInfo.h"
#import "NTESTeamMeetingCallingViewController.h"
#import "NTESTeamMeetingViewController.h"
#import "VHDChatSessionVC.h"
#import <UserNotifications/UserNotifications.h>
//#import "NTESCustomNotificationObject.h"
//#import "NTESCustomNotificationDB.h"
#define NTESNotifyID        @"id"
#define NTESCustomContent   @"content"
#define NTESTeamMeetingMembers   @"members"
#define NTESTeamMeetingTeamId    @"teamId"
#define NTESTeamMeetingTeamName  @"teamName"
#define NTESTeamMeetingName      @"room"

#define NTESCommandTyping   (1)
#define NTESCustom          (2)
#define NTESTeamMeetingCall (3)

@interface AppDelegate () <NIMLoginManagerDelegate,NIMSystemNotificationManagerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

#if DEBUG
    [[NSBundle bundleWithPath:@"/Applications/InjectionIII.app/Contents/Resources/iOSInjection10.bundle"] load];
#endif
    // 键盘配置
    IQKeyboardManager *keyManager = [IQKeyboardManager sharedManager];
    keyManager.enable = YES;
    keyManager.shouldResignOnTouchOutside = YES;
    keyManager.shouldToolbarUsesTextFieldTintColor = YES;
    keyManager.enableAutoToolbar = NO;
    keyManager.keyboardDistanceFromTextField = 60;
    [HYBNetworking updateBaseUrl:URL_HOST];
    // 云信配置
    NIMSDKOption *option = [NIMSDKOption optionWithAppKey:@"47a23dbd2d737a031570d5a153a04a4e"];
    [[NIMSDK sharedSDK] registerWithOption:option];
    [[NIMKit sharedKit] registerLayoutConfig:[VHDChatCellLayoutConfig new]];
    [[NIMSDK sharedSDK].systemNotificationManager addDelegate:self];
    [self registerPushService];
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

#pragma mark - NIMSystemNotificationManagerDelegate
- (void)onReceiveCustomSystemNotification:(NIMCustomSystemNotification *)notification{
    
    NSString *content = notification.content;
    NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
    if (data)
    {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                             options:0
                                                               error:nil];
        if ([dict isKindOfClass:[NSDictionary class]])
        {
            switch ([dict jsonInteger:@"id"]) {
                case NTESCustom:{
//                    //SDK并不会存储自定义的系统通知，需要上层结合业务逻辑考虑是否做存储。这里给出一个存储的例子。
//                    NTESCustomNotificationObject *object = [[NTESCustomNotificationObject alloc] initWithNotification:notification];
//                    //这里只负责存储可离线的自定义通知，推荐上层应用也这么处理，需要持久化的通知都走可离线通知
//                    if (!notification.sendToOnlineUsersOnly) {
//                        [[NTESCustomNotificationDB sharedInstance] saveNotification:object];
//                    }
//                    if (notification.setting.shouldBeCounted) {
//                        [[NSNotificationCenter defaultCenter] postNotificationName:NTESCustomNotificationCountChanged object:nil];
//                    }
//                    NSString *content  = [dict jsonString:NTESCustomContent];
//                    [MBProgressHUD showAlertWithView:self.window.rootViewController.view andTitle:content];
                }
                    break;
                case NTESTeamMeetingCall:{
                    if (![self shouldResponseBusy]) {
                        //繁忙的话，不回复任何信息，直接丢掉，让呼叫方直接走超时
                        NSTimeInterval sendTime = notification.timestamp;
                        NSTimeInterval nowTime  = [[NSDate date] timeIntervalSince1970];
                        if (nowTime - sendTime < 45)
                        {
                            //60 秒内，认为有效，否则丢弃
                            NTESTeamMeetingCalleeInfo *info = [[NTESTeamMeetingCalleeInfo alloc] init];
                            info.teamId  = [dict jsonString:NTESTeamMeetingTeamId];
                            info.members = [dict jsonArray:NTESTeamMeetingMembers];
                            info.meetingName = [dict jsonString:NTESTeamMeetingName];
                            info.teamName = [dict jsonString:NTESTeamMeetingTeamName];
                            
                            NTESTeamMeetingCallingViewController *vc = [[NTESTeamMeetingCallingViewController alloc] initWithCalleeInfo:info];
                            [self.window.rootViewController presentViewController:vc animated:YES completion:nil];
                        }
                    }
                }
                    break;
                default:
                    break;
            }
        }
    }
}
- (BOOL)shouldResponseBusy
{
    
//    return NO;
    
    VHDTabbarVC *tabVC = (VHDTabbarVC *)self.window.rootViewController;
    UINavigationController *nav = tabVC.selectedViewController;
    return [nav.topViewController isKindOfClass:[NTESTeamMeetingCallingViewController class]] ||
    [nav.topViewController isKindOfClass:[NTESTeamMeetingViewController class]] ||
    [tabVC.presentedViewController isKindOfClass:[NTESTeamMeetingCallingViewController class]] ||
    [tabVC.presentedViewController isKindOfClass:[NTESTeamMeetingViewController class]];
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

}
- (void)applicationDidEnterBackground:(UIApplication *)application {

}
- (void)applicationWillEnterForeground:(UIApplication *)application {

}
- (void)applicationDidBecomeActive:(UIApplication *)application {

}
- (void)applicationWillTerminate:(UIApplication *)application {

}
- (void)registerPushService
{
    if (@available(iOS 11.0, *))
    {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (!granted)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[UIApplication sharedApplication].keyWindow makeToast:@"请开启推送功能否则无法收到推送通知" duration:2.0 position:CSToastPositionCenter];
                });
            }
        }];
    }
    else
    {
        UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types
                                                                                 categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
    
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    

    // 注册push权限，用于显示本地推送
    [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
}

@end
