//
//  MyServiceTableViewCell.m
//  Doctor
//
//  Created by zt on 2019/1/6.
//  Copyright © 2019年 AnyOne. All rights reserved.
//

#import "MyServiceTableViewCell.h"

@implementation MyServiceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.lookComment.layer.cornerRadius = 3;
    self.lookComment.layer.borderColor = HEXCOLOR(0x00A3FE).CGColor;
    self.lookComment.layer.borderWidth = 1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
