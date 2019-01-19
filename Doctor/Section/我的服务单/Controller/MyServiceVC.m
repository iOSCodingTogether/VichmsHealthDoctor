//
//  MyServiceVC.m
//  Doctor
//
//  Created by zt on 2019/1/4.
//  Copyright © 2019年 AnyOne. All rights reserved.
//

#import "MyServiceVC.h"
//#import "MyServiceTableViewCell.h"
#import "NewMyServiceTableViewCell.h"
#import "CommentVC.h"
#import "BRStringPickerView.h"
#import "BRDatePickerView.h"
@interface MyServiceVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITextField *mSearchText;
@property (nonatomic,strong) UIButton *selectTypeButton;
@property (nonatomic,strong) UILabel *selectTypeLabel;

@property (nonatomic,strong) UIButton *startButton;
@property (nonatomic,strong) UILabel *startLabel;

@property (nonatomic,strong) UIButton *endButton;
@property (nonatomic,strong) UILabel *endLabel;
@property (nonatomic,assign) NSInteger selectIndex;


@property (nonatomic,assign) NSInteger pageIndex;
@property (nonatomic, strong) NSMutableArray *dataArr;//获取到的数据
@property (nonatomic,strong) NSMutableArray *serviceTypeArr;//服务类型数据


@end

@implementation MyServiceVC
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configWithTitle:@"我的服务单" backImage:@""];
    self.backBtn.hidden = YES;
    self.naviBGView.backgroundColor = [UIColor whiteColor];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.serviceTypeArr = [NSMutableArray array];
    [self createSearchV];
    
    [self request:NO];

    
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
        
        [MBProgressHUD showAlertWithView:self.view andTitle:@"连接服务器失败"];
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
    NSString *url = [[NSString stringWithFormat:@"%@?pageNo=%ld&pageSize=%d&search_EQ_personName=%@&search_GTE_visitTime=%@&search_LTE_visitTime=%@",URL_Goods,(long)self.pageIndex,PageSize,self.mSearchText.text,startTime,endTime] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if (self.selectIndex > 0) {
        self.pageIndex = 1;
        NSDictionary *typeDic = self.serviceTypeArr[self.selectIndex - 1];
        NSString *typeId = typeDic[@"typeCode"];
        url = [[NSString stringWithFormat:@"%@?search_EQ_buyGoodsType=%@&pageNo=%ld&pageSize=%d&search_EQ_personName=%@&search_GTE_visitTime=%@&search_LTE_visitTime=%@",URL_Goods,typeId,(long)self.pageIndex,PageSize,self.mSearchText.text,startTime,endTime] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    [HYBNetworking getWithUrl:url refreshCache:YES success:^(id response) {
        
        NSLog(@"====服务单页面%@",response);
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
//MARK:创建ui
- (void)createSearchV {

    registerNibWithCellName(self.mainTableView, @"NewMyServiceTableViewCell");

    UIView *topV = [[UIView alloc]initWithFrame:CGRectMake(0, kNavigationBarHeight, SCREENW, 96)];
    [self.view addSubview:topV];
    topV.backgroundColor = [UIColor whiteColor];
    [self createSearchWithView:topV];
    
    
    self.mainTableView.frame = CGRectMake(0, CGRectGetMaxY(topV.frame), SCREENW, SCREENH - CGRectGetMaxY(topV.frame) - kTabarHeight);
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
//MARK:点击事件
- (void)selectTypeAction:(UIButton *)btn {
    [self.mSearchText endEditing:YES];
    [self getServiceType];
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
- (void)goToComment:(UIButton *)btn {
    CommentVC *vc = [CommentVC new];
    vc.isEdit = NO;
    UIView *contentView = [btn superview];
    NewMyServiceTableViewCell *cell = (NewMyServiceTableViewCell *)[contentView superview];
    NSIndexPath *indexPath = [self.mainTableView indexPathForCell:cell];
    NSDictionary *dic = self.dataArr[indexPath.section];
    vc.orderId = dic[@"id"];
    vc.topDic = dic;
    [self.navigationController pushViewController:vc animated:YES];
}
//MARK:tableVa代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewMyServiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewMyServiceTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dic = self.dataArr[indexPath.section];
    cell.nameLabel.text = dic[@"personName"];
    cell.ageLabel.text = dic[@"personAge"];
    cell.doctoreLabel.text = dic[@"doctor"];
    cell.orderTimeLabel.text = [self testDateZone:dic[@"orderTime"]];
    [cell.cellBtn addTarget:self action:@selector(goToComment:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 12;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 154;
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


@end
