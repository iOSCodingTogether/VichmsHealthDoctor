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

@interface VHDChatSessionVC ()

@property (nonatomic,strong) UILabel *naviLabel;
@property (nonatomic,strong) UIView *naviBGView;
@property (nonatomic,strong) UILabel *lineLabel;
@property (nonatomic,strong) UIButton *rightBtn;
@property (nonatomic,strong) UIButton *backBtn;
//@property (nonatomic,strong) UIButton *secondRightBtn;
@property (nonatomic,copy) NSString *rightTitle;

@end

@implementation VHDChatSessionVC

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


@end
