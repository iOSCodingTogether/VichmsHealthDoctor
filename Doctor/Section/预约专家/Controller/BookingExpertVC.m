//
//  BookingExpertVC.m
//  Doctor
//
//  Created by zt on 2019/1/6.
//  Copyright © 2019 AnyOne. All rights reserved.
//

#import "BookingExpertVC.h"
#import "ZYLMultiselectView.h"

#import "BookingExpertCell.h"

@interface BookingExpertVC ()<UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar *mSearchBar;
@property (nonatomic, strong) UIButton *selectTypeButton;
@property (nonatomic, strong) UILabel *selectTypeLabel;

@property (nonatomic,strong) NSMutableArray *accompanyArr;//陪诊员

@end

@implementation BookingExpertVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.accompanyArr = [NSMutableArray array];
    
    [self configWithTitle:@"专家库" backImage:nil];
    self.backBtn.hidden = YES;
    self.naviBGView.backgroundColor = [UIColor whiteColor];
    [self createSearch];
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
    
    [HYBNetworking getWithUrl:URL_DepartmentPage refreshCache:YES success:^(id response) {
        
        NSLog(@"===预约专家--查找科室%@",response);
    } fail:^(NSError *error, NSInteger statusCode) {
        
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
    [cell.rightBtn addTarget:self action:@selector(assignAccompany:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    NSLog(@"click");
}

- (void)assignAccompany:(UIButton *)btn {
    ZYLMultiselectView *zylmus = [[ZYLMultiselectView alloc] initWithFrame:self.view.bounds];
    zylmus.heraderStr = @"分配陪诊员";
    
    zylmus.dataArr = [NSMutableArray arrayWithArray:@[@"护士1",@"护士2",@"护士3",@"护士4",@"护士5",@"护士6",@"护士7",@"护士8",@"护士9",@"护士10",@"护士11"]];
    
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
        
\
    };
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
