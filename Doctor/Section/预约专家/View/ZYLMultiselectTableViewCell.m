//
//  ZYLMultiselectTableViewCell.m
//  Multiselect
//
//  Created by zhuyuelong on 16/7/18.
//  Copyright © 2016年 zhuyuelong. All rights reserved.
//

#import "ZYLMultiselectTableViewCell.h"

@implementation ZYLMultiselectTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
       
        
        self.lbName = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, self.contentView.frame.size.width - 50, self.contentView.frame.size.height - 10)];
        
        self.lbName.textColor = [UIColor grayColor];
        
        [self.contentView addSubview:self.lbName];
        
        self.selectImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width - (self.contentView.frame.size.height - 20) - 10, 10, self.contentView.frame.size.height - 20, self.contentView.frame.size.height - 20)];
        CGPoint center = self.selectImage.center;
        center.y = self.lbName.center.y;
        self.selectImage.center = center;
        
        [self.contentView addSubview:self.selectImage];
        
    }
    
    return self;
    
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
