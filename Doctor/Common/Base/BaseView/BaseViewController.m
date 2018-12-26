//
//  BaseViewController.m
//  XiangjianiOS
//
//  Created by  licc on 2018/8/1.
//  Copyright © 2018年 AnyOne. All rights reserved.
//

#import "BaseViewController.h"
#import <Toast/Toast.h>

@interface BaseViewController ()

@end

@implementation BaseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTintColor:[UIColor grayColor]];

    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    UIImage *image = [UIImage imageNamed:@"icon_25"];

    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationController.navigationBar.backIndicatorImage = image;
//
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = image;
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 10, 16)];
    button.backgroundColor = [UIColor redColor];
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backTo) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *item= [[UIBarButtonItem alloc] initWithCustomView:button];
//    UIBarButtonItem *item= [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_25"] style:UIBarButtonItemStylePlain target:self action:@selector(backTo)];

        self.navigationController.navigationBar.backIndicatorTransitionMaskImage = image;
            self.navigationItem.backBarButtonItem = [UIBarButtonItem new];

   
    
//
    
}
-(UIView *)contentView{
    if(!_contentView){
        _contentView = [UIView new];
        [self.view addSubview:_contentView];
        [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
    }
    return _contentView;
}

-(UITableView *) mainTableView{
    if (!_mainTableView) {
        _mainTableView=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        [self.contentView addSubview:_mainTableView];
        _mainTableView.sectionHeaderHeight=0.01;
        _mainTableView.sectionFooterHeight=0.01;
        [_mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
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
- (void)backTo{
    if(self.navigationController.viewControllers.count == 1){
        [self dismissViewControllerAnimated:YES completion:nil];

    }
    else if ([self.navigationController respondsToSelector:@selector(popViewControllerAnimated:)]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if([self.tabBarController.navigationController respondsToSelector:@selector(popViewControllerAnimated:)]){
        [self.tabBarController.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    NSLog(@"back");
}




- (void)pushViewController:(UIViewController *)viewController {
    
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:NO];
}



@end
