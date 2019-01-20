//
//  MedicationGuideVC.m
//  Doctor
//
//  Created by zt on 2019/1/21.
//  Copyright © 2019 AnyOne. All rights reserved.
//

#import "MedicationGuideVC.h"

#import "CollectionTableViewCell.h"
#import "CommonTextViewTableViewCell.h"

@interface MedicationGuideVC () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation MedicationGuideVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configWithTitle:@"用药指导" backImage:@"blackBack"];
    self.naviBGView.backgroundColor = [UIColor whiteColor];
    
    self.mainTableView.dataSource = self;
    self.mainTableView.delegate = self;
    self.mainTableView.tableFooterView = [self footerView];
    
    registerNibWithCellName(self.mainTableView, @"CollectionTableViewCell");
    registerNibWithCellName(self.mainTableView, @"CommonTextViewTableViewCell");
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 92.f;
    } else {
        return UITableViewAutomaticDimension;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 43;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"诊断说明";
    } else {
        return @"服药单";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        CommonTextViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommonTextViewTableViewCell"];
        
        //MARK:待处理
        return cell;
    } else {
        CollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CollectionTableViewCell"];
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        return cell;
    }
}

- (UIView *)footerView {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENW, 52.f)];
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.frame = CGRectMake(14.f, 12.f, SCREENW - 28.f, 40.f);
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn setBackgroundColor:HEXCOLOR(0x00A3FE)];
    submitBtn.layer.cornerRadius = 3.3;
    [footerView addSubview:submitBtn];
    
    return footerView;
}

@end
