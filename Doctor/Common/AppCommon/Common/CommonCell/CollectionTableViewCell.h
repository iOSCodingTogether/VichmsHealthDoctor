//
//  CollectionTableViewCell.h
//  VichmsHealthDoctor
//
//  Created by  licc on 2018/8/28.
//  Copyright © 2018年 AnyOne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionTableViewCell : UITableViewCell
@property (nonatomic, copy) NSArray * imagesArr;     //

@property (nonatomic, copy)void (^didSelect)(NSInteger selectIndex);
@property (nonatomic, copy)void (^didDelect)(NSInteger deleteIndex);


@end
