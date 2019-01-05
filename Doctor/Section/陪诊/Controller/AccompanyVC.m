//
//  BookingVC.m
//  Doctor
//
//  Created by zt on 2019/1/4.
//  Copyright © 2019年 AnyOne. All rights reserved.
//
#import "AccompanyVC.h"
#import "AccompanyTableViewCell.h"
#import "BRStringPickerView.h"
#import "OrderPageMyRequestModel.h"
#import "CommonManage.h"
#import "UIButton+Block.h"
#import "AccompanyRecordVC.h"
@interface AccompanyVC ()< UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate>
@property (nonatomic, strong) UISearchBar *mSearchBar;

@property (nonatomic, strong) NSMutableArray *dataArr;//获取到的数据
@property (nonatomic, strong) NSMutableArray *showArr;
@property (nonatomic, strong) NSString * searchGoodsTypeType;     //

@property (nonatomic, strong) NSMutableArray <OrderPageMyResultSubModel *> *orderpageSubModelArr;     //

@end

@implementation AccompanyVC
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configWithTitle:@"陪诊列表" backImage:@""];
    self.backBtn.hidden = YES;
    self.naviBGView.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createViews];
    _orderpageSubModelArr = [NSMutableArray array];
    //    [self request:NO];
    
    [self reloadData];
}
- (void)createViews{
    registerNibWithCellName(self.mainTableView, @"AccompanyTableViewCell");
    [self createSearchBar];
    LRWeakSelf;
    self.mainTableView.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //        [self request:YES];
        
    }];
}
- (void)createSearchBar {
    _mSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight - 0.5, self.view.frame.size.width, 56)];
    self.mSearchBar.barTintColor = HEXCOLOR(0xffffff); //设置搜索框背景颜色为灰色
    [self.view addSubview:_mSearchBar];
    _mSearchBar.searchBarStyle =UISearchBarStyleMinimal;
    UITextField *searchField = [self.mSearchBar valueForKey:@"searchField"];
    if (searchField) {
        searchField.layer.cornerRadius = 4;
        searchField.borderStyle = UITextBorderStyleNone;
        searchField.layer.masksToBounds = YES;
        searchField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
        
    }
    [searchField setBackgroundColor:HEXCOLOR(0xf3f3f3)];
    searchField.font = [UIFont systemFontOfSize:13];
    _mSearchBar.placeholder = @"请输入姓名";
    _mSearchBar.delegate = self;
    
    [self.mainTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.mSearchBar.mas_bottom).with.offset(0);
    }];
    
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
//-(void)request:(BOOL)isLoadMore{
//    OrderPageMyRequestModel *model = [OrderPageMyRequestModel new];
//    model.pageSize = 10;
//
//    if(!isLoadMore){
//        model.pageSize = 20;
//
//        model.pageNo = 1;
//    }
//    else{
//        model.pageSize = 10;
//
//        model.pageNo = [model nextPageNoForCurDataCount:self.orderpageSubModelArr.count];
//    }
//    model.search_EQ_buyGoodsType= self.searchGoodsTypeType;
//    [BaseRequest requestWithRequestModel:model ret:^(BOOL success, __kindof OrderPageMyResultModel *dataModel, NSString *jsonObjc) {
//        if(dataModel.success){
//            if(!isLoadMore){
//                self.orderpageSubModelArr =[NSMutableArray arrayWithArray:  dataModel.list];
//            }
//            else{
//
//                [self.orderpageSubModelArr addObjectsFromArray:dataModel.list];
//            }
//            [self reloadData];
//        }
//        [self.mainTableView.mj_header endRefreshing];
//        [self.mainTableView.mj_footer endRefreshing];
//
//    }];
//
//
//}
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.orderpageSubModelArr.count;
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 12;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AccompanyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AccompanyTableViewCell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0) {
        //确认接单
        [cell.statusBtn setTitle:@"确认接单" forState:UIControlStateNormal];
        cell.statusBtn.backgroundColor = HEXCOLOR(0x00A3FE);
        [cell.statusBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else if(indexPath.section == 1) {
        //开始陪诊
        [cell.statusBtn setTitle:@"开始陪诊" forState:UIControlStateNormal];
        cell.statusBtn.backgroundColor = HEXCOLOR(0x00A3FE);
        [cell.statusBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    }else if(indexPath.section == 2) {
        //陪诊记录
        [cell.statusBtn setTitle:@"陪诊记录" forState:UIControlStateNormal];
        cell.statusBtn.backgroundColor = [UIColor whiteColor];
        [cell.statusBtn setTitleColor:HEXCOLOR(0x00A3FE) forState:UIControlStateNormal];
    }
    [cell.statusBtn addTarget:self action:@selector(lookRecord:) forControlEvents:UIControlEventTouchUpInside];
    //    OrderPageMyResultSubModel *model = self.orderpageSubModelArr[indexPath.row];
    //    cell.labelTop.text = model.doctor;
    //    cell.labelL1.text = @{@"1":@"第一次就诊",@"2":@"复诊"}[model.orderType];
    //    cell.labelL2.text = model.personName;
    //    cell.labelL3.text = model.hospital;
    //    cell.labelL4.text = [NSString stringWithFormat:@"%@", model.orderMoney];
    //    cell.labelR1.text =  LRTimeIntervalFromToFormatter(model.visitTime, @"yyyy-MM-dd'T'HH:mm:ss.SSSZ", @"yyyy-MM-dd");
    //    cell.labelR2.text = model.personAge;
    //    cell.labelR3.text = model.department;
    //    cell.btn2.hidden =YES;
    //    cell.btn3.hidden =NO;
    //    cell.btn4.hidden =NO;
    //    [cell.btn3 setTitle:@"申请中" forState:UIControlStateNormal];
    //    [cell.btn4 setTitle:@"立即支付" forState:UIControlStateNormal];
    //    [cell.btn3 addAction:^(UIButton *btn) {
    //        [self pushViewController: [MemberBuyVC new]];
    //    }];
    //    [cell.btn4 addAction:^(UIButton *btn) {
    //        [self pushViewController:[ MemberBuyVC new]];
    //    }];
    return cell;
}

- (void)lookRecord:(UIButton *)btn {
    if ([btn.titleLabel.text isEqualToString:@"陪诊记录"]) {
        AccompanyRecordVC *vc = [AccompanyRecordVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    NSLog(@"click");
}


//#pragma mark - 引入索引的一个代理方法
//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
//
//    return self.keys;
//}
//#pragma mark - section上的标题（A B C D……Z）
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//
//    return self.keys[section];
//}

#pragma mark - UISearchBar - delegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    //    if(searchText.length > 0){
    //        self.grayViewButton.hidden = YES;
    //    }
    //    else{
    //        self.grayViewButton.hidden = NO;
    //    }
    [self reloadData];
}
- (void)searchBarSearchButtonClicked:(UISearchBar*)searchBar{
    [self.view endEditing:YES];
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    //    if(searchBar.text.length > 0){
    //        self.grayViewButton.hidden = YES;
    //    }
    //    else{
    //        self.grayViewButton.hidden = NO;
    //    }
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    //    self.grayViewButton.hidden = YES;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
