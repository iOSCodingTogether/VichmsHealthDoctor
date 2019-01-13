//
//  MarcoDefine.h
//  LineList
//
//  Created by zt on 2018/10/25.
//  Copyright © 2018年 zt. All rights reserved.
//

#ifndef MarcoDefine_h
#define MarcoDefine_h

#define PageSize 10
#define Font @"MicrosoftYaHei"
#define RGB(r,g,b,alp) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:alp]
/*十六进制颜色设置**/
#define HEXCOLOR(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
/*屏幕宽度*/
#define SCREENW (([UIScreen mainScreen].bounds.size.width > [UIScreen mainScreen].bounds.size.height) ? [UIScreen mainScreen].bounds.size.height : [UIScreen mainScreen].bounds.size.width)
/*屏幕高度*/
#define SCREENH (([UIScreen mainScreen].bounds.size.height > [UIScreen mainScreen].bounds.size.width) ? [UIScreen mainScreen].bounds.size.height : [UIScreen mainScreen].bounds.size.width)
#define SCREEN_RATE  SCREENH/667.f  // 不同屏幕高度的比例系数
#define WIDTH_RATE SCREENW/375.f  // 不同屏幕宽度的比例系数

#define adapter(value)  (value)*WIDTH_RATE
#define adapterH(value) (value)*SCREEN_RATE

/*适配iPhone X*/
#define Is_iPhoneX  ((SCREENH == 812 || SCREENH == 896) ? YES : NO)
#define Is_iPhone5s ((SCREENH == 568) ? YES : NO)
#define Is_iPhone6s ((SCREENH == 667) ? YES : NO)
#define FIT_TopHeight ((SCREENH == 812 || SCREENH == 896) ? 88:64)
#define FIT_SafeAreaBottomHeight -((SCREENH == 812.0 || SCREENH == 896) ? 34 : 0)
#define Is_iPhonePlus ((SCREENH == 736) ? YES : NO)


// 导航栏 + 状态栏 的高度
// 状态栏高度
#define kNavigationBarHeight (Is_iPhoneX ? 88 : 64)
// tabBar高度
#define kTabarHeight (Is_iPhoneX ? 83 : 49)

/*view的切圆角宏*/
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]
#endif /* MarcoDefine_h */
