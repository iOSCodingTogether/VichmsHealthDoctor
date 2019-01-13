//
//  ZYLMultiselectView.m
//  Multiselect
//
//  Created by zhuyuelong on 16/7/18.
//  Copyright © 2016年 zhuyuelong. All rights reserved.
//

#import "ZYLMultiselectView.h"

@implementation ZYLMultiselectView

-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        self.alertV = [[UIView alloc]initWithFrame:CGRectMake(30,100, SCREENW - 60, SCREENH - 200)];
        [self addSubview:self.alertV];
        self.alertV.backgroundColor = [UIColor whiteColor];
        self.resultArr = [NSMutableArray array];
        
        self.dataArr = [NSMutableArray array];
        
        self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.alertV.frame.size.width, self.alertV.frame.size.height - 50) style:UITableViewStylePlain];
        self.tableview.bounces = NO;
        self.tableview.delegate = self;
        
        self.tableview.dataSource = self;
        
        self.tableview.showsVerticalScrollIndicator = NO;
        
        self.tableview.backgroundColor = [UIColor clearColor];
        
        [self.alertV addSubview:self.tableview];
        self.tableview.tableFooterView = [UIView new];
        
        self.tableview.scrollEnabled = YES;
        [self.tableview setSeparatorInset:UIEdgeInsetsMake(0, 10, 0, 10)];
        [self.tableview registerClass:[ZYLMultiselectTableViewCell class] forCellReuseIdentifier:@"zylmuselect"];
        
    }
    
    CGFloat btnW = self.alertV.frame.size.width / 2.0;
    UIButton *confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(btnW, self.alertV.frame.size.height - 43, btnW, 43)];
    [self.alertV addSubview:confirmBtn];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    confirmBtn.backgroundColor = HEXCOLOR(0x23BEFE);
    [confirmBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.alertV.frame.size.height - 43, btnW, 43)];
    [self.alertV addSubview:cancelBtn];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:HEXCOLOR(0x767676) forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(canceBtnClick) forControlEvents:UIControlEventTouchUpInside];
    

    
    return self;

}

-(void)confirmBtnClick{
    
    
    self.SelectBlock(self.resultArr);
    
    [self disMiss];
    
}

-(void)canceBtnClick{
    
    self.SelectBlock(nil);

    [self disMiss];

}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArr.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZYLMultiselectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"zylmuselect"];

    cell.backgroundColor = [UIColor clearColor];
    
    cell.lbName.text = self.dataArr[indexPath.row];
    
    cell.selectionStyle = UITableViewCellEditingStyleNone;
    
    
    if (self.resultArr.count != 0) {
        
        for (int i = 0; i < self.resultArr.count; i ++) {
        
            int row = [self.resultArr[i] intValue];
            
            if (indexPath.row == row) {
                
                cell.selectImage.image = [UIImage imageNamed:@"moreSlectSelected"];
                
                break;
                
            }else{
            
                cell.selectImage.image = [UIImage imageNamed:@"moreSlectNormal"];
            
            }
            
        }
    
    }else{
        
        cell.selectImage.image = [UIImage imageNamed:@"moreSlectNormal"];

    }
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.resultArr.count != 0) {
    
        int row = [self.resultArr[0] intValue];
        
        if (indexPath.row == row) {
            
        }else {
            self.resultArr = [NSMutableArray array];
            [self.resultArr addObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
        }

//    for (int i = 0; i < self.resultArr.count; i ++) {
//
//        int row = [self.resultArr[i] intValue];
//
//        if (indexPath.row == row) {
//
//            [self.resultArr removeObjectAtIndex:i];
//
//            break;
//
//        }
//
//        if (i == self.resultArr.count - 1) {
//
//            if (indexPath.row != row) {
//
//                [self.resultArr addObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
//
//            }
//
//            break;
//
//        }
//
//    }
    
    }else{
        self.resultArr = [NSMutableArray array];
        [self.resultArr addObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    
    }
    
    [self.tableview reloadData];

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 50;
    
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableview.frame.size.width, 50)];
    header.backgroundColor = [UIColor whiteColor];
    UILabel *lbTitle = [[UILabel alloc] initWithFrame:header.bounds];
    [header addSubview:lbTitle];
    lbTitle.textColor = HEXCOLOR(0x767676);
    if (self.heraderStr != nil) {
        lbTitle.text = self.heraderStr;
        
    }else{
        lbTitle.text = @"地点选择";
    }
    lbTitle.textAlignment = NSTextAlignmentCenter;
    
    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(lbTitle.frame)-1, self.frame.size.width, 1)];
    [header addSubview:lineLabel];
    lineLabel.backgroundColor = RGB(242, 243, 243, 1);
    return header;
    
}

-(void)disMiss{
    
    [self removeFromSuperview];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
