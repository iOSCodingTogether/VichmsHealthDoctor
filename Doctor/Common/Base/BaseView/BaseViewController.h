//
//  BaseViewController.h
//  XiangjianiOS
//
//  Created by  licc on 2018/8/1.
//  Copyright © 2018年 AnyOne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJExtension/MJExtension.h>
#import <MJRefresh/MJRefresh.h>
#import "BaseRequest.h"
#import "AppUserDefaults.h"

@interface BaseViewController : UIViewController
//懒加载contentView上增加创建一个tableView
@property (strong,nonatomic) UITableView *mainTableView;
//页面所有view 放入contentView 方便统一管理
@property (strong,nonatomic) UIView *contentView;


- (void)pushViewController:(UIViewController *)viewController;

- (void)backTo;
@end
