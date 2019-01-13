//
//  ZTMonthCollectionViewCell.h
//  ZTMonthSelector
//
//  Created by zt on 2018/10/24.
//  Copyright © 2018年 zt. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZTMonthCollectionViewCell : UICollectionViewCell

- (void)configWithMonth:(NSInteger)month withSelectMonth:(NSInteger)selectMonth withSelect:(BOOL)canBeSelected;
@end

NS_ASSUME_NONNULL_END
