//
//  UIColor+CCategory.h
//  XiangjianiOS
//
//  Created by  licc on 2018/8/12.
//  Copyright © 2018年 AnyOne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (CCategory)

//获取颜色数值
- (CGFloat *) getRGB;
//两种颜色按比例混合
+(UIColor *)mixColorA:(UIColor *)colorA occupyA:(CGFloat)occupyA withColorB:(UIColor *)colorB occupyB:(CGFloat)occupyB;

- (UIImage *)createImage;
+ (CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length;

+ (UIColor *) colorWithHexString: (NSString *) hexString ;
@end
