//
//  CommonTextViewTableViewCell.m
//  VichmsHealthDoctor
//
//  Created by  licc on 2018/8/31.
//  Copyright © 2018年 AnyOne. All rights reserved.
//

#import "CommonTextViewTableViewCell.h"

@implementation CommonTextViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
