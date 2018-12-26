//
//  AppAlertView.m
//  VichmsHealthDoctor
//   Created by  licc on 2018/8/25.
//  Copyright © 2018年 AnyOne. All rights reserved.
//

#import "AppAlertView.h"
#import <Masonry/Masonry.h>
#import "AppDefine.h"

@interface AppAlertView()
@property (nonatomic, copy) void (^back)(NSInteger index);
@property (nonatomic, strong) UIView *contentView;
@end

@implementation AppAlertView

+(instancetype)createAppAlertViewWithTitle:(NSString *)title leftButtonTitle:(NSString *)leftButtonTitle rightButtonTitle:(NSString *)rightButtonTitle clickBack:(void(^)(NSInteger index))back{
    AppAlertView * view = [[AppAlertView alloc] initWithTitle:title leftButtonTitle:leftButtonTitle rightButtonTitle:rightButtonTitle clickBack:back];
    [view show];
    return view;
}
- (instancetype)initWithTitle:(NSString *)title leftButtonTitle:(NSString *)leftButtonTitle rightButtonTitle:(NSString *)rightButtonTitle clickBack:(void(^)(NSInteger index))back{
    if (self = [super init]) {
        self.back = back;
        
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
        
        UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
        [self addSubview:contentView];
        self.contentView = contentView;
        contentView.backgroundColor = [UIColor whiteColor];
        contentView.layer.cornerRadius = 8;
        contentView.layer.masksToBounds = YES;
        
        
        UILabel *titleLabel = [[UILabel alloc]init];
        [contentView addSubview:titleLabel];
        titleLabel.numberOfLines = 0;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = title;
        
        UIButton *leftButton = [[UIButton alloc]init];
        [contentView addSubview:leftButton];
        [leftButton setTitle:leftButtonTitle forState:UIControlStateNormal];
        leftButton.backgroundColor = LR_NORMALCOLOR;
        leftButton.tag = 0;
        [leftButton addTarget:self action:@selector(actionButtonOnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *rightButton = [[UIButton alloc]init];
        [contentView addSubview:rightButton];
        [rightButton setTitle:rightButtonTitle forState:UIControlStateNormal];
        rightButton.backgroundColor = LR_MAINCOLOR;
        rightButton.tag = 1;
        [rightButton addTarget:self action:@selector(actionButtonOnClick:) forControlEvents:UIControlEventTouchUpInside];

        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0);
            make.width.mas_equalTo(self).multipliedBy(0.6);
        }];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            make.top.mas_equalTo(20);
        }];
        
        [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.mas_equalTo(0);
            make.width.mas_equalTo(contentView).multipliedBy(0.5);
            make.height.mas_equalTo(44);
            make.top.mas_equalTo(titleLabel.mas_bottom).offset(20);
        }];
        [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.mas_equalTo(0);
            make.width.mas_equalTo(contentView).multipliedBy(0.5);
            make.height.mas_equalTo(44);
        }];
        
        [self show];
    }
    return self;
}

- (void)actionButtonOnClick:(UIButton *)sender{
    if(self.back){
        self.back(sender.tag);
    }
    [self hide];
}
-(void)show{
    [[UIApplication sharedApplication].delegate.window addSubview:self];
    self.alpha = 0;
    self.contentView.transform  = CGAffineTransformScale(self.transform, 0.8, 0.8);
    [UIView animateWithDuration:0.1 animations:^{
        self.contentView.transform  = CGAffineTransformScale(self.transform, 1, 1);
        self.alpha = 1;
    }];
}
-(void)hide{
    if (self.superview) {
        [UIView animateWithDuration:0.1 animations:^{
            self.contentView.transform  = CGAffineTransformScale(self.transform, 0.8, 0.8);
            self.alpha = 0;
            
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
