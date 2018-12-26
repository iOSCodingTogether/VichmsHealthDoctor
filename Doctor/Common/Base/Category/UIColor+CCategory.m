//
//  UIColor+CCategory.m
//  XiangjianiOS
//
//  Created by  licc on 2018/8/12.
//  Copyright © 2018年 AnyOne. All rights reserved.
//

#import "UIColor+CCategory.h"

@implementation UIColor (CCategory)

//获取颜色数值
- (CGFloat *) getRGB{
    UIColor * uiColor = self;
    
    CGColorRef cgColor = [uiColor CGColor];
    
    long numComponents = CGColorGetNumberOfComponents(cgColor);
    
    if (numComponents == 4){
        static CGFloat * components = Nil;
        components = (CGFloat *) CGColorGetComponents(cgColor);
        return (CGFloat *)components;
    } else { //否则默认返回黑色
        static CGFloat components[4] = {0};
        CGFloat f = 0;
        //非RGB空间的系统颜色单独处理
        if ([uiColor isEqual:[UIColor whiteColor]]) {
            f = 1.0;
        } else if ([uiColor isEqual:[UIColor lightGrayColor]]) {
            f = 0.8;
        } else if ([uiColor isEqual:[UIColor grayColor]]) {
            f = 0.5;
        }
        components[0] = f;
        components[1] = f;
        components[2] = f;
        components[3] = 1.0;
        return (CGFloat *)components;
    }
}

//两种颜色混合
+(UIColor *)mixColorA:(UIColor *)colorA occupyA:(CGFloat)occupyA withColorB:(UIColor *)colorB occupyB:(CGFloat)occupyB{
    if(occupyA <occupyB){
        return colorB;
    }
    else{
        return colorA;
    }
    
    return [colorA mix:colorB];
}
- (UIColor *) mix: (UIColor *) color{
    CGFloat * rgb1 = [self getRGB];
    CGFloat r1 = rgb1[0];
    CGFloat g1 = rgb1[1];
    CGFloat b1 = rgb1[2];
    CGFloat alpha1 = rgb1[3];
    
    CGFloat * rgb2 = [color getRGB];
    CGFloat r2 = rgb2[0];
    CGFloat g2 = rgb2[1];
    CGFloat b2 = rgb2[2];
    CGFloat alpha2 = rgb2[3];
    
    //mix them!!
    CGFloat r = (r1 + r2) / 2.0;
    CGFloat g = (g1 + g2) / 2.0;
    CGFloat b = (b1 + b2) / 2.0;
    CGFloat alpha = (alpha1 + alpha2) / 2.0;
    
    UIColor * uiColor = [UIColor colorWithRed:r green:g blue:b alpha:alpha];
    return uiColor;
}

- (UIImage *)createImage{
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1000.0f, 100.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [self CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
    
}

+ (CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length {
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

+ (UIColor *) colorWithHexString: (NSString *) hexString {
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 1];
            green = [self colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self colorComponentFrom: colorString start: 2 length: 1];
            break;
        case 4: // #ARGB
            alpha = [self colorComponentFrom: colorString start: 0 length: 1];
            red   = [self colorComponentFrom: colorString start: 1 length: 1];
            green = [self colorComponentFrom: colorString start: 2 length: 1];
            blue  = [self colorComponentFrom: colorString start: 3 length: 1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 2];
            green = [self colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self colorComponentFrom: colorString start: 4 length: 2];
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom: colorString start: 0 length: 2];
            red   = [self colorComponentFrom: colorString start: 2 length: 2];
            green = [self colorComponentFrom: colorString start: 4 length: 2];
            blue  = [self colorComponentFrom: colorString start: 6 length: 2];
            break;
        default:
            return nil;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}
@end
