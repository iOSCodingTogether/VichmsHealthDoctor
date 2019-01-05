//
//  MBProgressHUD+SimpleLoad.h
//  MyWardrobe
//
//  Created by Simon Mr on 2018/12/15.
//  Copyright © 2018 Simon Mr. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (SimpleLoad)


/**
 简单loading

 @param title title
 */
+ (void)showLoadingWithTitle:(NSString *)title;

/**
 指定view loading

 @param view 指定view
 @param title title
 */
+ (void)showLoadingWithView:(UIView *)view andTitle:(NSString *)title;

@end
