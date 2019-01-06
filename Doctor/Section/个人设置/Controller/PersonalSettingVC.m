//
//  PersonalSettingVC.m
//  Doctor
//
//  Created by zt on 2019/1/4.
//  Copyright © 2019年 AnyOne. All rights reserved.
//

#import "PersonalSettingVC.h"
#import "UserInfoManager.h"
#import "PInfoVC.h"
#import "MessageListVC.h"
#import "AboutUsVC.h"
#import "UserInfoManager.h"
#import "MBProgressHUD+SimpleLoad.h"
#import "StatisticsViewController.h"
#import "ExpertIntroduceVC.h"

#import "LoginVC.h"
#import <NIMSDK/NIMSDK.h>

@interface PersonalSettingVC ()

@property (nonatomic, strong) UIImageView *avatar;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic,copy) NSArray *dataArray;


@end

@implementation PersonalSettingVC
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self createViews];
    if ([UserInfoManager shareInstance].returnUserType == UserType_Doctor) {
        // 医生
        self.dataArray = @[@[@{@"title":@"个人信息",@"image":@"pInfo"},
                             @{@"title":@"消息通知",@"image":@"msgNoti"},
                             @{@"title":@"统计",@"image":@"statistics"}],
                           @[@{@"title":@"关于我们",@"image":@"aboutUs"}]];
    } else if ([UserInfoManager shareInstance].returnUserType == UserType_Accompany) {
        // 陪诊
        self.dataArray = @[@[@{@"title":@"个人信息",@"image":@"pInfo"},
                             @{@"title":@"消息通知",@"image":@"msgNoti"}],
                           @[@{@"title":@"关于我们",@"image":@"aboutUs"}]];
    } else if ([UserInfoManager shareInstance].returnUserType == UserType_Service) {
        // 客服
        self.dataArray = @[@[@{@"title":@"个人信息",@"image":@"pInfo"},
                             @{@"title":@"消息通知",@"image":@"msgNoti"},
                             @{@"title":@"我的医生",@"image":@"myDoctor"}],
                           @[@{@"title":@"关于我们",@"image":@"aboutUs"}]];
    }
}

-(void)createViews{
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 200)];
    self.mainTableView.tableHeaderView = headView;
    UIImageView *headBackview = [UIImageView new];
    [headView addSubview:headBackview];
    headBackview.image = [UIImage imageNamed:@"icon_42"];
    self.avatar = [UIImageView new];
    [headView addSubview:self.avatar];
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:[[UserInfoManager shareInstance].user.headPic stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    self.avatar.layer.masksToBounds = YES;
    self.avatar.layer.cornerRadius = 25.0f;
    self.avatar.layer.borderWidth = 2.f;
    self.avatar.layer.borderColor = [UIColor whiteColor].CGColor;
    
    
    self.nameLabel = [UILabel new];
    [headView addSubview:self.nameLabel];
    self.nameLabel.textColor = [UIColor whiteColor];
    [headBackview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    [self.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.width.height.mas_equalTo(50);
        make.bottom.mas_equalTo(-50);
    }];
    self.nameLabel.text= [UserInfoManager shareInstance].user.name;
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(self.avatar.mas_bottom).offset(12);
    }];
    
}

-(void)cellLine:(UITableViewCell *)cell{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        cell.separatorInset = UIEdgeInsetsMake(0, 12, 0, 0);
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        cell.layoutMargins = UIEdgeInsetsMake(0, 12, 0, 0);
    }
}

#pragma mark - UITableViewDelegate UITableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = self.dataArray[section];
    return arr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    [self cellLine:cell];
    NSArray *arr = self.dataArray[indexPath.section];
    NSDictionary *dic = arr[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:dic[@"image"]];
    cell.textLabel.text = dic[@"title"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    NSArray *arr = self.dataArray[indexPath.section];
    NSDictionary *dic = arr[indexPath.row];
    NSDictionary *vcDic = @{@"个人信息":[PInfoVC new],
                            @"消息通知":[MessageListVC new],
                            @"关于我们":[AboutUsVC new],
                            @"统计":[StatisticsViewController new],
                            @"我的医生":[ExpertIntroduceVC new]
                            };
    UIViewController *vc = [vcDic objectForKey:dic[@"title"]];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 懒加载
- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        [self.view addSubview:self.mainTableView];
        _mainTableView.sectionHeaderHeight=0.01;
        _mainTableView.sectionFooterHeight=0.01;
        [_mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        _mainTableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 123, 0.01)];
        _mainTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 123, 0.01)];
        _mainTableView.backgroundColor=LR_TABLE_BACKGROUNDCOLOR;
        _mainTableView.keyboardDismissMode=UIScrollViewKeyboardDismissModeInteractive;
        _mainTableView.delegate=(id<UITableViewDelegate>)self;
        _mainTableView.dataSource=(id<UITableViewDataSource>)self;
        
        //关闭估算
        _mainTableView.estimatedRowHeight = 0;
        _mainTableView.estimatedSectionHeaderHeight = 0;
        _mainTableView.estimatedSectionFooterHeight = 0;
        if (@available(iOS 11.0, *)) {
            _mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
        UIView *footerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENW, 50)];
        footerV.backgroundColor = [UIColor clearColor];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"退出登录" forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor whiteColor]];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 10, SCREENW, 40);
        [footerV addSubview:button];
        [button addTarget:self action:@selector(loginOut) forControlEvents:UIControlEventTouchUpInside];
        
        _mainTableView.tableFooterView = footerV;
    }
    return _mainTableView;
}

- (void)loginOut {
    [UIApplication sharedApplication].delegate.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[LoginVC new]];
    [[UserInfoManager shareInstance] logoutUser];
    
    [[[NIMSDK sharedSDK] loginManager] logout:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"退出登录失败");
            return;
        }
    }];
}

@end
