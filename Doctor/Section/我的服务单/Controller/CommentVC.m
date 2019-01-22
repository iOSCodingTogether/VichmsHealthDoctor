//
//  CommentVC.m
//  Doctor
//
//  Created by zt on 2019/1/6.
//  Copyright © 2019年 AnyOne. All rights reserved.
//

#import "CommentVC.h"
//#import "MyServiceTableViewCell.h"
#import "NewMyServiceTableViewCell.h"
#import "CommonTextViewTableViewCell.h"
#import "CollectionTableViewCell.h"
#import "StartCommentTableViewCell.h"
#import "SKTagView.h"

@interface CommentVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSDictionary *rootDic;
@end

@implementation CommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configWithTitle:@"评价" backImage:@""];
    self.naviBGView.backgroundColor = [UIColor whiteColor];

    registerNibWithCellName(self.mainTableView, @"NewMyServiceTableViewCell");
    registerNibWithCellName(self.mainTableView, @"CollectionTableViewCell");
    registerNibWithCellName(self.mainTableView, @"CommonTextViewTableViewCell");
    registerNibWithCellName(self.mainTableView, @"StartCommentTableViewCell");

    self.mainTableView.frame = CGRectMake(0, kNavigationBarHeight, SCREENW, SCREENH - kNavigationBarHeight);
    [self getData];
}

- (void)getData {
    @weakify(self);
    [HYBNetworking getWithUrl:[NSString stringWithFormat:@"%@?orderId=%@",URL_GetOrderEvaluationByOrderId,self.orderId] refreshCache:YES success:^(id response) {
        NSLog(@"===查看评论%@",response);
        @strongify(self);
        NSDictionary *dic = response;
        if ([dic[@"code"] isEqual:@100]) {
            if (![dic[@"data"] isKindOfClass:[NSNull class]]) {
                self.rootDic = dic[@"data"];
                [self.mainTableView reloadData];
//                [self.mainTableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:NO];
            }else {
                [MBProgressHUD showAlertWithView:self.view andTitle:@"暂无评价"];
            }
        }else {
            [MBProgressHUD showAlertWithView:self.view andTitle:@"请求失败"];
        }
    } fail:^(NSError *error, NSInteger statusCode) {
        
        [MBProgressHUD showAlertWithView:self.view andTitle:@"暂无评价"];
    }];
}
#pragma mark - UITableViewDelegate UITableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (!self.isEdit) {
        if (self.rootDic[@"picture"]) {
            NSString *pictureStr = self.rootDic[@"picture"];
            if (pictureStr.length == 0) {
                return 2;
            }
        }
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
        return 154;
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
        NewMyServiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewMyServiceTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.cellBtn.hidden = YES;
        cell.nameLabel.text = self.topDic[@"personName"];
        cell.ageLabel.text = self.topDic[@"personAge"];
        cell.doctoreLabel.text = self.topDic[@"doctor"];
        cell.orderTimeLabel.text = [self testDateZone:self.topDic[@"orderTime"]];
        return cell;
    }
    StartCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StartCommentTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell.tagView removeAllTags];
    cell.tagView.interitemSpacing = 10;
    cell.tagView.regularHeight = 20;
    cell.tagView.lineSpacing = 5;
    NSString *tagStr = self.rootDic[@"tabs"];
    NSArray *arr = [tagStr componentsSeparatedByString:@","];
    for (NSString *subTag in arr) {
        SKTag *tag1 = [SKTag tagWithText:subTag];
        tag1.enable = NO;
        tag1.padding = UIEdgeInsetsMake(8, 10, 8, 10);
        tag1.borderWidth = 1;
        tag1.textColor = HEXCOLOR(0x919191);
        tag1.cornerRadius = 10;
        tag1.borderColor = [HEXCOLOR(0x919191) colorWithAlphaComponent:0.8];
        [cell.tagView addTag:tag1];
    }
    
    if ([self.rootDic.allKeys containsObject:@"count"]) {
        CGFloat score = [self.rootDic[@"count"] floatValue];
        NSString *commentStr = self.rootDic[@"evaluation"];
        [cell configWithScore:[NSString stringWithFormat:@"%.1f分",score] comment:commentStr];
    }else {
        [cell configWithScore:@"暂无评分" comment:@"暂无评价"];

    }
    
    
    return cell;
    
}

-(NSString *)testDateZone:(NSString *)timeDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    
    NSDate *localDate = [dateFormatter dateFromString:timeDate];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:[self getNowDateFromatAnDate:localDate]];
    NSLog(@"strDate = %@",strDate);
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    return strDate;
}

- (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate
{
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate];
    return destinationDateNow;
}
@end
