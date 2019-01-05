//
//  ForgetPwdVC.m
//  Doctor
//
//  Created by zt on 2019/1/4.
//  Copyright © 2019年 AnyOne. All rights reserved.
//

#import "ForgetPwdVC.h"

@interface ForgetPwdVC ()

@property (strong, nonatomic)UITextField * userText;
@property (strong, nonatomic)UITextField * pwdText;

@end

@implementation ForgetPwdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"忘记密码";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.barTintColor = HEXCOLOR(0x00A3FE);
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"whiteBack"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"whiteBack"] forState:UIControlStateHighlighted];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -6, 0, 0)];
    [btn addTarget:self action:@selector(backToLogin) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
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
    
    self.pwdText = [[UITextField alloc]initWithFrame:CGRectMake(xSpace, CGRectGetMaxY(self.userText.frame), SCREENW - xSpace*2 - 83, 50)];
    [textFieldV addSubview:self.pwdText];
    self.pwdText.textColor = [UIColor blackColor];
    self.pwdText.placeholder = @"输入验证码";
    self.pwdText.font = [UIFont fontWithName:Font size:13];
    self.pwdText.leftViewMode = UITextFieldViewModeAlways;
    UIView *pwdLeftV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 38, 18)];
    UIImageView *pwdLeft = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"verify"]];
    pwdLeft.frame = CGRectMake(3, 0, 18, 18);
    [pwdLeftV addSubview:pwdLeft];
    self.pwdText.leftView = pwdLeftV;
    
    UIButton *getVerify = [UIButton buttonWithType:UIButtonTypeCustom];
    [textFieldV addSubview:getVerify];
    [getVerify setTitle:@"发送验证码" forState:UIControlStateNormal];
    getVerify.frame = CGRectMake(CGRectGetMaxX(self.pwdText.frame), CGRectGetMaxY(label.frame) + 10, 83, 30);
    getVerify.titleLabel.font = [UIFont systemFontOfSize:13];
    getVerify.titleLabel.textAlignment = NSTextAlignmentRight;
    [getVerify setTitleColor:HEXCOLOR(0x00A3FE) forState:UIControlStateNormal];
    ViewBorderRadius(getVerify, 4, 1, HEXCOLOR(0x00A3FE));
    [getVerify addTarget:self action:@selector(getVerify:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:loginBtn];
    [loginBtn setTitle:@"确认" forState:UIControlStateNormal];
    loginBtn.frame = CGRectMake(xSpace, CGRectGetMaxY(textFieldV.frame) + adapterH(15), SCREENW - xSpace*2, 41);
    loginBtn.titleLabel.font = [UIFont fontWithName:Font size:17];
    [loginBtn setTitleColor:HEXCOLOR(0xFFFFFF) forState:UIControlStateNormal];
    loginBtn.backgroundColor = HEXCOLOR(0x00A3FE);
    ViewBorderRadius(loginBtn, 2, 1, HEXCOLOR(0x00A3FE));
    [loginBtn addTarget:self action:@selector(loginIn:) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)backToLogin {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)getVerify:(UIButton *)btn {
    
}
- (void)loginIn:(UIButton *)btn {
    
}

@end
