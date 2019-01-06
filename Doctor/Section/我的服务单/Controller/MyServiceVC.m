//
//  MyServiceVC.m
//  Doctor
//
//  Created by zt on 2019/1/4.
//  Copyright © 2019年 AnyOne. All rights reserved.
//

#import "MyServiceVC.h"
#import "MyServiceTableViewCell.h"
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
    
    [self createSearchV];
    
}
- (void)createSearchV {

    registerNibWithCellName(self.mainTableView, @"MyServiceTableViewCell");

    UIView *topV = [[UIView alloc]initWithFrame:CGRectMake(0, kNavigationBarHeight, SCREENW, 95)];
    [self.view addSubview:topV];
    topV.backgroundColor = [UIColor whiteColor];
    [self createSearchWithView:topV];
    
    
    self.mainTableView.frame = CGRectMake(0, CGRectGetMaxY(topV.frame), SCREENW, SCREENH - CGRectGetMaxY(topV.frame) - kTabarHeight);

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
    self.endLabel.text = @"结束时间";
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
//MARK:点击事件
- (void)selectTypeAction:(UIButton *)btn {
    NSArray *selectArr =@[@"第一次预约",@"复诊"];
    NSString *str = self.selectTypeLabel.text;
    if (![selectArr containsObject:str]) {
        str = selectArr[0];
    }
    [BRStringPickerView showStringPickerWithTitle:@"请选择服务类型" dataSource:selectArr defaultSelValue:str isAutoSelect:NO resultBlock:^(id selectValue) {
        NSInteger selectIndex = [selectArr indexOfObject:selectValue];
        self.selectTypeLabel.text = selectArr[selectIndex];
    }];
}
- (void)selectStartData:(UIButton *)btn {
    NSString *str = self.startLabel.text;
    if (![str isEqualToString:@"开始日期"]) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        str = [dateFormatter stringFromDate:[NSDate date]];
    }
    [BRDatePickerView showDatePickerWithTitle:@"请选择开始日期" dateType:UIDatePickerModeDateAndTime defaultSelValue:str minDateStr:@"" maxDateStr:@"" isAutoSelect:NO resultBlock:^(NSString *selectValue,NSDate *date) {
        if(date){
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            //                [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSString *destDateString = [dateFormatter stringFromDate:date];
            self.startLabel.text = destDateString;
        }
    }];
}
- (void)selectEndData:(UIButton *)btn {
    NSString *str = self.endLabel.text;
    if (![str isEqualToString:@"结束日期"]) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        str = [dateFormatter stringFromDate:[NSDate date]];
    }
    [BRDatePickerView showDatePickerWithTitle:@"请选择结束日期" dateType:UIDatePickerModeDateAndTime defaultSelValue:str minDateStr:self.startLabel.text maxDateStr:@"" isAutoSelect:NO resultBlock:^(NSString *selectValue,NSDate *date) {
        if(date){
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            //                [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSString *destDateString = [dateFormatter stringFromDate:date];
            self.endLabel.text = destDateString;
        }
    }];
}
- (void)goToComment:(UIButton *)btn {
    CommentVC *vc = [CommentVC new];
    [self.navigationController pushViewController:vc animated:YES];
}
//MARK:tableVa代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyServiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyServiceTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.lookComment addTarget:self action:@selector(goToComment:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 12;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 217;
}

@end
