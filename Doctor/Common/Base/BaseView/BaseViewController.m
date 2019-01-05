//
//  BaseViewController.m
//  XiangjianiOS
//
//  Created by  licc on 2018/8/1.
//  Copyright © 2018年 AnyOne. All rights reserved.
//

#import "BaseViewController.h"
//#import <Toast/Toast.h>

@interface BaseViewController ()
@property (nonatomic,strong) UILabel *naviLabel;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createNaviAndLabel];
    
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
    
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.backBtn];
    self.backBtn.frame = CGRectMake(14, kNavigationBarHeight - (64-32), 21, 21);
    [self.backBtn addTarget:self action:@selector(popToMainPage) forControlEvents:UIControlEventTouchUpInside];
    
    self.lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, kNavigationBarHeight - 1, SCREENW, 1)];
    [self.view addSubview:self.lineLabel];
    self.lineLabel.backgroundColor = [HEXCOLOR(0xEEEEEE) colorWithAlphaComponent:0.5];
    
}
- (void)popToMainPage {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)configWithTitle:(NSString *)titleName backImage:(NSString *)imageName{
    self.naviLabel.text = titleName;
    if (imageName.length == 0) {
        imageName = @"blackBack";
    }
    [self.backBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [self.backBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
    
}

- (void)setRightTitle:(NSString *)rightTitle {
    _rightTitle = rightTitle;
    [self.rightBtn setTitle:rightTitle forState:UIControlStateNormal];
}

- (void)configWithTitle:(NSString *)titleName backImage:(NSString *)imageName titleColor:(UIColor *)titleColor {
    self.naviLabel.text = titleName;
    if (imageName.length == 0) {
        imageName = @"blackBack";
    }
    [self.rightBtn setTitleColor:titleColor forState:UIControlStateNormal];
    [self.backBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [self.backBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
    self.naviLabel.textColor = titleColor;
}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];
//    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
//
//
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    UIImage *image = [UIImage imageNamed:@"icon_25"];
//
//    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    self.navigationController.navigationBar.backIndicatorImage = image;
////
//    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = image;
//    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 10, 16)];
//    button.backgroundColor = [UIColor redColor];
//    [button setImage:image forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(backTo) forControlEvents:UIControlEventTouchUpInside];
////    UIBarButtonItem *item= [[UIBarButtonItem alloc] initWithCustomView:button];
////    UIBarButtonItem *item= [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_25"] style:UIBarButtonItemStylePlain target:self action:@selector(backTo)];
//
//        self.navigationController.navigationBar.backIndicatorTransitionMaskImage = image;
//            self.navigationItem.backBarButtonItem = [UIBarButtonItem new];
//
//
//
////
//
//}
//-(UIView *)contentView{
//    if(!_contentView){
//        _contentView = [UIView new];
//        [self.view addSubview:_contentView];
//        [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.top.bottom.mas_equalTo(0);
//        }];
//    }
//    return _contentView;
//}

-(UITableView *) mainTableView{
    if (!_mainTableView) {
        _mainTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, kNavigationBarHeight, SCREENW, SCREENH - kNavigationBarHeight) style:UITableViewStyleGrouped];
        [self.view addSubview:_mainTableView];
        _mainTableView.sectionHeaderHeight=10;
        _mainTableView.sectionFooterHeight=0.01;
        _mainTableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 123, 0.01)];
        _mainTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 123, 0.01)];
        _mainTableView.backgroundColor=LR_TABLE_BACKGROUNDCOLOR;
        _mainTableView.keyboardDismissMode=UIScrollViewKeyboardDismissModeInteractive;
        _mainTableView.delegate=(id<UITableViewDelegate>)self;
        _mainTableView.dataSource=(id<UITableViewDataSource>)self;

        //开启估算
        _mainTableView.estimatedRowHeight = 60;
        _mainTableView.estimatedSectionHeaderHeight = 0;
        _mainTableView.estimatedSectionFooterHeight = 0;
        if (@available(iOS 11.0, *)) {
            _mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _mainTableView;
}
#pragma mark - UITableViewDelegate UITableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
