//
//  BookTableViewCell.m
//  Doctor
//
//  Created by zt on 2019/1/5.
//  Copyright © 2019年 AnyOne. All rights reserved.
//

#import "BookTableViewCell.h"

#import <NIMSDK/NIMSDK.h>

@interface BookTableViewCell ()
// 讨论组Id
@property (nonatomic, copy) NSString *groupId;
// 医生Id
@property (nonatomic, copy) NSString *doctorId;
// 助理Id
@property (nonatomic, copy) NSString *assisstandId;
// 患者Id
@property (nonatomic, copy) NSString *patientId;

@end

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

- (void)setChatInfoWithCellInfo:(NSDictionary *)dic chatAction:(ChatActionBlock)block {
    self.chatActionBlock = [block copy];
    if (!dic
        || [dic[@"groupid"] isKindOfClass:[NSNull class]]) {
        self.groupId = @"";
    } else {
        self.groupId = dic[@"groupid"];
    }
    self.doctorId = dic[@"doctoraccId"];
}

- (IBAction)chatAction:(id)sender {
    if (self.chatActionBlock) {
        self.chatActionBlock(self.groupId);
    }
}

@end
