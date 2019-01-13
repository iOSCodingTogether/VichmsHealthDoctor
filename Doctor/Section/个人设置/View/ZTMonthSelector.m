//
//  ZTMonthSlector.m
//  ZTMonthSelector
//
//  Created by zt on 2018/10/24.
//  Copyright © 2018年 zt. All rights reserved.
//

#import "ZTMonthSelector.h"
#import "ZTMonthCollectionViewCell.h"
/*十六进制颜色设置**/
#define MINYEAR 2016 //最小的年份
@interface ZTMonthSelector ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UILabel *dateTitle;//传过来的时间title
@property (nonatomic,strong) UIButton *lastMonth;//上月
@property (nonatomic,strong) UIButton *nextMonth;//下月
@property (nonatomic,strong) UICollectionView *monthCollectionV;//所有月份view

@property (nonatomic,copy) NSString *selectMonth;//选中的月份
@property (nonatomic,assign) NSInteger selectYear;//选中的年份

@property (nonatomic,assign) NSInteger currentYear;//当年
@property (nonatomic,assign) NSInteger currentMonth;//当月


@end

@implementation ZTMonthSelector

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.shadowColor = HEXCOLOR(0xBFC9D7).CGColor;
        self.layer.shadowOffset = CGSizeMake(0, 0);
        self.layer.shadowRadius = 5;
        self.layer.shadowOpacity = 1;
        self.layer.cornerRadius = 6;
        
        [self createHeaderWithFrame:frame];
        [self createCollectionViewWithFrame:frame];
    }
    return self;
}
#pragma mark -- 创建UI
- (void)createCollectionViewWithFrame:(CGRect)frame {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(frame.size.width/5.0, 20);
    flowLayout.minimumLineSpacing = 47;
    flowLayout.minimumInteritemSpacing = 0;
    
    self.monthCollectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.dateTitle.frame) + 30, frame.size.width, frame.size.height - CGRectGetMaxY(self.dateTitle.frame) - 30) collectionViewLayout:flowLayout];
    [self addSubview:self.monthCollectionV];
    self.monthCollectionV.backgroundColor = [UIColor whiteColor];
    [self.monthCollectionV registerClass:[ZTMonthCollectionViewCell class] forCellWithReuseIdentifier:@"ZTMonthCollectionViewCell"];
    self.monthCollectionV.delegate = self;
    self.monthCollectionV.dataSource = self;
}
- (void)createHeaderWithFrame:(CGRect)frame {
    self.dateTitle = [[UILabel alloc]initWithFrame:CGRectMake((frame.size.width - 100)/2.0, 30, 100, 22)];
    [self addSubview:self.dateTitle];
    self.dateTitle.textAlignment = NSTextAlignmentCenter;
    self.dateTitle.font = [UIFont systemFontOfSize:16];
    self.dateTitle.textColor = HEXCOLOR(0x333333);
    
    self.lastMonth = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.lastMonth];
    [self.lastMonth setImage:[UIImage imageNamed:@"leftArrow"] forState:UIControlStateNormal];
    [self.lastMonth setImage:[UIImage imageNamed:@"leftNonArrow"] forState:UIControlStateHighlighted];
    self.lastMonth.frame = CGRectMake((CGRectGetMinX(self.dateTitle.frame) - 22)/2.0, CGRectGetMinY(self.dateTitle.frame), 22, 22);
    [self.lastMonth addTarget:self action:@selector(changeYear:) forControlEvents:UIControlEventTouchUpInside];
    
    self.nextMonth = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.nextMonth];
    [self.nextMonth setImage:[UIImage imageNamed:@"rightArrow"] forState:UIControlStateNormal];
    [self.nextMonth setImage:[UIImage imageNamed:@"rightNonArrow"] forState:UIControlStateHighlighted];
    self.nextMonth.frame = CGRectMake(CGRectGetMaxX(self.dateTitle.frame) + CGRectGetMinX(self.lastMonth.frame), CGRectGetMinY(self.lastMonth.frame), 22, 22);
    [self.nextMonth addTarget:self action:@selector(changeYear:) forControlEvents:UIControlEventTouchUpInside];

    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | //年
    NSCalendarUnitMonth; //月份
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:[NSDate date]];
    self.currentYear = [dateComponent year];
    self.currentMonth = [dateComponent month];
}
#pragma mark --外面传过来调用的方法
- (void)configWithYear:(NSString *)year month:(NSString *)month {
    
    [self changeDateTitle:year];
    self.selectMonth = month;
    [self.monthCollectionV reloadData];
}
#pragma mark -- 修改年份和对应的button状态
- (void)changeDateTitle:(NSString *)year {
    self.dateTitle.text = [year stringByAppendingString:@"年"];
    self.selectYear = [year integerValue];
    [self.nextMonth setImage:[UIImage imageNamed:@"rightArrow"] forState:UIControlStateNormal];
    [self.lastMonth setImage:[UIImage imageNamed:@"leftArrow"] forState:UIControlStateNormal];
    
    if ([year integerValue] == self.currentYear) {
        [self.nextMonth setImage:[UIImage imageNamed:@"rightNonArrow"] forState:UIControlStateNormal];
    }else if ([year integerValue] <= MINYEAR) {
        [self.lastMonth setImage:[UIImage imageNamed:@"leftNonArrow"] forState:UIControlStateNormal];
    }
    [self.monthCollectionV reloadData];

}
//上面切换年份的图标btn
- (void)changeYear:(UIButton *)btn {
    if (btn == self.nextMonth) {
        //下一年
        if (self.selectYear < self.currentYear) {
            self.selectYear ++;
        }else {
            return;
        }
    }else if (btn == self.lastMonth) {
        //上一年
        if (self.selectYear > MINYEAR) {
            self.selectYear --;
        }else {
            return;
        }
    }
    [self changeDateTitle:[NSString stringWithFormat:@"%ld",(long)self.selectYear]];

}

#pragma mark -- collectionView的代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 12;
}
- (ZTMonthCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ZTMonthCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZTMonthCollectionViewCell" forIndexPath:indexPath];
    if (self.selectYear == self.currentYear && indexPath.row + 1 > self.currentMonth) {
        [cell configWithMonth:indexPath.row + 1 withSelectMonth:[self.selectMonth integerValue] withSelect:NO];
    }else {
        [cell configWithMonth:indexPath.row + 1 withSelectMonth:[self.selectMonth integerValue] withSelect:YES];
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath *indexP = [NSIndexPath indexPathForRow:[self.selectMonth integerValue]-1  inSection:0];
    self.selectMonth = [NSString stringWithFormat:@"%ld",indexPath.row + 1];

    if (self.selectYear == self.currentYear && [self.selectMonth integerValue] > self.currentMonth) {
        return;
    }
    if (indexP == indexPath) {
        [self.monthCollectionV reloadItemsAtIndexPaths:@[indexPath]];
    }else {
        [self.monthCollectionV reloadItemsAtIndexPaths:@[indexP,indexPath]];
    }
    if(self.getSelectTimeBlock) {
        self.getSelectTimeBlock([NSString stringWithFormat:@"%ld-%02ld",(long)self.selectYear,(long)[self.selectMonth integerValue]]);
    }
}
@end
