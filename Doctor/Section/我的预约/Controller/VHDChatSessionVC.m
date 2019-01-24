//
//  VHDChatSessionVC.m
//  Doctor
//
//  Created by zt on 2019/1/19.
//  Copyright © 2019 AnyOne. All rights reserved.
//

#import "VHDChatSessionVC.h"

#import "UIView+MWFrame.h"
#import "UserInfoManager.h"
#import "MedicationGuideVC.h"
#import "NTESSessionConfig.h"
//#import "NTESVideoChatViewController.h"

#import <NIMAVChat/NIMNetCallMeeting.h>
#import <NIMAVChat/NIMNetCallOption.h>
#import <NIMAVChat/NIMNetCallVideoCaptureParam.h>
#import <NIMSDK/NIMSDK.h>
#import <NIMAVChat/NIMAVChat.h>
@interface VHDChatSessionVC ()

@property (nonatomic,strong) NTESSessionConfig *config;

@property (nonatomic,strong) UILabel *naviLabel;
@property (nonatomic,strong) UIView *naviBGView;
@property (nonatomic,strong) UILabel *lineLabel;
@property (nonatomic,strong) UIButton *rightBtn;
@property (nonatomic,strong) UIButton *backBtn;
//@property (nonatomic,strong) UIButton *secondRightBtn;
@property (nonatomic,copy) NSString *rightTitle;

@end

@implementation VHDChatSessionVC

- (instancetype)initWithSession:(NIMSession *)session {
    self = [super initWithSession:session];
    if (self) {
        _config = [[NTESSessionConfig alloc] init];
    }
    return self;
}
- (id<NIMSessionConfig>)sessionConfig{
    return self.config;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configNavi];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tableView reloadData];
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
////    CGPoint point = self.tableView.mj_origin;
//    button.frame = CGRectMake(0, kNavigationBarHeight, SCREENW, 40);
//    [button setTitle:@"呼叫医生" forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [button setBackgroundColor:HEXCOLOR(0x00A3FE)];
//    self.tableView.tableHeaderView = button;
//    [self.view addSubview:button];
//    point.y = kNavigationBarHeight + 40;
//    self.tableView.mj_origin = point;

}

- (void)configNavi {
    // 诊断
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"诊断"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(judge)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"病历"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(record)];
    
    //创建一个UIButton
//    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
//    [backButton setImage:[UIImage imageNamed:@"blackBack"] forState:UIControlStateNormal];
//    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
//
//    self.navigationItem.backBarButtonItem = backItem;
    [self.navigationController.navigationBar setBackIndicatorImage:[UIImage imageNamed:@"blackBack"]];
    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"blackBack"]];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                 style:UIBarButtonItemStylePlain
                                                                target:nil
                                                                action:nil];
    self.navigationItem.backBarButtonItem = backItem;
}

- (void)judge {
    if ([[UserInfoManager shareInstance] returnUserType] == UserType_Doctor) {
        MedicationGuideVC *guideVC = [MedicationGuideVC new];
        [self.navigationController pushViewController:guideVC animated:YES];
    } else if ([[UserInfoManager shareInstance] returnUserType] == UserType_Service) {
        MedicationGuideVC *guideVC = [MedicationGuideVC new];
        [self.navigationController pushViewController:guideVC animated:YES];
    }
}

- (void)record {
    
}

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 视频聊天
- (void)onTapMediaItemVideoChat:(NIMMediaItem *)item
{
    if ([self checkRTSCondition]) {
        //初始化会议
        NIMNetCallMeeting *meeting = [[NIMNetCallMeeting alloc] init];
        //指定会议名
        meeting.name = @"meetingName";
        meeting.actor = YES;
        
        //初始化option参数
        NIMNetCallOption *option = [[NIMNetCallOption alloc]init];
        meeting.option = option;
        
        //指定 option 中的 videoCaptureParam 参数
        NIMNetCallVideoCaptureParam *param = [[NIMNetCallVideoCaptureParam alloc] init];
        //清晰度480P
        param.preferredVideoQuality = NIMNetCallVideoQuality480pLevel;
        //裁剪类型 16:9
        param.videoCrop  = NIMNetCallVideoCrop16x9;
        //打开初始为前置摄像头
        param.startWithBackCamera = NO;
        
        option.videoCaptureParam = param;
        
        //加入会议
        [[NIMAVChatSDK sharedSDK].netCallManager joinMeeting:meeting completion:^(NIMNetCallMeeting * _Nonnull meeting, NSError * _Nonnull error) {
            //加入会议失败
            if (error) {
            }
            //加入会议成功
            else
            {
            }
        }];
    }
    
//    if ([self checkRTSCondition]) {
//        //由于音视频聊天里头有音频和视频聊天界面的切换，直接用present的话页面过渡会不太自然，这里还是用push，然后做出present的效果
//        NTESVideoChatViewController *vc = [[NTESVideoChatViewController alloc] initWithCallee:self.session.sessionId];
//        CATransition *transition = [CATransition animation];
//        transition.duration = 0.25;
//        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
//        transition.type = kCATransitionPush;
//        transition.subtype = kCATransitionFromTop;
//        [self.navigationController.view.layer addAnimation:transition forKey:nil];
//        self.navigationController.navigationBarHidden = YES;
//        [self.navigationController pushViewController:vc animated:NO];
//    }
}
- (BOOL)checkRTSCondition
{
    BOOL result = YES;
    
//    if (![[Reachability reachabilityForInternetConnection] isReachable])
//    {
//        [self.view makeToast:@"请检查网络" duration:2.0 position:CSToastPositionCenter];
//        result = NO;
//    }
    NSString *currentAccount = [[NIMSDK sharedSDK].loginManager currentAccount];
    if (self.session.sessionType == NIMSessionTypeP2P && [currentAccount isEqualToString:self.session.sessionId])
    {
        [MBProgressHUD showAlertWithView:self.view andTitle:@"不能和自己通话哦"];
        result = NO;
    }
    if (self.session.sessionType == NIMSessionTypeTeam)
    {
        NIMTeam *team = [[NIMSDK sharedSDK].teamManager teamById:self.session.sessionId];
        NSInteger memberNumber = team.memberNumber;
        if (memberNumber < 2)
        {
            [MBProgressHUD showAlertWithView:self.view andTitle:@"无法发起，群人数少于2人"];
            result = NO;
        }
    }
    return result;
}
@end
