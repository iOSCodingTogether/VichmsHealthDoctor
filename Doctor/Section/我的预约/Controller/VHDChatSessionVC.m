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
#import "NIMContactSelectConfig.h"
#import "NIMContactSelectViewController.h"

#import "NTESSessionConfig.h"
#import "NTESTeamMeetingCallerInfo.h"
#import "NTESTeamMeetingViewController.h"
#import "NTESCustomSysNotificationSender.h"
@interface VHDChatSessionVC ()<NIMSystemNotificationManagerDelegate>

@property (nonatomic,strong) NTESSessionConfig *config;

@property (nonatomic,strong) UILabel *naviLabel;
@property (nonatomic,strong) UIView *naviBGView;
@property (nonatomic,strong) UILabel *lineLabel;
@property (nonatomic,strong) UIButton *rightBtn;
@property (nonatomic,strong) UIButton *backBtn;
//@property (nonatomic,strong) UIButton *secondRightBtn;
@property (nonatomic,copy) NSString *rightTitle;
@property (nonatomic,strong)    NTESCustomSysNotificationSender *notificaionSender;

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
    _notificaionSender  = [[NTESCustomSysNotificationSender alloc] init];

    [self configNavi];
}
- (void)onTextChanged:(id)sender
{
    [_notificaionSender sendTypingState:self.session];
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

//- (NSString *)sessionTitle {
//    [NIMSDK sharedSDK].teamManager.allMyTeams
//    return [NSString stringWithFormat:<#(nonnull NSString *), ...#>]
//}

- (void)configNavi {
    // 诊断
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"诊断"
//                                                                              style:UIBarButtonItemStylePlain
//                                                                             target:self
//                                                                             action:@selector(judge)];
//
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"病历"
//                                                                             style:UIBarButtonItemStylePlain
//                                                                            target:self
//                                                                            action:@selector(record)];
    
    
    //创建一个UIButton
//    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
//    [backButton setImage:[UIImage imageNamed:@"blackBack"] forState:UIControlStateNormal];
//    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
//
//    self.navigationItem.leftBarButtonItem = backItem;
//    
//    [self.navigationController.navigationBar setBackIndicatorImage:[UIImage imageNamed:@"blackBack"]];
//    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"blackBack"]];
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@""
//                                                                 style:UIBarButtonItemStylePlain
//                                                                target:nil
//                                                                action:nil];
//    self.navigationItem.backBarButtonItem = backItem;
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
        NIMTeam *team = [[NIMSDK sharedSDK].teamManager teamById:self.session.sessionId];
        NSString *currentUserID = [[[NIMSDK sharedSDK] loginManager] currentAccount];
        NIMContactTeamMemberSelectConfig *config = [[NIMContactTeamMemberSelectConfig alloc] init];
        config.teamId = team.teamId;
        config.filterIds = @[currentUserID];
        config.needMutiSelected = YES;
        config.maxSelectMemberCount = 2;
        config.showSelectDetail = YES;
        NIMContactSelectViewController *vc = [[NIMContactSelectViewController alloc] initWithConfig:config];
        __weak typeof(self) weakSelf = self;
        vc.finshBlock = ^(NSArray * memeber){
            NSString *me = [NIMSDK sharedSDK].loginManager.currentAccount;
            NTESTeamMeetingCallerInfo *info = [[NTESTeamMeetingCallerInfo alloc] init];
            info.members = [@[me] arrayByAddingObjectsFromArray:memeber];
            info.teamId = team.teamId;
            NTESTeamMeetingViewController *vc = [[NTESTeamMeetingViewController alloc] initWithCallerInfo:info];
            [weakSelf presentViewController:vc animated:NO completion:nil];
        };;
        [vc show];
    }
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
