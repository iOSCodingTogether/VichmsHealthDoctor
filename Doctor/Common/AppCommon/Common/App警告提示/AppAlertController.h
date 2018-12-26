//
//  AppAlertController.h
//  VichmsHealthDoctor
//  Created by  licc on 2018/8/24.
//  Copyright © 2018年 AnyOne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppAlertController : UIAlertController
+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message  buttonTitles:(NSArray *)buttonTitles handler:(void (^)(NSInteger index))handler;
@end
