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

@end

@implementation ExpertIntroduceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createViews];
//    [self request];
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
//-(void)request{
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
//
//
//}

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
    return 10;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ExpertIntroduceTopCell *curCell = [tableView dequeueReusableCellWithIdentifier:@"ExpertIntroduceTopCell"];
    curCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    [curCell.leftImageView sd_setImageWithURL:COMBINE_SUFFER_IMAGE(self.infoModel.headPic)];
    curCell.nameLabel.text = @"123";
    NSString *dutyStr = nil;
    dutyStr = @"12345";
//    if(self.infoModel.duty.length>0 && ![self.infoModel.duty isEqualToString:@"无"]){
//        dutyStr = [NSString stringWithFormat:@"%@  %@",self.infoModel.department,self.infoModel.duty];
//    }
//    else{
//        dutyStr = [NSString stringWithFormat:@"%@  %@",self.infoModel.department,@""];
//    }
//    curCell.midLabel.text = dutyStr;
    curCell.midLabel.text = @"123444";
    curCell.hospitalLabel.text = @"jaslkj;";

//    curCell.hospitalLabel.text = self.infoModel.hospitalName;

    
    
    return curCell;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
