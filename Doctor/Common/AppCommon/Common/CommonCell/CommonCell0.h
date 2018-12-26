//
//  CommonCell0.h
//  VichmsHealthDoctor
//
//  Created by  licc on 2018/8/26.
//  Copyright © 2018年 AnyOne. All rights reserved.
//
//共用常用cell样式1
//左边灰色标题 右边黑色详情

#import <UIKit/UIKit.h>
#import "UITextField+Block.h"

@interface CommonCell0 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *label0;
//@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;

@end
