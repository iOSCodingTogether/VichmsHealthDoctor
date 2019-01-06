//
//  ZYLMultiselectView.h
//  Multiselect
//
//  Created by zhuyuelong on 16/7/18.
//  Copyright © 2016年 zhuyuelong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYLMultiselectTableViewCell.h"

@interface ZYLMultiselectView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIView *alertV;
@property (strong, nonatomic) UITableView *tableview;

@property (strong, nonatomic) NSMutableArray *dataArr;

@property (strong, nonatomic) NSMutableArray *resultArr;

@property (copy, nonatomic) NSString *heraderStr;

-(void)disMiss;

@property (nonatomic,copy) void(^SelectBlock)(NSMutableArray *selectArr);

@end
