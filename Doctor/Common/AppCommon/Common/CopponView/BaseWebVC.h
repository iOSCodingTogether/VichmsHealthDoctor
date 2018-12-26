//
//  BaseWebVC.h
//  VichmsHealthDoctor
//   Created by  licc on 2018/10/17.
//  Copyright © 2018年 AnyOne. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseWebVC : BaseViewController
@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic,strong) NSString *content;

@end

NS_ASSUME_NONNULL_END
