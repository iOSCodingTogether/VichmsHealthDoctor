//
//  AppDefine.h
//  XiangjianiOS
//
//  Created by  licc on 2018/8/11.
//  Copyright © 2018年 AnyOne. All rights reserved.
//

#ifndef AppDefine_h
#define AppDefine_h
#import "BaseDefine.h"
#import <Toast/Toast.h>
#import "NSDate+CCategory.h"




//app主色调
#define LR_MAINCOLOR        [UIColor colorWithRed:1/255.0 green:163/255.0 blue:254/255.0 alpha:1]

#define LR_NORMALCOLOR    [UIColor grayColor]
#define LR_REDLCOLOR    [UIColor redColor]

//主要按钮风格统一设置（蓝底白字圆角）
#define LR_BUTTON_STYLE(button) \
[button setBackgroundColor:LR_MAINCOLOR];\
[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];\
button.layer.cornerRadius = 4;\
button.layer.masksToBounds = YES;\
//button.layer.borderWidth = 1;\
//button.layer.borderColor = [UIColor grayColor].CGColor;\

//主要按钮风格统一设置（灰字）
#define LR_BUTTON_STYLE_UNSELECT(button) \
[button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];\
button.layer.cornerRadius = 4;\
button.layer.masksToBounds = YES;\

//tableview背景色 统一
#define LR_TABLE_BACKGROUNDCOLOR    [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1]

#define LR_TOAST(format, ...)     [[UIApplication sharedApplication].delegate.window makeToast:[NSString stringWithFormat:format, ## __VA_ARGS__]  duration:[CSToastManager defaultDuration] position:CSToastPositionCenter style:nil]


#define LR_USER_DEFAULTS [AppUserDefaults standardUserDefaults]

//取到图片地址
UIKIT_STATIC_INLINE NSURL *COMBINE_Doctor_IMAGE(NSString *imageStr){
        if(![[imageStr lowercaseString] hasPrefix:@"http"]){
            imageStr =[NSString stringWithFormat:@"http://www.erpside.com/%@",imageStr];
        }
    imageStr=[imageStr
              stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    

    NSURL *imgURL = [NSURL URLWithString:imageStr];
        return imgURL;
}
#define  LR_TIME_SERVER_2_APP(serverDate) LRTimeIntervalFromToFormatter(serverDate, @"yyyy-MM-dd'T'HH:mm:ss.SSSZ", @"yyyy-MM-dd HH:mm")
#define  LR_TIME_APP_2_SERVER(appShowDate) LRTimeIntervalFromToFormatter(appShowDate,  @"yyyy-MM-dd HH:mm",@"yyyy-MM-dd'T'HH:mm:ss.SSSZ")


#endif /* AppDefine_h */
