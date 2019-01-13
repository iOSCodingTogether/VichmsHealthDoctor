//
//  ZTMonthSlector.h
//  ZTMonthSelector
//
//  Created by zt on 2018/10/24.
//  Copyright © 2018年 zt. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//点击某个月份后，执行的操作。传出去当前选择的时间
typedef void(^GetSelectTimeBlock)(NSString *selectTime);
@interface ZTMonthSelector : UIView

@property (nonatomic,copy) GetSelectTimeBlock getSelectTimeBlock;

/**
 传显示的时间

 @param year 不需要带年，如2018
 @param month 不需要带月，如3
 */
- (void)configWithYear:(NSString *)year month:(NSString *)month;
@end

NS_ASSUME_NONNULL_END
