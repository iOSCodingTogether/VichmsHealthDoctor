//
//  StatisticsViewController.m
//  Doctor
//
//  Created by zt on 2019/1/5.
//  Copyright © 2019年 AnyOne. All rights reserved.
//

#import "StatisticsViewController.h"
#import "BRDatePickerView.h"
#import "ZTMonthSelector.h"

@interface StatisticsViewController ()

@property (nonatomic,assign) BOOL isShow;//日历选择是否显示
@property (nonatomic,strong) ZTMonthSelector *monthSelector;
@property (nonatomic,assign) NSInteger year;
@property (nonatomic,assign) NSInteger month;



@end

@implementation StatisticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configWithTitle:@"服务统计" backImage:@""];
    self.naviBGView.backgroundColor = [UIColor whiteColor];

    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | //年
    NSCalendarUnitMonth; //月份
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:[NSDate date]];
    
    NSInteger year = [dateComponent year];
    NSInteger month = [dateComponent month];
    self.year = year;
    self.month = month;
    
    [self.selectDataBtn layoutIfNeeded];
    self.dataLabel.text = [NSString stringWithFormat:@"  %ld-%ld",(long)year,(long)month];
    [self loadData];

    [self.selectDataBtn addTarget:self action:@selector(selectData:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)loadData {
    [HYBNetworking getWithUrl:[NSString stringWithFormat:@"%@?fyear=%ld&fmonth=%ld",URL_Count,(long)self.year,(long)self.month] refreshCache:YES success:^(id response) {
        NSLog(@"====统计%@",response);
        if ([response[@"code"] isEqual:@100]) {
            NSDictionary *dataDic = response[@"data"];
            self.firstComLabel.text = [NSString stringWithFormat:@"分析思路清晰：%.2f%@",[dataDic[@"ftab1"] floatValue] * 100,@"%"];
            self.secondComLabel.text = [NSString stringWithFormat:@"治疗方案明确：%.2f%@",[dataDic[@"ftab2"] floatValue] * 100,@"%"];
            self.thirdComLabel.text = [NSString stringWithFormat:@"24小时回复：%.2f%@",[dataDic[@"ftab3"] floatValue] * 100,@"%"];
            self.serviceCountLabel.text = [NSString stringWithFormat:@"服务次数：%@次",dataDic[@"number"]];
            self.servicePcountLabel.text = [NSString stringWithFormat:@"服务人数：%@人",dataDic[@"people"]];

        }else {
            [MBProgressHUD showAlertWithView:self.view andTitle:@"请求失败"];
        }
     } fail:^(NSError *error, NSInteger statusCode) {
         
         [MBProgressHUD showAlertWithView:self.view andTitle:@"连接服务器失败"];

    }];
}

- (void)selectData:(UIButton *)btn {
    btn.selected = !btn.selected;
    if (btn.selected) {
        [btn layoutIfNeeded];
        self.monthSelector = [[ZTMonthSelector alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.selectDateView.frame), self.view.frame.size.width - 30, 264)];
        [self.view addSubview:self.monthSelector];
        __weak typeof(self)weakSelf = self;
        NSArray *array = [self.dataLabel.text componentsSeparatedByString:@"-"];
        [self.monthSelector configWithYear:[NSString stringWithFormat:@"%@",array[0]] month:[NSString stringWithFormat:@"%@",array.lastObject]];
        self.monthSelector.getSelectTimeBlock = ^(NSString * _Nonnull selectTime) {
            NSArray *array = [selectTime componentsSeparatedByString:@"-"];
            weakSelf.year = [array[0] integerValue];
            weakSelf.month = [array.lastObject integerValue];
            [weakSelf loadData];
            btn.selected = !btn.selected;
            weakSelf.dataLabel.text = [NSString stringWithFormat:@"  %@",selectTime];
            [weakSelf.monthSelector removeFromSuperview];
        };
    }else {
        [self.monthSelector removeFromSuperview];
        self.monthSelector.hidden = YES;
    }
//    NSString *str = @"";
//    if (str.length == 0) {
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        [dateFormatter setDateFormat:@"yyyy-MM"];
//        str = [dateFormatter stringFromDate:[NSDate date]];
//    }
//    [BRDatePickerView showDatePickerWithTitle:@"选择时间" dateType:UIDatePickerModeDate defaultSelValue:str minDateStr:@"" maxDateStr:@"" isAutoSelect:NO resultBlock:^(NSString *selectValue,NSDate *date) {
//        if(date){
//            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//            //                [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
//            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//            NSString *destDateString = [dateFormatter stringFromDate:date];
//            self.dataLabel.text = destDateString;
//        }
//    }];
}

@end
