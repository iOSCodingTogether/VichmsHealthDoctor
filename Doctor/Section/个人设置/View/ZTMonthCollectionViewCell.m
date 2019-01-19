//
//  ZTMonthCollectionViewCell.m
//  ZTMonthSelector
//
//  Created by zt on 2018/10/24.
//  Copyright © 2018年 zt. All rights reserved.
//

#import "ZTMonthCollectionViewCell.h"

@interface ZTMonthCollectionViewCell()

@property (nonatomic,strong) UILabel *monthLabel;//显示的每个月份的label
@property (nonatomic,strong) CAGradientLayer *bgLayer;//选中某个月份的背景
@end

@implementation ZTMonthCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUIWithFrame:frame];
    }
    return self;
}
- (void)createUIWithFrame:(CGRect)frame {

    self.monthLabel = [[UILabel alloc]initWithFrame:CGRectMake((frame.size.width - 34)/2.0, 0, 34, 34)];
    [self addSubview:self.monthLabel];
    self.monthLabel.layer.cornerRadius = 17;
    self.monthLabel.layer.masksToBounds = YES;
    self.monthLabel.textAlignment = NSTextAlignmentCenter;
    self.monthLabel.textColor = HEXCOLOR(0x7C86A2);
    self.monthLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
}

- (void)configWithMonth:(NSInteger)month withSelectMonth:(NSInteger)selectMonth withSelect:(BOOL)canBeSelected{
    self.monthLabel.text = [NSString stringWithFormat:@"%ld月",(long)month];
    if (!canBeSelected) {
        [self.bgLayer removeFromSuperlayer];
        self.monthLabel.textColor = HEXCOLOR(0xCACACA);
    }else {
        if (month == selectMonth) {
            [self.layer insertSublayer:self.bgLayer atIndex:0];
            self.monthLabel.textColor = [UIColor whiteColor];
        }else {
            [self.bgLayer removeFromSuperlayer];
            self.monthLabel.textColor = HEXCOLOR(0x7C86A2);
        }
    }
}
- (CAGradientLayer *)bgLayer {
    if (!_bgLayer) {
        _bgLayer=[CAGradientLayer layer];
        _bgLayer.frame=self.monthLabel.frame;
        [_bgLayer setColors:@[(id)HEXCOLOR(0xFF0965).CGColor, (id)HEXCOLOR(0xFC7139).CGColor]];
        //颜色左右渐变
        [_bgLayer setStartPoint:CGPointMake(0, 0)];
        [_bgLayer setEndPoint:CGPointMake(1, 0)];
        _bgLayer.cornerRadius = self.monthLabel.layer.cornerRadius;
    }
    return _bgLayer;
}
@end
