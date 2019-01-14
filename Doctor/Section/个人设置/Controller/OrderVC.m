//
//  OrderVC.m
//  Doctor
//
//  Created by zt on 2019/1/13.
//  Copyright © 2019年 AnyOne. All rights reserved.
//

#import "OrderVC.h"
#import "NewMyServiceTableViewCell.h"
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
    registerNibWithCellName(self.mainTableView, @"NewMyServiceTableViewCell");
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
    [HYBNetworking getWithUrl:URL_AttendPage refreshCache:YES success:^(id response) {
        
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
    
    NewMyServiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewMyServiceTableViewCell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    MessagePageResultSubModel *model = self.messagepageSubModelArr[indexPath.row];
    
//    NSDictionary *dic = self.dataArray[indexPath.section];
//    cell.tLabel.text = @"系统消息";
//    cell.dLabel.text = dic[@"message"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    NSLog(@"click");
}

@end
