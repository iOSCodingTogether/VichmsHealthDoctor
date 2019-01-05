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

@interface LoginVC ()
//@property (strong, nonatomic) UIImageView * imageView;
@property (strong, nonatomic)UITextField * userText;
@property (strong, nonatomic)UITextField * pwdText;
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
    UIView *textFieldV = [[UIView alloc]initWithFrame:CGRectMake(0, kNavigationBarHeight, SCREENW, 100)];
    textFieldV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:textFieldV];
    
    CGFloat xSpace = 20;
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
    
    UIButton *changePwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:changePwdBtn];
    [changePwdBtn setTitle:@"修改密码/忘记密码" forState:UIControlStateNormal];
    changePwdBtn.frame = CGRectMake(SCREENW - 120 - xSpace, CGRectGetMaxY(textFieldV.frame) + adapterH(12), 120, 16);
    changePwdBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    changePwdBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [changePwdBtn setTitleColor:HEXCOLOR(0x999999) forState:UIControlStateNormal];
    [changePwdBtn addTarget:self action:@selector(changePwd:) forControlEvents:UIControlEventTouchUpInside];

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
    // TODO: 测试
    VHDTabbarVC *tabVC = [[VHDTabbarVC alloc] init];
    [UIApplication sharedApplication].delegate.window.rootViewController = tabVC;
}

@end
