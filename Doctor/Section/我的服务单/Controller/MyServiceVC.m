//
//  MyServiceVC.m
//  Doctor
//
//  Created by zt on 2019/1/4.
//  Copyright © 2019年 AnyOne. All rights reserved.
//

#import "MyServiceVC.h"
#import "MyServiceTableViewCell.h"

@interface MyServiceVC ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation MyServiceVC
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configWithTitle:@"我的服务单" backImage:@""];
    self.backBtn.hidden = YES;
    self.naviBGView.backgroundColor = [UIColor whiteColor];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createSearchV];
    
}
- (void)createSearchV {

    registerNibWithCellName(self.mainTableView, @"MyServiceTableViewCell");

    UIView *topV = [[UIView alloc]initWithFrame:CGRectMake(0, kNavigationBarHeight, SCREENW, 95)];
    [self.view addSubview:topV];
    topV.backgroundColor = [UIColor redColor];
    
    self.mainTableView.frame = CGRectMake(0, CGRectGetMaxY(topV.frame), SCREENW, SCREENH - CGRectGetMaxY(topV.frame) - kTabarHeight);

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyServiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyServiceTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 12;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 217;
}
@end
