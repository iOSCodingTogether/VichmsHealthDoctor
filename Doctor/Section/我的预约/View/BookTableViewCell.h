//
//  BookTableViewCell.h
//  Doctor
//
//  Created by zt on 2019/1/5.
//  Copyright © 2019年 AnyOne. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ChatActionBlock)(NSString *teamId);

@interface BookTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *chatBtn;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *doctorLabel;
@property (weak, nonatomic) IBOutlet UILabel *endLabel;

@property (nonatomic, copy) ChatActionBlock chatActionBlock;

- (void)setChatInfoWithCellInfo:(NSDictionary *)dic chatAction:(ChatActionBlock)block;

@end
