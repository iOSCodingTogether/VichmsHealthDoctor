//
//  VHDChatDetailVC.m
//  Doctor
//
//  Created by zt on 2019/1/6.
//  Copyright © 2019 AnyOne. All rights reserved.
//

#import "VHDChatDetailVC.h"

@interface VHDChatDetailVC ()

@property (nonatomic, strong) UIView *naviBGView;
@property (nonatomic, strong) UILabel *lineLabel;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UILabel *naviLabel;
@property (nonatomic, copy) NSString *rightTitle;

@end

@implementation VHDChatDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"某某某";
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)sendMessage:(NIMMessage *)message {
    
}

#pragma mark - navi


@end
