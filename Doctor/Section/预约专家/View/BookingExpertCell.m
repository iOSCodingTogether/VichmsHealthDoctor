//
//  BookingExpertCell.m
//  Doctor
//
//  Created by zt on 2019/1/6.
//  Copyright © 2019 AnyOne. All rights reserved.
//

#import "BookingExpertCell.h"

@implementation BookingExpertCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.leftImageView layoutIfNeeded];
    self.leftImageView.layer.cornerRadius = CGRectGetWidth(self.leftImageView.frame)/2.0;
    self.leftBtn.layer.cornerRadius = 3;
    self.rightBtn.layer.cornerRadius = 3;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
