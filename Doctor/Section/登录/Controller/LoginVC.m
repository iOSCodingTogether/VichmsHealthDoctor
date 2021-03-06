//
//  LoginVC.m
//  XiangjianiOS
//
//  Created by  licc on 2018/8/8.
//  Copyright © 2018年 AnyOne. All rights reserved.
//

#import "LoginVC.h"
#import "ForgetPwdVC.h"
#import "VHDTabbarVC.h"
#import "HYBNetworking.h"
#import "UserInfoManager.h"
#import "MBProgressHUD+SimpleLoad.h"
#import <NIMSDK/NIMSDK.h>

@interface LoginVC ()
//@property (strong, nonatomic) UIImageView * imageView;
@property (strong, nonatomic)UITextField * userText;
@property (strong, nonatomic)UITextField * pwdText;
@property (nonatomic,strong) UIButton *selectBtn;
@property (nonatomic,assign) NSInteger selectRoleIndex;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"登录";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.barTintColor = HEXCOLOR(0x00A3FE);
    [self createViews];
}

-(void)createViews{
    self.view.backgroundColor = HEXCOLOR(0xF3F3F3);
    
    UIView *roleV = [[UIView alloc]initWithFrame:CGRectMake(0, kNavigationBarHeight, SCREENW, 50)];
    [self.view addSubview:roleV];
    CGFloat xSpace = 20;
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(xSpace, 0, SCREENW - xSpace*2, 15)];
//    [roleV addSubview:label];
//    label.text = @"请选择角色";
    NSArray *titleArr = @[@"陪诊员",@"专家",@"客服"];
    CGFloat btnW = (SCREENW - xSpace * 4)/3.0;
    for (NSInteger i=0; i<titleArr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [roleV addSubview:btn];
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        ViewBorderRadius(btn, 5, 1, HEXCOLOR(0xF3F3F3));
        btn.tag = 100 + i;
        [btn addTarget:self action:@selector(selectRole:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(xSpace + i*(btnW +xSpace), 5, btnW, 40);
        [btn setTitleColor:HEXCOLOR(0x00A3FE) forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    }
    UIView *textFieldV = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(roleV.frame), SCREENW, 100)];
    textFieldV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:textFieldV];
    
    self.userText = [[UITextField alloc]initWithFrame:CGRectMake(xSpace, 0, SCREENW - xSpace * 2, 50)];
    [textFieldV addSubview:self.userText];
    self.userText.textColor = [UIColor blackColor];
    self.userText.placeholder = @"输入手机号";
    self.userText.leftViewMode = UITextFieldViewModeAlways;
    UIView *userLeftV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 38, 18)];
    UIImageView *userLeft = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"user"]];
    userLeft.frame = CGRectMake(3, 0, 18, 18);
    [userLeftV addSubview:userLeft];
    self.userText.font = [UIFont fontWithName:Font size:13];
    self.userText.leftView = userLeftV;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(xSpace, CGRectGetMaxY(self.userText.frame), CGRectGetWidth(self.userText.frame), 1)];
    [textFieldV addSubview:label];
    label.backgroundColor = RGB(242, 243, 243, 1);
    
    self.pwdText = [[UITextField alloc]initWithFrame:CGRectMake(xSpace, CGRectGetMaxY(self.userText.frame), SCREENW - xSpace*2, 50)];
    [textFieldV addSubview:self.pwdText];
    [self.pwdText setSecureTextEntry:YES];
    self.pwdText.textColor = [UIColor blackColor];
    self.pwdText.placeholder = @"输入密码";
    self.pwdText.font = [UIFont fontWithName:Font size:13];
    self.pwdText.leftViewMode = UITextFieldViewModeAlways;
    UIView *pwdLeftV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 38, 18)];
    UIImageView *pwdLeft = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"pwd"]];
    pwdLeft.frame = CGRectMake(3, 0, 18, 18);
    [pwdLeftV addSubview:pwdLeft];
    self.pwdText.leftView = pwdLeftV;
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(xSpace, CGRectGetMaxY(self.pwdText.frame), CGRectGetWidth(self.pwdText.frame), 1)];
    [textFieldV addSubview:label1];
    label1.backgroundColor = HEXCOLOR(0xf5f5f5);
    
//    UIButton *changePwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.view addSubview:changePwdBtn];
//    [changePwdBtn setTitle:@"修改密码/忘记密码" forState:UIControlStateNormal];
//    changePwdBtn.frame = CGRectMake(SCREENW - 120 - xSpace, CGRectGetMaxY(textFieldV.frame) + adapterH(12), 120, 16);
//    changePwdBtn.titleLabel.font = [UIFont systemFontOfSize:13];
//    changePwdBtn.titleLabel.textAlignment = NSTextAlignmentRight;
//    [changePwdBtn setTitleColor:HEXCOLOR(0x999999) forState:UIControlStateNormal];
//    [changePwdBtn addTarget:self action:@selector(changePwd:) forControlEvents:UIControlEventTouchUpInside];

    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:loginBtn];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.frame = CGRectMake(xSpace, CGRectGetMaxY(textFieldV.frame) + adapterH(51), SCREENW - xSpace*2, 41);
    loginBtn.titleLabel.font = [UIFont fontWithName:Font size:17];
    [loginBtn setTitleColor:HEXCOLOR(0xFFFFFF) forState:UIControlStateNormal];
    loginBtn.backgroundColor = HEXCOLOR(0x00A3FE);
    ViewBorderRadius(loginBtn, 2, 1, HEXCOLOR(0x00A3FE));
    [loginBtn addTarget:self action:@selector(loginIn:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)changePwd:(UIButton *)btn {
    [self.navigationController pushViewController:[ForgetPwdVC new] animated:YES];
}

- (void)loginIn:(UIButton *)btn {
    
    if (self.userText.text.length == 0
        || self.pwdText.text.length == 0) {
        [MBProgressHUD showLoadingWithTitle:@"还没填写用户名或密码"];
        return;
    }else if (self.selectRoleIndex == 0) {
        [MBProgressHUD showLoadingWithTitle:@"请先选择角色"];
        return;
    }
    
    [HYBNetworking postWithUrl:URL_Login
                          body:@{@"phone" : self.userText.text ?: @"",
                                 @"personType" : [NSString stringWithFormat:@"%ld",(long)self.selectRoleIndex],
                                 @"password" : self.pwdText.text ?: @""}
                       success:^(id response) {
                           if ([response isKindOfClass:[NSDictionary class]]) {
                               // 存储数据
                               UserInfoModel *userModel = [UserInfoModel mj_objectWithKeyValues:response[@"data"]];
                               [[NSUserDefaults standardUserDefaults]setValue:userModel.token forKey:@"token"];
                               [[UserInfoManager shareInstance] recordUserInfo:userModel];
                               
                               [[[NIMSDK sharedSDK] loginManager] login:[UserInfoManager shareInstance].user.accid
                                                                  token:[UserInfoManager shareInstance].user.tokenyx
                                                             completion:^(NSError * _Nullable error) {
                                                                 if (error) {
                                                                     [MBProgressHUD showLoadingWithTitle:@"认证失败，请重试"];
                                                                 } else {
                                                        
                                                                     VHDTabbarVC *tabVC = [[VHDTabbarVC alloc] init];
                                                                     [UIApplication sharedApplication].delegate.window.rootViewController = tabVC;
                                                                 }
                                                             }];
                           }
                       } fail:^(NSError *error, NSInteger statusCode) {
                           [MBProgressHUD showLoadingWithTitle:error.domain];
                       }];
}

- (void)selectRole:(UIButton *)btn {
    [self.selectBtn setBackgroundColor:[UIColor whiteColor]];
    self.selectBtn.selected = NO;
    self.selectBtn = btn;
    self.selectBtn.selected = YES;
    [self.selectBtn setBackgroundColor:HEXCOLOR(0x00A3FE)];
    switch (btn.tag - 100) {
        case 0:
            {
                self.selectRoleIndex = 3;
            }
            break;
        case 1:
        {
            self.selectRoleIndex = 4;
        }
            break;
        case 2:
        {
            self.selectRoleIndex = 5;
        }
            break;
            
        default:
            break;
    }
}

@end
