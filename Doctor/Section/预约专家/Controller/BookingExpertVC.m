//
//  BookingExpertVC.m
//  Doctor
//
//  Created by zt on 2019/1/6.
//  Copyright © 2019 AnyOne. All rights reserved.
//

#import "BookingExpertVC.h"
#import "ZYLMultiselectView.h"
#import "BRStringPickerView.h"
#import "BookingExpertCell.h"

@interface BookingExpertVC ()<UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar *mSearchBar;
@property (nonatomic, strong) UIButton *selectTypeButton;
@property (nonatomic, strong) UILabel *selectTypeLabel;

@property (nonatomic,assign) NSInteger pageIndex;
@property (nonatomic, strong) NSMutableArray *dataArr;//获取到的数据
@property (nonatomic,assign) NSInteger selectIndex;

@property (nonatomic,strong) NSMutableArray *accompanyArr;//陪诊员
@property (nonatomic,strong) NSMutableArray *departmentArr;//科室
@property (nonatomic,strong) NSMutableArray *nurseArr;//护士

@property (nonatomic,assign) NSInteger selectNurseIndex;


@end

@implementation BookingExpertVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.accompanyArr = [NSMutableArray array];
    self.nurseArr = [NSMutableArray array];
    self.departmentArr = [NSMutableArray array];
    [self configWithTitle:@"专家库" backImage:nil];
    self.backBtn.hidden = YES;
    self.naviBGView.backgroundColor = [UIColor whiteColor];
    [self createSearch];
    [self request];
}

- (void)request {
    LRWeakSelf;
    if (self.pageIndex < 1) {
        self.pageIndex = 1;
    }
    NSString *url = [NSString stringWithFormat:@"%@?pageNo=%ld&pageSize=%d&search_EQ_orderStatus=2,3,4",URL_PayedsPage,(long)self.pageIndex,PageSize];
//    if (self.selectIndex > 0) {
//        self.pageIndex = 1;
//        NSDictionary *typeDic = self.serviceTypeArr[self.selectIndex - 1];
//        NSString *typeId = typeDic[@"typeCode"];
//        url = [NSString stringWithFormat:@"%@?search_EQ_buyGoodsType=%@&pageNo=%ld&pageSize=%d",URL_Goods,typeId,(long)self.pageIndex,PageSize];
//    }
    [HYBNetworking getWithUrl:url refreshCache:YES success:^(id response) {
        
        NSLog(@"====预约专家页面%@",response);
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
#pragma mark - 搜索
- (void)createSearch {
    _mSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(130, kNavigationBarHeight - 0.5, self.view.frame.size.width - 140, 56)];
    self.mSearchBar.barTintColor = HEXCOLOR(0x9F9F9F); //设置搜索框背景颜色为灰色
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
    _mSearchBar.placeholder = @"请输入医生姓名";
    _mSearchBar.delegate = self;
    
    [self.mainTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.mSearchBar.mas_bottom).with.offset(0);
    }];
    
    self.selectTypeButton = [[UIButton alloc]initWithFrame:CGRectMake(17, kNavigationBarHeight + 10, 113, 33)];
    [self.view addSubview:self.selectTypeButton];
    [self.selectTypeButton setBackgroundColor:HEXCOLOR(0xF3F3F3)];
    self.selectTypeButton.layer.cornerRadius = 4;
    self.selectTypeButton.layer.masksToBounds = YES;
    
    self.selectTypeLabel = [[UILabel alloc]init];
    [self.selectTypeButton addSubview:self.selectTypeLabel];
    self.selectTypeLabel.text = @"请选择科室";
    self.selectTypeLabel.textColor = HEXCOLOR(0x9F9F9F);
    self.selectTypeLabel.font = [UIFont systemFontOfSize:13];
    [self.selectTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(0);
    }];
    [self.selectTypeButton addTarget:self action:@selector(selectTypeAction:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *imageView = [[UIImageView alloc]init];
    [self.selectTypeButton addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(self.selectTypeLabel.mas_right).offset(10);
    }];
    imageView.image = [UIImage imageNamed:@"icon_26"];
    
    self.selectTypeButton.layer.cornerRadius = 4;
    self.selectTypeButton.layer.masksToBounds = YES;
    
    registerNibWithCellName(self.mainTableView, @"BookingExpertCell");
}

- (void)selectTypeAction:(UIButton *)btn {
    
    @weakify(self);
    [HYBNetworking getWithUrl:URL_DepartmentPage refreshCache:YES success:^(id response) {
        NSDictionary *dic = response;
        if ([dic[@"code"] isEqual:@100]) {
            NSDictionary *data = dic[@"data"];
            NSArray *list = data[@"list"];
            self.departmentArr = [NSMutableArray arrayWithArray:list];
            NSString *str = self.selectTypeLabel.text;
            BOOL isContains = NO;
            NSMutableArray *selectArr = [NSMutableArray array];
            for (NSDictionary *subDic in self.departmentArr) {
                [selectArr addObject:subDic[@"department"]];
                if ([subDic[@"department"] isEqualToString:str]) {
                    isContains = YES;
                }
            }
            if (!isContains) {
                NSDictionary *dic = self.departmentArr[0];
                str = dic[@"department"];
            }
            [BRStringPickerView showStringPickerWithTitle:@"请选择科室" dataSource:selectArr defaultSelValue:str isAutoSelect:NO resultBlock:^(id selectValue) {
                @strongify(self);
                NSInteger selectIndex = [selectArr indexOfObject:selectValue];
                self.selectIndex = selectIndex + 1;
                self.selectTypeLabel.text = selectArr[selectIndex];
                [self request];
            }];
        }else {
            [MBProgressHUD showAlertWithView:self.view andTitle:@"请求失败"];
        }
    } fail:^(NSError *error, NSInteger statusCode) {
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

#pragma mark - UITableViewDelegate UITableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    return self.orderpageSubModelArr.count;
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return 109.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BookingExpertCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookingExpertCell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dic = self.dataArr[indexPath.section];
    cell.nameLabel.text = [NSString stringWithFormat:@"%@",dic[@"doctor"]];
    cell.midLabel.text = [NSString stringWithFormat:@"%@",dic[@"department"]];
    cell.hospitalLabel.text = [NSString stringWithFormat:@"%@",dic[@"hospital"]];
    cell.bookingIntro.text = [NSString stringWithFormat:@"%@",dic[@"hospital"]];
    [cell.rightBtn addTarget:self action:@selector(assignAccompany:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    NSLog(@"click");
}

- (void)assignAccompany:(UIButton *)btn {
    [HYBNetworking getWithUrl:@"user/attend/page" refreshCache:YES success:^(id response) {
        NSDictionary *dic = response;
        if ([dic[@"code"] isEqual:@100]) {
            NSDictionary *data = dic[@"data"];
            NSArray *list = data[@"list"];
            self.nurseArr = [NSMutableArray arrayWithArray:list];
            ZYLMultiselectView *zylmus = [[ZYLMultiselectView alloc] initWithFrame:self.view.bounds];
            zylmus.heraderStr = @"分配陪诊员";
            NSMutableArray *nurseArr = [NSMutableArray array];
            for (NSDictionary *subDic in self.nurseArr) {
                [nurseArr addObject:subDic[@"name"]];
            }
            zylmus.dataArr = nurseArr;
            
            if (self.accompanyArr.count != 0) {
                
                [zylmus.resultArr addObjectsFromArray:self.accompanyArr];
                
            }
            
            [self.view addSubview:zylmus];
            
            __weak __typeof(self) weakself = self;
            
            zylmus.SelectBlock = ^(NSMutableArray *selectArr){
                
                if (selectArr != nil) {
                    
                    [self.accompanyArr removeAllObjects];
                    
                    //            [self.resultArr removeAllObjects];
                    
                    [self.accompanyArr addObjectsFromArray:selectArr];
                    
                    for (int i = 0; i < selectArr.count; i ++) {
                        
                        int row = [selectArr[i] intValue];
                        
                        //                [self.resultArr addObject:weakself.dataArr[row]];
                        
                    }
                    
                    //            NSString *str = [self.resultArr componentsJoinedByString:@","];
                    //
                    //            [self.btn setTitle:str forState:UIControlStateNormal];
                    
                    
                }else{
                    
                    
                    
                }
                
            };
        }else {
            [MBProgressHUD showAlertWithView:self.view andTitle:@"请求失败"];
        }
    } fail:^(NSError *error, NSInteger statusCode) {
        [MBProgressHUD showAlertWithView:self.view andTitle:@"连接服务器失败"];
    }];

    
}
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

@end
