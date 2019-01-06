//
//  ChatHomeVC.m
//  Doctor
//
//  Created by zt on 2019/1/4.
//  Copyright © 2019年 AnyOne. All rights reserved.
//

#import "ChatHomeVC.h"

#import "NIMSessionListViewController.h"
#import "VHDChatDetailVC.h"
#import "UIView+MWFrame.h"
#import "ChatListHeaderView.h"

@interface ChatHomeVC () <NIMLoginManagerDelegate, NIMEventSubscribeManagerDelegate, UIViewControllerPreviewingDelegate, NTESListHeaderDelegate>

@property (nonatomic, strong) NIMSessionListViewController *sessionListVC;

@property (nonatomic,strong) ChatListHeaderView *header;

#pragma mark - navi
@property (nonatomic,strong) UILabel *naviLabel;
@property (nonatomic,strong) UIView *naviBGView;
@property (nonatomic,strong) UILabel *lineLabel;

@end

@implementation ChatHomeVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self refreshSubview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.naviBGView.backgroundColor = [UIColor whiteColor];
    
    [[NIMSDK sharedSDK].loginManager addDelegate:self];
    [[NIMSDK sharedSDK].subscribeManager addDelegate:self];
    
    [self configWithTitle:@"我的预约" titleColor:[UIColor blackColor]];
}

- (void)onSelectedRecent:(NIMRecentSession *)recent atIndexPath:(NSIndexPath *)indexPath{
    VHDChatDetailVC *vc = [[VHDChatDetailVC alloc] initWithSession:recent.session];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    
}

#pragma mark - Private
- (void)refreshSubview {
    if (@available(iOS 11.0, *)) {
        self.tableView.mw_top = kNavigationBarHeight;
        CGFloat offset = self.view.safeAreaInsets.bottom;
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, offset, 0);
    } else {
        self.tableView.mw_top = kNavigationBarHeight;
    }
    
    self.tableView.mw_height = self.view.mw_height - self.tableView.mw_top;
}

- (void)configWithTitle:(NSString *)titleName titleColor:(UIColor *)titleColor {
    [self createNaviAndLabel];
    self.naviLabel.text = titleName;
    self.naviLabel.textColor = titleColor;
}

- (void)createNaviAndLabel {
    self.naviBGView = [UIView new];
    [self.view addSubview:self.naviBGView];
    self.naviBGView.frame = CGRectMake(0, 0, SCREENW, kNavigationBarHeight);
    
    self.naviLabel = [[UILabel alloc]init];
    self.naviLabel.font = [UIFont fontWithName:Font size:17];
    self.naviLabel.textColor = [UIColor blackColor];
    self.naviLabel.textAlignment = NSTextAlignmentCenter;
    self.naviLabel.frame = CGRectMake(0, kNavigationBarHeight - (64-30), SCREENW, 25);
    [self.view addSubview:self.naviLabel];
    
    self.lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, kNavigationBarHeight - 1, SCREENW, 1)];
    [self.view addSubview:self.lineLabel];
    self.lineLabel.backgroundColor = [HEXCOLOR(0xEEEEEE) colorWithAlphaComponent:0.5];
    
}

@end
