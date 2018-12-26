//
//  BaseDefine.h
//  XiangjianiOS
//
//  Created by  licc on 2018/8/5.
//  Copyright © 2018年 AnyOne. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <pthread.h>

#ifndef BaseDefine_h
#define BaseDefine_h


#ifdef DEBUG
#define DLog(format, ...) printf("\n[%s] %s %s [第%d行] %s\n", __TIME__,__FILE__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else
#define DLog(format, ...)
#endif

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define LR_KEY_WINDOW [[[UIApplication sharedApplication] delegate] window]


//以cell的类名注册cell
#define registerNibWithCellName(tableview, cellName) [tableview registerNib:[UINib nibWithNibName:cellName bundle:nil] forCellReuseIdentifier:cellName]
#define registerNibWithCellClass(tableview, cellClass) [tableview registerNib:[UINib nibWithNibName:NSStringFromClass() bundle:nil] forCellReuseIdentifier:NSStringFromClass()]

#define LRWeakSelf __weak __typeof(self) weakSelf = self;

#define LRWeak(type)  __weak __typeof(type) weak##type = type;
#define LRStrong(type)  __strong __typeof(type) strong##type = type;




//字符串快速创建图片
#define LRSTRING2IMAGE(imageName) [UIImage imageNamed: imageName]





#endif /* BaseDefine_h */
