//
//  MBProgressHUD+Additions.m
//  UserCarApp
//
//  Created by zt on 2018/8/23.
//  Copyright © 2018年 包红旭. All rights reserved.
//

#import "MBProgressHUD+Additions.h"
@implementation MBProgressHUD (Additions)


+ (void)showAlertWithView:(UIView *)view andTitle:(NSString *)title {
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
//    [self addSubview:HUD];
    HUD.label.text = title;
    HUD.contentColor = [UIColor whiteColor];
    HUD.label.textColor = [UIColor whiteColor];
    HUD.mode = MBProgressHUDModeText;
    HUD.backgroundView.backgroundColor = [UIColor clearColor];
    HUD.bezelView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    //指定距离中心点的X轴和Y轴的偏移量，如果不指定则在屏幕中间显示
    HUD.yOffset = Is_iPhone5s ? 100.f : 70.f;
    
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        sleep(1);
        dispatch_async(dispatch_get_main_queue(), ^{
//            [HUD hideAnimated:YES];
            [HUD removeFromSuperview];
        });
        
    });
    
//    [HUD showAnimated:YES whileExecutingBlock:^{
//        sleep(1);
//    } completionBlock:^{
//        [HUD removeFromSuperview];
//    }];
}



+(UIImage*) createImageWithColor:(UIColor*) color withRect:(CGRect)rect
{
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
@end
