//
//  BookingVC.m
//  Doctor
//
//  Created by zt on 2019/1/4.
//  Copyright © 2019年 AnyOne. All rights reserved.
//
#import "BookingVC.h"
#import "BookTableViewCell.h"
#import "BRStringPickerView.h"
#import "OrderPageMyRequestModel.h"
#import "CommonManage.h"
#import "UIButton+Block.h"
#import "VHDChatSessionVC.h"
#import "NIMKitDataProviderImpl.h"

@interface BookingVC ()< UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate>
@property (nonatomic,strong) UIView *topView;//上面的选择view
@property (nonatomic,strong) UIView *colorView;//下面的颜色view
@property (nonatomic,strong) UIButton *selectedBtn;//当前选中的状态

@property (nonatomic,assign) NSInteger pageIndex;

@property (nonatomic, strong) NSMutableArray *dataArr;//获取到的数据
@property (nonatomic, strong) NSMutableArray *showArr;
@property (nonatomic, strong) NSString * searchGoodsTypeType;     //


@end

@implementation BookingVC
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configWithTitle:@"我的预约" backImage:@""];
    self.backBtn.hidden = YES;
    self.naviBGView.backgroundColor = [UIColor whiteColor];
    self.dataArr = [NSMutableArray array];
    self.pageIndex = 1;
    [self createViews];
    [self request:NO];
    
//    [self reloadData];
}
- (void)createViews{
    
    [self createBtns];
    
    registerNibWithCellName(self.mainTableView, @"BookTableViewCell");
    self.mainTableView.frame = CGRectMake(0, CGRectGetMaxY(self.topView.frame), SCREENW, SCREENH - CGRectGetMaxY(self.topView.frame) - kTabarHeight);
    LRWeakSelf;
    self.mainTableView.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (weakSelf.pageIndex > 1) {
            weakSelf.pageIndex --;
        }
        [weakSelf request:YES];
    }];
    self.mainTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.pageIndex ++;
        [weakSelf request:YES];
    }];
}
- (void)createBtns {
    CGFloat xSpace = 0;
    NSArray *titleArr = @[@"已预约",@"待就诊",@"已完成"];
    CGFloat btnW = (SCREENW - xSpace * 4)/3.0;
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, kNavigationBarHeight, SCREENW, 46)];
    [self.view addSubview:self.topView];
    self.topView.backgroundColor = LR_TABLE_BACKGROUNDCOLOR;
    
    for (NSInteger i=0; i<titleArr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.topView addSubview:btn];
        btn.backgroundColor = [UIColor clearColor];
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        btn.tag = 100 + i;
        [btn addTarget:self action:@selector(selectStatus:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(xSpace + i*(btnW +xSpace), 0, btnW, 46);
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitleColor:HEXCOLOR(0x00A3FE) forState:UIControlStateSelected];
        [btn setTitleColor:HEXCOLOR(0x666666) forState:UIControlStateNormal];
        [btn setTitleColor:HEXCOLOR(0x00A3FE) forState:UIControlStateSelected | UIControlStateHighlighted];
        if (i == 0) {
            btn.selected = YES;
            self.selectedBtn = btn;
        }
    }
    self.colorView = [[UIView alloc]initWithFrame:CGRectMake(0, 43, 28, 3)];
    [self.topView addSubview:self.colorView];
    self.colorView.backgroundColor = HEXCOLOR(0x00A3FE);
    CGPoint center = self.colorView.center;
    center.x = btnW/2.0;
    self.colorView.center = center;
}

- (void)selectStatus:(UIButton *)btn {
    CGFloat btnW = SCREENW /3.0;

    btn.selected = YES;
    if (btn != self.selectedBtn) {
        self.selectedBtn.selected = NO;
    }
    self.selectedBtn = btn;
    
    CGPoint center = self.colorView.center;
    center.x =(btnW * (btn.tag - 100)) + btnW/2.0;
    self.colorView.center = center;
    
    self.pageIndex = 1;
    [self request:YES];
    
}
//-(void)selectTypeAction:(UIButton *)button{
//    [[CommonManage shareInstance] goodsPageResultModelBack:^(GoodsPageResultModel * _Nonnull goodsPageResultModel) {
//        NSMutableArray *arr = [NSMutableArray array];
//
//        for (GoodsPageResultSubModel *model in goodsPageResultModel.list) {
//            [arr addObject:[NSString stringWithFormat:@"%@",model.goodsTypeName]];
//
//        }
//        LRWeakSelf;
//        [BRStringPickerView showStringPickerWithTitle:@"与患者关系：" dataSource:arr defaultSelValue:nil isAutoSelect:NO resultBlock:^(id selectValue) {
//            GoodsPageResultSubModel *model = [goodsPageResultModel findBygoodsTypeName:selectValue];
//            weakSelf.searchGoodsTypeType = model.goodsTypeCode;
//            //            [button setTitle:selectValue forState:UIControlStateNormal];
//            self.selectTypeLabel.text = selectValue;
//            [weakSelf request:NO];
//        }];
//    }];
//
//
//}
//
-(void)request:(BOOL)isLoadMore{
    
    NSArray *visitTimeArr = @[@"EQ",@"GT",@""];
    LRWeakSelf;
    if (self.pageIndex < 1) {
        self.pageIndex = 1;
    }
    [HYBNetworking getWithUrl:[NSString stringWithFormat:@"%@?search_EQ_visitTime=%@&pageNo=%ld&pageSize=%d",URL_My,visitTimeArr[self.selectedBtn.tag - 100],(long)self.pageIndex,PageSize] refreshCache:YES success:^(id response) {
        
        NSLog(@"====预约页面%@",response);
        NSDictionary *dic = response;
        if ([dic[@"code"] isEqual:@100]) {
            NSDictionary *data = dic[@"data"];
            NSArray *arr = data[@"list"];
            
            if (weakSelf.pageIndex == 1) {
                weakSelf.dataArr = [NSMutableArray arrayWithArray:arr];
            }else {
                [weakSelf.dataArr addObjectsFromArray:arr];
            }
            if (arr.count == 0) {
                self.pageIndex --;
            }
        }else {
            [MBProgressHUD showAlertWithView:self.view andTitle:@"请求失败"];
        }
        [weakSelf.mainTableView reloadData];
        [weakSelf.mainTableView.mj_header endRefreshing];
        [weakSelf.mainTableView.mj_footer endRefreshing];

    } fail:^(NSError *error, NSInteger statusCode) {
        [weakSelf.mainTableView.mj_header endRefreshing];
        [weakSelf.mainTableView.mj_footer endRefreshing];
        [MBProgressHUD showAlertWithView:self.view andTitle:@"连接服务器失败"];
    }];


}
-(void)reloadData{
    //    self.dataArr = [NSMutableArray arrayWithObjects:@"内科",@"外科",@"儿科",@"妇科",@"眼科",@"耳鼻喉科",@"口腔科",@"皮肤科",@"中医科",@"理疗科", nil];
    //    NSString *searchKey = self.mSearchBar.text;
    //    if(searchKey.length ==0){
    //        self.showArr = self.dataArr;
    //    }
    //    else{
    //        self.showArr = [NSMutableArray array];
    //        for(NSString *str in self.dataArr){
    //            if([str containsString:searchKey]){
    //                [self.showArr addObject:str];
    //            }
    //        }
    //    }
    [self.mainTableView reloadData];
}
//
//-(void)spreadButtonClicked:(UIButton *)sender{
//    if(self.spreadSection == sender.tag){
//        self.spreadSection = -1;
//    }
//    else{
//        self.spreadSection = sender.tag;
//    }
//    [self reloadData];
//}
//#pragma mark - UITableViewDelegate, UITableViewDataSource
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 150;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 60;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 30;
//}
//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 200)];
//
//    UIView *contentView = [[UIView alloc]init];
//    [view addSubview:contentView];
//    contentView.backgroundColor = [UIColor whiteColor];
//    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.mas_equalTo(0);
//        make.top.mas_equalTo(10);
//    }];
//    UILabel *label = [UILabel new];
//    [contentView addSubview:label];
//    label.text = @[@"预约专家",@"高端体检",@"温馨陪诊"][section];
//    [label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(12);
//        make.centerY.mas_equalTo(0);
//    }];
//    return view;
//}
//
//- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 200)];
//    view.backgroundColor = [UIColor whiteColor];
//    UIButton *footButton = [[UIButton alloc]init];
//    footButton.tag = section;
//    [view addSubview:footButton];
//    [footButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.bottom.mas_equalTo(0);
//    }];
//    if(self.spreadSection == section){
//        [footButton setImage:[UIImage imageNamed:@"icon_58"] forState:UIControlStateNormal];
//    }
//    else{
//        [footButton setImage:[UIImage imageNamed:@"icon_57"] forState:UIControlStateNormal];
//    }
//    [footButton addTarget:self action:@selector(spreadButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//    return view;
//}
//
//- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
//    MyApplyListTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"MyApplyListTableViewCell"];
//
//    return cell;
//}
//
//- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if(self.spreadSection == section){
//        return 3;
//    }
//
//    return 1;
//
//}
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//
//    return 3;
//}

#pragma mark - UITableViewDelegate UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 60;
//}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return 190;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookTableViewCell"];
    
    NSDictionary *orderType = @{@"1":@"第一次就诊",@"2":@"复诊"};
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dic = self.dataArr[indexPath.row];
    cell.nameLabel.text = [NSString stringWithFormat:@"%@",dic[@"personName"]];
    cell.ageLabel.text = [NSString stringWithFormat:@"%@",dic[@"personAge"]];
    cell.doctorLabel.text = [NSString stringWithFormat:@"%@",dic[@"doctor"]];
    cell.endLabel.text = [self testDateZone:dic[@"orderTime"]];
    cell.startTimeLabel.text = [orderType objectForKey:dic[@"orderType"]];
    @weakify(self);
    [cell setChatInfoWithCellInfo:dic chatAction:^(NSString * _Nonnull teamId) {
        @strongify(self);
        if (teamId.length == 0) {
            [MBProgressHUD showAlertWithView:self.view
                                    andTitle:@"群组信息获取失败，请重试"];
            return;
        }
        
        NIMTeam *teamInfo = [[NIMSDK sharedSDK].teamManager teamById:teamId];
        
        if (![[NIMSDK sharedSDK].teamManager isMyTeam:teamInfo.teamId]) {
            [[NIMSDK sharedSDK].teamManager applyToTeam:teamInfo.teamId
                                                message:@"医师加入讨论组"
                                             completion:^(NSError * _Nullable error, NIMTeamApplyStatus applyStatus) {
                                                 if (error) {
                                                     [MBProgressHUD showAlertWithView:self.view
                                                                             andTitle:@"加入群组失败"];
                                                     return;
                                                 }
                                                 
                                                 NIMSession *session = [NIMSession session:teamId type:NIMSessionTypeTeam];
                                                 VHDChatSessionVC *sessionVC = [[VHDChatSessionVC alloc] initWithSession:session];
                                                 [self.navigationController pushViewController:sessionVC animated:YES];
                                             }];
        } else {
            NIMSession *session = [NIMSession session:teamId type:NIMSessionTypeTeam];
            VHDChatSessionVC *sessionVC = [[VHDChatSessionVC alloc] initWithSession:session];
            [self.navigationController pushViewController:sessionVC animated:YES];
        }
        
    }];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    NSLog(@"click");
}

-(NSString *)testDateZone:(NSString *)timeDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    
    NSDate *localDate = [dateFormatter dateFromString:timeDate];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:[self getNowDateFromatAnDate:localDate]];
    NSLog(@"strDate = %@",strDate);
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    return strDate;
}

- (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate
{
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate];
    return destinationDateNow;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
