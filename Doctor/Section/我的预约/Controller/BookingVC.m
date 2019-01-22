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

-(void)request:(BOOL)isLoadMore{
    
    NSArray *visitTimeArr = @[@"EQ",@"GT",@""];
    NSArray *statusArr = @[@"4",@"4",@"5"];
    LRWeakSelf;
    if (self.pageIndex < 1) {
        self.pageIndex = 1;
    }
    [HYBNetworking getWithUrl:[NSString stringWithFormat:@"%@?search_EQ_visitTime=%@&pageNo=%ld&pageSize=%d&search_EQ_orderStatus=%@&sortInfo=ASC_visitTime",URL_My,visitTimeArr[self.selectedBtn.tag - 100],(long)self.pageIndex,PageSize,statusArr[self.selectedBtn.tag - 100]] refreshCache:YES success:^(id response) {
        
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
    [self.mainTableView reloadData];
}

#pragma mark - UITableViewDelegate UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

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
        
        NIMSession *session = [NIMSession session:teamId type:NIMSessionTypeTeam];
        VHDChatSessionVC *sessionVC = [[VHDChatSessionVC alloc] initWithSession:session];
        [self.navigationController pushViewController:sessionVC animated:YES];
        
//        if (![[NIMSDK sharedSDK].teamManager isMyTeam:teamInfo.teamId]) {
//            [[NIMSDK sharedSDK].teamManager applyToTeam:teamInfo.teamId
//                                                message:@"医师加入讨论组"
//                                             completion:^(NSError * _Nullable error, NIMTeamApplyStatus applyStatus) {
//                                                 if (error) {
//                                                     [MBProgressHUD showAlertWithView:self.view
//                                                                             andTitle:@"加入群组失败"];
//                                                     return;
//                                                 }
//
//                                                 NIMSession *session = [NIMSession session:teamId type:NIMSessionTypeTeam];
//                                                 VHDChatSessionVC *sessionVC = [[VHDChatSessionVC alloc] initWithSession:session];
//                                                 [self.navigationController pushViewController:sessionVC animated:YES];
//                                             }];
//        } else {
//            NIMSession *session = [NIMSession session:teamId type:NIMSessionTypeTeam];
//            VHDChatSessionVC *sessionVC = [[VHDChatSessionVC alloc] initWithSession:session];
//            [self.navigationController pushViewController:sessionVC animated:YES];
//        }
        
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
