//
//  CommonCell1.m
//  VichmsHealthDoctor
//  Created by  licc on 2018/9/1.
//  Copyright © 2018年 AnyOne. All rights reserved.
//

#import "CommonCell1.h"

@implementation CommonCell1

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
