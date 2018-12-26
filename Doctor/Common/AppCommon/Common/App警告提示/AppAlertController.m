//
//  AppAlertController.m
//  VichmsHealthDoctor
//  Created by  licc on 2018/8/24.
//  Copyright © 2018年 AnyOne. All rights reserved.
//

#import "AppAlertController.h"
#import "UIColor+CCategory.h"
#import <Masonry/Masonry.h>

@interface AppAlertController ()
@property (nonatomic, strong) NSArray * buttonTitles;     //

@property (nonatomic,weak) void (^hander)(NSInteger index);
@end

@implementation AppAlertController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSLog(@"width = %.2f",self.view.frame.size.width);
    CGSize size = self.view.frame.size;
    
    for(NSInteger i =0; i< self.buttonTitles.count; i++){
        CGFloat buttonWidth = size.width/self.buttonTitles.count;
        UIButton *button0 = [[UIButton alloc]initWithFrame:CGRectMake(buttonWidth * i, size.height-44, buttonWidth, 44)];;
        LR_BUTTON_STYLE_UNSELECT(button0);
        button0.layer.cornerRadius = 0;
        [button0 setTitle:self.buttonTitles[0] forState:UIControlStateNormal];
        if(i == self.buttonTitles.count -1){
            LR_BUTTON_STYLE(button0);
        }
        else{
            LR_BUTTON_STYLE_UNSELECT(button0);
        }
                [self.view addSubview:button0];
        button0.tag = i;
        [button0 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:button0.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = button0.bounds;
        maskLayer.path = maskPath.CGPath;
        button0.layer.mask = maskLayer;
        
//        AC.view.layer.masksToBounds = YES;
//        AC.view.clipsToBounds = YES;
//        
//        [AC.view addSubview:button1];
//        
//        [button0 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.bottom.mas_equalTo(0);
//            make.width.mas_equalTo(AC.view).multipliedBy(0.5);
//            make.height.mas_equalTo(44);
//        }];
//        [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.bottom.mas_equalTo(0);
//            make.width.mas_equalTo(AC.view).multipliedBy(0.5);
//            make.height.mas_equalTo(44);
//        }];
    }
}
-(void)buttonClick:(UIButton *)button{
    [self dismissViewControllerAnimated:YES completion:^{
        if(self.hander){
            self.hander(button.tag);
        }
    }];
}
-(void)dealloc{
    NSLog(@"alert delloc");
}
+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message  buttonTitles:(NSArray *)buttonTitles handler:(void (^)(NSInteger index))handler{
    
    AppAlertController *AC = [super alertControllerWithTitle:title message:[NSString stringWithFormat:@"%@\n\n\n",message?:@""] preferredStyle:UIAlertControllerStyleAlert];
    AC.hander =  handler;
    AC.buttonTitles = buttonTitles;
    
    return AC;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
