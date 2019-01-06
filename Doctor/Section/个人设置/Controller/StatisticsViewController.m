//
//  StatisticsViewController.m
//  Doctor
//
//  Created by zt on 2019/1/5.
//  Copyright © 2019年 AnyOne. All rights reserved.
//

#import "StatisticsViewController.h"
#import "BRDatePickerView.h"
@interface StatisticsViewController ()

@end

@implementation StatisticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configWithTitle:@"服务统计" backImage:@""];
    self.naviBGView.backgroundColor = [UIColor whiteColor];

    [self.selectDataBtn addTarget:self action:@selector(selectData:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)selectData:(UIButton *)btn {
    NSString *str = @"";
    if (str.length == 0) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        str = [dateFormatter stringFromDate:[NSDate date]];
    }
    [BRDatePickerView showDatePickerWithTitle:@"选择时间" dateType:UIDatePickerModeDateAndTime defaultSelValue:str minDateStr:@"" maxDateStr:@"" isAutoSelect:NO resultBlock:^(NSString *selectValue,NSDate *date) {
        if(date){
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            //                [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSString *destDateString = [dateFormatter stringFromDate:date];
            self.dataLabel.text = destDateString;
        }
    }];
}

@end
