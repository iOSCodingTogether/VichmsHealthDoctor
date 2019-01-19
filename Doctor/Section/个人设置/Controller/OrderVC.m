//
//  OrderVC.m
//  Doctor
//
//  Created by zt on 2019/1/13.
//  Copyright © 2019年 AnyOne. All rights reserved.
//

#import "OrderVC.h"
#import "AccompanyTableViewCell.h"
@interface OrderVC ()
@property (nonatomic,strong) NSMutableArray *dataArray;
//@property (nonatomic, strong) NSMutableArray <MessagePageResultSubModel *> *messagepageSubModelArr;     //
@property (nonatomic,assign) NSInteger pageIndex;

@end
@implementation OrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self configWithTitle:@"订单列表" backImage:@""];
    registerNibWithCellName(self.mainTableView, @"AccompanyTableViewCell");
    self.dataArray = [NSMutableArray array];
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
    
    [self request:NO];
}


-(void)request:(BOOL)isLoadMore{
    
    LRWeakSelf;
    if (self.pageIndex < 1) {
        self.pageIndex = 1;
    }
    [HYBNetworking getWithUrl:[URL_AttendPage stringByAppendingFormat:@"?pageNo=%ld&pageSize=%d",self.pageIndex,PageSize] refreshCache:YES success:^(id response) {
        
        NSLog(@"====订单列表%@",response);
        NSDictionary *dic = response;
        if ([dic[@"code"] isEqual:@100]) {
            NSDictionary *data = dic[@"data"];
            NSArray *arr = data[@"list"];
            
            if (weakSelf.pageIndex == 1) {
                weakSelf.dataArray = [NSMutableArray arrayWithArray:arr];
            }else {
                [weakSelf.dataArray addObjectsFromArray:arr];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDelegate UITableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    return self.messagepageSubModelArr.count;
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 12;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AccompanyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AccompanyTableViewCell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.statusBtn setTitle:@"已完成" forState:UIControlStateNormal];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *orderType = @{@"1":@"第一次就诊",@"2":@"复诊"};
    
    NSDictionary *dic = self.dataArray[indexPath.section];
    cell.typeLabel.text = [orderType objectForKey:dic[@"orderType"]];
    cell.nameLabel.text = [NSString stringWithFormat:@"%@",dic[@"personName"]];
    cell.hospitalLabel.text = [NSString stringWithFormat:@"%@",dic[@"hospital"]];
    cell.dataLabel.text = [self testDateZone:dic[@"visitTime"]];
    cell.ageLabel.text = [NSString stringWithFormat:@"%@",dic[@"personAge"]];
    cell.keshiLabel.text = [NSString stringWithFormat:@"%@",dic[@"department"]];
    cell.statusBtn.backgroundColor = HEXCOLOR(0x00A3FE);
    [cell.statusBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
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
@end
