//
//  AccompanyTableViewCell.m
//  Doctor
//
//  Created by zt on 2019/1/5.
//  Copyright © 2019年 AnyOne. All rights reserved.
//

#import "AccompanyTableViewCell.h"


@implementation AccompanyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    ViewBorderRadius(self.statusBtn, 2, 1, HEXCOLOR(0x00A3FE));
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
