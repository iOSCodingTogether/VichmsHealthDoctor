//
//  CommentVC.m
//  Doctor
//
//  Created by zt on 2019/1/6.
//  Copyright © 2019年 AnyOne. All rights reserved.
//

#import "CommentVC.h"
#import "MyServiceTableViewCell.h"
#import "CommonTextViewTableViewCell.h"
#import "CollectionTableViewCell.h"
#import "StartCommentTableViewCell.h"


@interface CommentVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation CommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configWithTitle:@"评价" backImage:@""];
    self.naviBGView.backgroundColor = [UIColor whiteColor];

    registerNibWithCellName(self.mainTableView, @"MyServiceTableViewCell");
    registerNibWithCellName(self.mainTableView, @"CollectionTableViewCell");
    registerNibWithCellName(self.mainTableView, @"CommonTextViewTableViewCell");
    registerNibWithCellName(self.mainTableView, @"StartCommentTableViewCell");

    self.mainTableView.frame = CGRectMake(0, kNavigationBarHeight, SCREENW, SCREENH - kNavigationBarHeight);
}


#pragma mark - UITableViewDelegate UITableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (!self.isEdit) {
        return 3;
    }
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 219;
    }else if (indexPath.section == 1 || indexPath.section == 2) {
        return UITableViewAutomaticDimension;
    }else if (indexPath.section == 3) {
        return 80;
    }
    return UITableViewAutomaticDimension;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 3) {
        CommonTextViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommonTextViewTableViewCell"];
        cell.TextView.placeholder = @"请输入评价";
        return cell;
    }else if (indexPath.section == 2) {
        CollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CollectionTableViewCell"];
        cell.accessoryType = UITableViewCellAccessoryNone;
        return cell;
    }else if (indexPath.section == 0) {
        MyServiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyServiceTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.lookComment.hidden = YES;
        return cell;
    }
    StartCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StartCommentTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell configWithScore:@"3.5分" comment:@"我的评论我的评论我的评论我的评论我的评论我的评论我的评论我的评论我的评论我的评论我的评论我的评论我的评论我的评论我的评论我的评论我的评论我的评论我的评论我的评论我的评论我的评论我的评论我的评论我的评论我的评论我的评论我的评论我的评论我的评论"];

    return cell;
    
}

@end
