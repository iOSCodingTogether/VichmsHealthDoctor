//
//  CommonCell0.m
//  VichmsHealthDoctor
//
//  Created by  licc on 2018/8/26.
//  Copyright © 2018年 AnyOne. All rights reserved.
//
//共用常用cell样式1
//左边灰色标题 右边黑色详情
#import "CommonCell0.h"

@implementation CommonCell0

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
