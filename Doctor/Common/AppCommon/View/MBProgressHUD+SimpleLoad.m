//
//  MBProgressHUD+SimpleLoad.m
//  MyWardrobe
//
//  Created by Simon Mr on 2018/12/15.
//  Copyright © 2018 Simon Mr. All rights reserved.
//

#import "MBProgressHUD+SimpleLoad.h"

@implementation MBProgressHUD (SimpleLoad)

+ (void)showLoadingWithTitle:(NSString *)title {
    [MBProgressHUD showLoadingWithView:[UIApplication sharedApplication].keyWindow
                              andTitle:title];
}

+ (void)showLoadingWithView:(UIView *)view andTitle:(NSString *)title {
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hub.detailsLabel.text = title;
    hub.detailsLabel.font = [UIFont fontWithName:Font size:16.f];
    hub.contentColor = [UIColor whiteColor];
    hub.label.textColor = [UIColor whiteColor];
    hub.mode = MBProgressHUDModeText;
    hub.backgroundView.backgroundColor = [UIColor clearColor];
    hub.bezelView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    
    @weakify(hub);
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        @strongify(hub);
        [hub removeFromSuperview];
    });
}

@end
