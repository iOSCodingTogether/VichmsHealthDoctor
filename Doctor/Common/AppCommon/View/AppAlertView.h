//
//  AppAlertView.h
//  VichmsHealthDoctor
//   Created by  licc on 2018/8/25.
//  Copyright © 2018年 AnyOne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppAlertView : UIView
+(instancetype)createAppAlertViewWithTitle:(NSString *)title leftButtonTitle:(NSString *)leftButtonTitle rightButtonTitle:(NSString *)rightButtonTitle clickBack:(void(^)(NSInteger index))back;
@end
