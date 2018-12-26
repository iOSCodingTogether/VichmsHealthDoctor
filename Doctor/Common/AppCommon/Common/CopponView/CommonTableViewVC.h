//
//  CommonTableViewVC.h
//  VichmsHealthDoctor
//  Created by  licc on 2018/8/31.
//  Copyright © 2018年 AnyOne. All rights reserved.
//

#import "BaseViewController.h"

@interface CommonTableViewVC : BaseViewController
@property(nonatomic, strong) NSMutableArray <NSString *>* dataSourceArray;//cell显示文字
@property(nonatomic, strong) NSMutableArray <NSString *>* dataSourceImageArray;//cell显示图片

-(void)didSelectIndexPath:(NSIndexPath *)indexPath;//点击cell自动调用
@end
