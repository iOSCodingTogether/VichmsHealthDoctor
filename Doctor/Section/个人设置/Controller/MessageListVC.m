//
//  MessageListVC.m
//  Suffer
//
//  Created by  licc on 2018/8/24.
//  Copyright © 2018年 AnyOne. All rights reserved.
//

#import "MessageListVC.h"
#import "MessageListTableViewCell.h"
#import "MessagePageRequestModel.h"

@interface MessageListVC ()
@property (nonatomic,strong) NSMutableArray *dataArray;
//@property (nonatomic, strong) NSMutableArray <MessagePageResultSubModel *> *messagepageSubModelArr;     //
@property (nonatomic,assign) NSInteger pageIndex;

@end

@implementation MessageListVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    [self configWithTitle:@"消息通知" backImage:@""];
    registerNibWithCellName(self.mainTableView, @"MessageListTableViewCell");
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
    [HYBNetworking getWithUrl:URL_Message_MY refreshCache:YES success:^(id response) {
        
        NSLog(@"====消息列表%@",response);
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
        if (statusCode == 401) {
            //token失效，重新登录
            [UIApplication sharedApplication].delegate.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[LoginVC new]];
            [[UserInfoManager shareInstance] logoutUser];
            
            [[[NIMSDK sharedSDK] loginManager] logout:^(NSError * _Nullable error) {
                if (error) {
                    NSLog(@"退出登录失败");
                    return;
                }
            }];
        }else {
            [MBProgressHUD showAlertWithView:self.view andTitle:@"连接服务器失败"];
        }
        [weakSelf.mainTableView.mj_header endRefreshing];
        [weakSelf.mainTableView.mj_footer endRefreshing];

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
    
    MessageListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageListTableViewCell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    MessagePageResultSubModel *model = self.messagepageSubModelArr[indexPath.row];

    NSDictionary *dic = self.dataArray[indexPath.section];
    cell.tLabel.text = @"系统消息";
    cell.dLabel.text = dic[@"message"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    NSLog(@"click");
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
