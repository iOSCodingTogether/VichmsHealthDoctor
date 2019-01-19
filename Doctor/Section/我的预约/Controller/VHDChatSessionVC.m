//
//  VHDChatSessionVC.m
//  Doctor
//
//  Created by zt on 2019/1/19.
//  Copyright © 2019 AnyOne. All rights reserved.
//

#import "VHDChatSessionVC.h"

#import "UIView+MWFrame.h"

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
    
}


@end
