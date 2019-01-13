//
//  BookTableViewCell.m
//  Doctor
//
//  Created by zt on 2019/1/5.
//  Copyright © 2019年 AnyOne. All rights reserved.
//

#import "BookTableViewCell.h"

@implementation BookTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.chatBtn.layer.cornerRadius = 3;
    self.chatBtn.layer.borderColor = HEXCOLOR(0x00A3FE).CGColor;
    self.chatBtn.layer.borderWidth = 1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
