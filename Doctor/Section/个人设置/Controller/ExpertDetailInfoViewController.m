//
//  ExpertDetailInfoViewController.m
//  Doctor
//
//  Created by zt on 2019/1/20.
//  Copyright © 2019年 AnyOne. All rights reserved.
//

#import "ExpertDetailInfoViewController.h"
#import "ExpertIntroduceTopCell.h"
#import "CommonCell1.h"
@interface ExpertDetailInfoViewController ()

@end

@implementation ExpertDetailInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configWithTitle:@"专家介绍" backImage:@""];
    self.naviBGView.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    registerNibWithCellName(self.mainTableView, @"ExpertIntroduceTopCell");
    registerNibWithCellName(self.mainTableView, @"CommonCell1");
    self.mainTableView.separatorColor = [UIColor clearColor];
    self.mainTableView.estimatedRowHeight = 60;
    
//    self.mainTableView.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [self request];
        
//    }];
}
-(void)request{
//    DoctorPageRequestModel *model = [DoctorPageRequestModel new];
//    model.search_EQ_id=self.doctorId;
//    [BaseRequest requestWithRequestModel:model ret:^(BOOL success, __kindof DoctorPageResultModel *dataModel, NSString *jsonObjc) {
//        if(dataModel.success){
//            if(dataModel.list.count>0){
//                self.infoModel = dataModel.list[0];
//            }
//            [self reloadData];
//        }
//        [self.mainTableView.mj_header endRefreshing];
//        [self.mainTableView.mj_footer endRefreshing];
//
//    }];
    
    
}

-(void)reloadData{
    [self.mainTableView reloadData];
}
#pragma mark - UITableViewDelegate, UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        return 100;
    }
    else{
        return UITableViewAutomaticDimension;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return 0;
    }
    else{
        return 44;
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 3;
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    view.backgroundColor = [UIColor whiteColor];
    UIButton *button = [[UIButton alloc]init];
    [view  addSubview:button];
    [button setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    if(section == 1){
        [button setTitle:@"  擅长" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"icon_59"] forState:UIControlStateNormal];
    }
    else if(section == 2){
        [button setTitle:@"  履历" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"icon_60"] forState:UIControlStateNormal];
    }
    else if(section == 3){
        [button setTitle:@"  评论" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"icon_60"] forState:UIControlStateNormal];
    }
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(16);
        make.centerY.mas_equalTo(0);
    }];
    return view;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if(indexPath.section == 0){
        ExpertIntroduceTopCell *curCell = [tableView dequeueReusableCellWithIdentifier:@"ExpertIntroduceTopCell"];
        curCell.nameLabel.text = [NSString stringWithFormat:@"%@",self.dic[@"name"]];
        NSString *dutyStr = nil;
        NSString *duty = self.dic[@"duty"];
        if([duty length]>0 && ![duty isEqualToString:@"无"]){
            dutyStr = [NSString stringWithFormat:@"%@  %@",self.dic[@"department"],self.dic[@"duty"]];
        }
        else{
            dutyStr = [NSString stringWithFormat:@"%@  %@",self.dic[@"department"],@""];
        }
        
        curCell.midLabel.text = dutyStr;
        curCell.hospitalLabel.text = [NSString stringWithFormat:@"%@",self.dic[@"hospitalName"]];
        NSString *headUrl = [NSString stringWithFormat:@"%@",self.dic[@"headPic"]];
        if (![headUrl hasPrefix:@"http:"] && ![headUrl hasPrefix:@"https:"]) {
            headUrl = [NSString stringWithFormat:@"http://www.erpside.com/%@",headUrl];
        }
        [curCell.leftImageView sd_setImageWithURL:[NSURL URLWithString:headUrl] placeholderImage:[UIImage imageNamed:@"000"]];
        curCell.leftImageView.layer.cornerRadius = 40;
        curCell.leftImageView.layer.masksToBounds = YES;
        cell = curCell;
        
    }
    else{
        CommonCell1 *curCell = [tableView dequeueReusableCellWithIdentifier:@"CommonCell1"];
        if(indexPath.section ==1){
            curCell.label0.text = [NSString stringWithFormat:@"%@",self.dic[@"speciality"]];
        }
        else if(indexPath.section ==2){
            curCell.label0.text = [NSString stringWithFormat:@"%@",self.dic[@"introduction"]];
       }
        cell = curCell;
        
    }
    
    return cell;
    
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
