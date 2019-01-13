//
//  StatisticsViewController.h
//  Doctor
//
//  Created by zt on 2019/1/5.
//  Copyright © 2019年 AnyOne. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface StatisticsViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIView *selectDateView;
@property (weak, nonatomic) IBOutlet UILabel *dataLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectDataBtn;
@property (weak, nonatomic) IBOutlet UILabel *firstComLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondComLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdComLabel;
@property (weak, nonatomic) IBOutlet UILabel *serviceCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *servicePcountLabel;

@end

NS_ASSUME_NONNULL_END
