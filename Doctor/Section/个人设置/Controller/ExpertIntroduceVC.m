//
//  ExpertIntroduceVC.m
//  Suffer
//
//  Created by  licc on 2018/9/2.
//  Copyright © 2018年 AnyOne. All rights reserved.
//

#import "ExpertIntroduceVC.h"
#import "ExpertIntroduceTopCell.h"
//#import "DoctorPageRequestModel.h"
//#import "OrderCreateVC.h"

@interface ExpertIntroduceVC ()<UISearchBarDelegate>
@property (nonatomic, strong) UISearchBar *mSearchBar;
@property (nonatomic,strong) UIButton *selectTypeButton;
@property (nonatomic,strong) UILabel *selectTypeLabel;
//@property (nonatomic, strong) DoctorPageResultSubModel * infoModel;;     //

@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,assign) NSInteger pageIndex;

@end

@implementation ExpertIntroduceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createViews];
    [self request];
}

-(void)createViews{
    [self configWithTitle:@"我的医生" backImage:@""];
    self.naviBGView.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];

    [self createSearch];
    registerNibWithCellName(self.mainTableView, @"ExpertIntroduceTopCell");
    self.mainTableView.estimatedRowHeight = 60;
    [self.mainTableView setSeparatorInset:UIEdgeInsetsMake(0, 10, 0, 10)];
    self.mainTableView.bounces = NO;
//    self.mainTableView.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [self request];
//
//    }];
}
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
    
}
- (void)selectTypeAction:(UIButton *)btn {
    
}
//
-(void)request{
    LRWeakSelf;
    if (self.pageIndex < 1) {
        self.pageIndex = 1;
    }
    [HYBNetworking getWithUrl:URL_Doctors refreshCache:YES success:^(id response) {
        
        NSLog(@"====我的医生%@",response);
        NSDictionary *dic = response;
        if ([dic[@"code"] isEqual:@100]) {
            NSArray *arr = dic[@"data"];
            
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

//-(void)reloadData{
//    [self.mainTableView reloadData];
//}
#pragma mark - UITableViewDelegate, UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 12;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENW, 12)];
    view.backgroundColor = LR_TABLE_BACKGROUNDCOLOR;
    return view;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ExpertIntroduceTopCell *curCell = [tableView dequeueReusableCellWithIdentifier:@"ExpertIntroduceTopCell"];
    curCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    [curCell.leftImageView sd_setImageWithURL:COMBINE_SUFFER_IMAGE(self.infoModel.headPic)];
    NSDictionary *dic = self.dataArray[indexPath.row];
    curCell.nameLabel.text = [NSString stringWithFormat:@"%@",dic[@"name"]];
    NSString *dutyStr = nil;
    NSString *duty = dic[@"duty"];
    if([duty length]>0 && ![duty isEqualToString:@"无"]){
        dutyStr = [NSString stringWithFormat:@"%@  %@",dic[@"department"],dic[@"duty"]];
    }
    else{
        dutyStr = [NSString stringWithFormat:@"%@  %@",dic[@"department"],@""];
    }

    curCell.midLabel.text = dutyStr;
    curCell.hospitalLabel.text = [NSString stringWithFormat:@"%@",dic[@"hospitalName"]];
    NSString *headUrl = [NSString stringWithFormat:@"%@",dic[@"headPic"]];
    [curCell.leftImageView sd_setImageWithURL:[NSURL URLWithString:headUrl]];
    curCell.leftImageView.layer.cornerRadius = 40;
    
    return curCell;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
