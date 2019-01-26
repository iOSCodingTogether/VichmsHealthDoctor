//
//  OrderVC.m
//  Doctor
//
//  Created by zt on 2019/1/13.
//  Copyright © 2019年 AnyOne. All rights reserved.
//

#import "OrderVC.h"
#import "AccompanyTableViewCell.h"
#import "CommentVC.h"
#import "AccompanyRecordVC.h"
#import "BRDatePickerView.h"
@interface OrderVC ()<UITextFieldDelegate>
@property (nonatomic,strong) NSMutableArray *dataArray;
//@property (nonatomic, strong) NSMutableArray <MessagePageResultSubModel *> *messagepageSubModelArr;     //
@property (nonatomic,assign) NSInteger pageIndex;

@property (nonatomic,strong) NSMutableArray *serviceTypeArr;
@property (nonatomic, strong) UITextField *mSearchText;
@property (nonatomic,strong) UIButton *selectTypeButton;
@property (nonatomic,strong) UILabel *selectTypeLabel;

@property (nonatomic,strong) UIButton *startButton;
@property (nonatomic,strong) UILabel *startLabel;

@property (nonatomic,strong) UIButton *endButton;
@property (nonatomic,strong) UILabel *endLabel;
@property (nonatomic,assign) NSInteger selectIndex;


@end
@implementation OrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self configWithTitle:@"订单列表" backImage:@""];
    self.rightTitle = @"清空筛选";
    [self.rightBtn addTarget:self action:@selector(clearSelect) forControlEvents:UIControlEventTouchUpInside];    
    self.dataArray = [NSMutableArray array];
    self.serviceTypeArr = [NSMutableArray array];
    [self createSearchV];
}
- (void)clearSelect {
    self.startLabel.text = @"开始日期";
    self.endLabel.text = @"结束日期";
    self.selectIndex = 0;
    self.selectTypeLabel.text = @"请选择服务类型";
    self.mSearchText.text = @"";
    [self request:YES];
}
//MARK:创建ui
- (void)createSearchV {
    
    registerNibWithCellName(self.mainTableView, @"NewMyServiceTableViewCell");
    
    UIView *topV = [[UIView alloc]initWithFrame:CGRectMake(0, kNavigationBarHeight, SCREENW, 96)];
    [self.view addSubview:topV];
    topV.backgroundColor = [UIColor whiteColor];
    [self createSearchWithView:topV];
    
    
    self.mainTableView.frame = CGRectMake(0, CGRectGetMaxY(topV.frame), SCREENW, SCREENH - CGRectGetMaxY(topV.frame));
    LRWeakSelf;
    registerNibWithCellName(self.mainTableView, @"AccompanyTableViewCell");
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
- (void)createSearchWithView:(UIView *)topV {
    
    CGFloat height = 33;
    CGFloat leftXSpace = 17;
    CGFloat leftW = (SCREENW - leftXSpace*2 - 10)/2.0;
    self.selectTypeButton = [[UIButton alloc]initWithFrame:CGRectMake(leftXSpace, 10, leftW, height)];
    [topV addSubview:self.selectTypeButton];
    [self.selectTypeButton setBackgroundColor:HEXCOLOR(0xF3F3F3)];
    self.selectTypeButton.layer.cornerRadius = 4;
    self.selectTypeButton.layer.masksToBounds = YES;
    
    self.selectTypeLabel = [[UILabel alloc]init];
    [self.selectTypeButton addSubview:self.selectTypeLabel];
    self.selectTypeLabel.text = @"请选择服务类型";
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
        make.width.equalTo(self.selectTypeLabel.mas_height);
    }];
    imageView.image = [UIImage imageNamed:@"icon_26"];
    
    self.selectTypeButton.layer.cornerRadius = 4;
    self.selectTypeButton.layer.masksToBounds = YES;
    
    self.mSearchText = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.selectTypeButton.frame) + 10, 10, self.view.frame.size.width - (CGRectGetMaxX(self.selectTypeButton.frame) + 10) - leftXSpace, height)];
    //    self.mSearchText.textColor = HEXCOLOR(0x9F9F9F);
    [topV addSubview:_mSearchText];
    self.mSearchText.returnKeyType = UIReturnKeySearch;
    self.mSearchText.delegate = self;
    self.mSearchText.layer.cornerRadius = 4;
    self.mSearchText.borderStyle = UITextBorderStyleNone;
    self.mSearchText.layer.masksToBounds = YES;
    self.mSearchText.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    self.mSearchText.leftViewMode = UITextFieldViewModeAlways;
    [self.mSearchText setBackgroundColor:HEXCOLOR(0xf3f3f3)];
    self.mSearchText.font = [UIFont systemFontOfSize:13];
    self.mSearchText.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入医生姓名" attributes:@{NSForegroundColorAttributeName:HEXCOLOR(0x9F9F9F)}];
    
    self.startButton = [[UIButton alloc]initWithFrame:CGRectMake(leftXSpace, CGRectGetMaxY(self.selectTypeButton.frame) + 10, leftW, height)];
    [topV addSubview:self.startButton];
    [self.startButton setBackgroundColor:HEXCOLOR(0xF3F3F3)];
    self.startButton.layer.cornerRadius = 4;
    self.startButton.layer.masksToBounds = YES;
    
    self.startLabel = [[UILabel alloc]init];
    [self.startButton addSubview:self.startLabel];
    self.startLabel.text = @"开始日期";
    self.startLabel.textColor = HEXCOLOR(0x9F9F9F);
    self.startLabel.font = [UIFont systemFontOfSize:13];
    [self.startLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(0);
    }];
    [self.startButton addTarget:self action:@selector(selectStartData:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *imageView1 = [[UIImageView alloc]init];
    [self.startButton addSubview:imageView1];
    [imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(0);
        make.width.equalTo(self.selectTypeLabel.mas_height);
    }];
    imageView1.image = [UIImage imageNamed:@"icon_33"];
    
    self.startButton.layer.cornerRadius = 4;
    self.startButton.layer.masksToBounds = YES;
    
    self.endButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.startButton.frame) + 10, CGRectGetMinY(self.startButton.frame), self.view.frame.size.width - (CGRectGetMaxX(self.selectTypeButton.frame) + 10) - leftXSpace, height)];
    [topV addSubview:self.endButton];
    [self.endButton setBackgroundColor:HEXCOLOR(0xF3F3F3)];
    self.endButton.layer.cornerRadius = 4;
    self.endButton.layer.masksToBounds = YES;
    
    self.endLabel = [[UILabel alloc]init];
    [self.endButton addSubview:self.endLabel];
    self.endLabel.text = @"结束日期";
    self.endLabel.textColor = HEXCOLOR(0x9F9F9F);
    self.endLabel.font = [UIFont systemFontOfSize:13];
    [self.endLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(0);
    }];
    [self.endButton addTarget:self action:@selector(selectEndData:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *imageView2 = [[UIImageView alloc]init];
    [self.endButton addSubview:imageView2];
    [imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(0);
        make.width.equalTo(self.selectTypeLabel.mas_height);
    }];
    imageView2.image = [UIImage imageNamed:@"icon_33"];
    
    self.endButton.layer.cornerRadius = 4;
    self.endButton.layer.masksToBounds = YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)aTextfield {
    [self.mSearchText resignFirstResponder];//关闭键盘
    self.pageIndex = 1;
    [self request:YES];
    return YES;
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

//MARK:点击事件
- (void)selectTypeAction:(UIButton *)btn {
    [self.mSearchText endEditing:YES];
    [self getServiceType];
}
//MARK:数据请求
- (void)getServiceType {
    @weakify(self);
    [HYBNetworking getWithUrl:URL_GoodsTypes refreshCache:YES success:^(id response) {
        NSLog(@"===服务类型%@",response);
        @strongify(self);
        NSDictionary *dic = response;
        if ([dic[@"code"] isEqual:@100]) {
            NSArray *data = dic[@"data"];
            self.serviceTypeArr = [NSMutableArray arrayWithArray:data];
            if (self.serviceTypeArr.count == 0) {
                [MBProgressHUD showAlertWithView:self.view andTitle:@"暂无可选择的服务类型"];
                return ;
            }
            NSString *str = self.selectTypeLabel.text;
            BOOL isContains = NO;
            NSMutableArray *selectArr = [NSMutableArray array];
            for (NSDictionary *subDic in self.serviceTypeArr) {
                [selectArr addObject:subDic[@"typeName"]];
                if ([subDic[@"typeName"] isEqualToString:str]) {
                    isContains = YES;
                }
            }
            if (!isContains) {
                NSDictionary *dic = self.serviceTypeArr[0];
                str = dic[@"typeName"];
            }
            [BRStringPickerView showStringPickerWithTitle:@"请选择服务类型" dataSource:selectArr defaultSelValue:str isAutoSelect:NO resultBlock:^(id selectValue) {
                @strongify(self);
                NSInteger selectIndex = [selectArr indexOfObject:selectValue];
                self.selectIndex = selectIndex + 1;
                self.selectTypeLabel.text = selectArr[selectIndex];
                [self request:YES];
            }];
            
        }else {
            [MBProgressHUD showAlertWithView:self.view andTitle:@"请求失败"];
        }
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
        
    }];
}
- (void)selectStartData:(UIButton *)btn {
    [self.mSearchText endEditing:YES];
    NSString *str = self.startLabel.text;
    if (![str isEqualToString:@"开始日期"]) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        str = [dateFormatter stringFromDate:[NSDate date]];
    }
    @weakify(self);
    [BRDatePickerView showDatePickerWithTitle:@"请选择开始日期" dateType:UIDatePickerModeDate defaultSelValue:str minDateStr:@"" maxDateStr:@"" isAutoSelect:NO resultBlock:^(NSString *selectValue,NSDate *date) {
        if(date){
            @strongify(self);
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            //                [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSString *destDateString = [dateFormatter stringFromDate:date];
            self.startLabel.text = destDateString;
            self.pageIndex = 1;
            [self request:YES];
            //            dispatch_async(dispatch_get_main_queue(), ^{
            //                @strongify(self);
            //
            //            });
        }
    }];
}
- (void)selectEndData:(UIButton *)btn {
    [self.mSearchText endEditing:YES];
    NSString *str = self.endLabel.text;
    if (![str isEqualToString:@"结束日期"]) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        str = [dateFormatter stringFromDate:[NSDate date]];
    }
    @weakify(self);
    [BRDatePickerView showDatePickerWithTitle:@"请选择结束日期" dateType:UIDatePickerModeDate defaultSelValue:str minDateStr:self.startLabel.text maxDateStr:@"" isAutoSelect:NO resultBlock:^(NSString *selectValue,NSDate *date) {
        if(date){
            @strongify(self);
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            //                [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSString *destDateString = [dateFormatter stringFromDate:date];
            self.endLabel.text = destDateString;
            self.pageIndex = 1;
            [self request:YES];
            
        }
    }];
}
-(void)request:(BOOL)isLoadMore{
    
    LRWeakSelf;
    if (self.pageIndex < 1) {
        self.pageIndex = 1;
    }
    
    NSString *startTime = self.startLabel.text;
    NSString *endTime  = self.endLabel.text;
    if ([self.startLabel.text isEqualToString:@"开始日期"]) {
        startTime = @"";
    }
    if ([self.endLabel.text isEqualToString:@"结束日期"]) {
        endTime = @"";
    }
//    [URL_AttendPage stringByAppendingFormat:@"?pageNo=%ld&pageSize=%d",self.pageIndex,PageSize]
    NSString *url = [[NSString stringWithFormat:@"%@?pageNo=%ld&pageSize=%d&search_EQ_personName=%@&search_GTE_visitTime=%@&search_LTE_visitTime=%@",URL_AttendPage,(long)self.pageIndex,PageSize,self.mSearchText.text,startTime,endTime] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if (self.selectIndex > 0) {
        self.pageIndex = 1;
        NSDictionary *typeDic = self.serviceTypeArr[self.selectIndex - 1];
        NSString *typeId = typeDic[@"typeCode"];
        url = [[NSString stringWithFormat:@"%@?search_EQ_buyGoodsType=%@&pageNo=%ld&pageSize=%d&search_EQ_personName=%@&search_GTE_visitTime=%@&search_LTE_visitTime=%@",URL_AttendPage,typeId,(long)self.pageIndex,PageSize,self.mSearchText.text,startTime,endTime] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    
    [HYBNetworking getWithUrl:url refreshCache:YES success:^(id response) {
        
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
    if ([[NSString stringWithFormat:@"%@",dic[@"orderStatus"]] integerValue] < 5) {
        [cell.statusBtn setTitle:@"确认完成" forState:UIControlStateNormal];
        cell.statusBtn.enabled = YES;
    }else {
        [cell.statusBtn setTitle:@"已完成" forState:UIControlStateNormal];
        cell.statusBtn.enabled = NO;
    }
    ViewBorderRadius(cell.lookRecord, 2, 1, HEXCOLOR(0x00A3FE));
    ViewBorderRadius(cell.lookComment, 2, 1, HEXCOLOR(0x00A3FE));

    cell.lookRecord.hidden = NO;
    cell.lookComment.hidden = NO;
    [cell.lookRecord addTarget:self action:@selector(lookRecord:) forControlEvents:UIControlEventTouchUpInside];
    [cell.lookComment addTarget:self action:@selector(lookComment:) forControlEvents:UIControlEventTouchUpInside];
    [cell.statusBtn addTarget:self action:@selector(changeOrderStatus:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    NSLog(@"click");
}
- (void)changeOrderStatus:(UIButton *)btn {
    if ([btn.titleLabel.text isEqualToString:@"已完成"]) {
        [MBProgressHUD showAlertWithView:self.view andTitle:@"该订单已完成，无需再次操作"];
        return;
    }
    UIView *contentView = [btn superview];
    AccompanyTableViewCell *cell = (AccompanyTableViewCell *)[contentView superview];
    NSIndexPath *indexPath = [self.mainTableView indexPathForCell:cell];
    NSDictionary *dic = self.dataArray[indexPath.section];

    [HYBNetworking postWithUrl:URL_ModifyOrderStatus body:@{@"guid":[NSString stringWithFormat:@"%@",dic[@"id"]],@"orderStatus":@5} success:^(id response) {
        NSDictionary *dic = response;
        if ([dic[@"code"] isEqual:@100]) {
            [MBProgressHUD showAlertWithView:self.view andTitle:@"修改成功"];
            self.pageIndex = 1;
            [self request:YES];
        }else {
            [MBProgressHUD showAlertWithView:self.view andTitle:@"请求失败"];
        }
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
    }];
    
    
}
- (void)lookComment:(UIButton *)btn {
    CommentVC *vc = [CommentVC new];
    vc.isEdit = NO;
    UIView *contentView = [btn superview];
    AccompanyTableViewCell *cell = (AccompanyTableViewCell *)[contentView superview];
    NSIndexPath *indexPath = [self.mainTableView indexPathForCell:cell];
    NSDictionary *dic = self.dataArray[indexPath.section];
    vc.orderId = dic[@"id"];
    vc.topDic = dic;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)lookRecord:(UIButton *)btn{
//    [nurseDic[@"nurseStatus"] integerValue]
//    //陪诊记录
    UIView *contentView = [btn superview];
    AccompanyTableViewCell *cell = (AccompanyTableViewCell *)[contentView superview];
    NSIndexPath *indexPath = [self.mainTableView indexPathForCell:cell];
    AccompanyRecordVC *vc = [AccompanyRecordVC new];
    NSDictionary *dic = self.dataArray[indexPath.section];
    vc.orderId = dic[@"id"];
    vc.isEdit = NO;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
