//
//  NewMyServiceTableViewCell.h
//  Doctor
//
//  Created by zt on 2019/1/12.
//  Copyright © 2019年 AnyOne. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewMyServiceTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *doctoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *cellBtn;

@end

NS_ASSUME_NONNULL_END
