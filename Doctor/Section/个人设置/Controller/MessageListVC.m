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
@property (nonatomic, strong) NSMutableArray <MessagePageResultSubModel *> *messagepageSubModelArr;     //

@end

@implementation MessageListVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    [self configWithTitle:@"消息通知" backImage:@""];
    registerNibWithCellName(self.mainTableView, @"MessageListTableViewCell");

    self.messagepageSubModelArr = [NSMutableArray array];
//    [self request:NO];
    
    

//    LRWeakSelf;
//    self.mainTableView.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [weakSelf request:NO];
//
//    }];
    
}


-(void)request:(BOOL)isLoadMore{
    MessagePageRequestModel *model = [MessagePageRequestModel new];
    model.pageSize = 10;
    
    if(!isLoadMore){
        model.pageSize = 20;
        
        model.pageNo = 1;
    }
    else{
        model.pageSize = 10;
        
        model.pageNo = [model nextPageNoForCurDataCount:self.messagepageSubModelArr.count];
    }

    [BaseRequest requestWithRequestModel:model ret:^(BOOL success, __kindof MessagePageResultModel *dataModel, NSString *jsonObjc) {
        if(dataModel.success){
            if(!isLoadMore){
                self.messagepageSubModelArr =[NSMutableArray arrayWithArray:  dataModel.list];
            }
            else{
                
                [self.messagepageSubModelArr addObjectsFromArray:dataModel.list];
            }
            [self reloadData];
        }
        [self.mainTableView.mj_header endRefreshing];
        [self.mainTableView.mj_footer endRefreshing];
        
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
    return 2;
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

    cell.tLabel.text = @"系统消息";
//    cell.dLabel.text = model.message;
    if (indexPath.section == 0) {
        cell.dLabel.text = @"尊敬的小小，你提交的紧急就医服务已预约成功！请您按时就诊，如有疑问请联系您的专属客服！联系电话：400-400-400尊敬的小小，你提交的紧急就医服务已预约成功！请您按时就诊，如有疑问请联系您的专属客服！联系电话：400-400-400";
    }else {
        cell.dLabel.text = @"akj ;aklsjdf k;ajl ;jd;lkj a;dlfakj ;lkaj ;sdkaj a; kj";
    }
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
