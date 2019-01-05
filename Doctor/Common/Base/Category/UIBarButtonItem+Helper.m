//
//  UIBarButtonItem+Helper.m
//  LoveLimitFree
//
//  Created by andezhou on 15/9/8.
//  Copyright (c) 2015年 周安德. All rights reserved.
//

#import "UIBarButtonItem+Helper.h"

@implementation UIBarButtonItem (Helper)

// 设置图片按钮,normal:常规图片，highlighted:高亮图片
- (id)initWithNormalIcon:(NSString *)normal highlightedIcon:(NSString *)highlighted target:(id)target action:(SEL)action {
    UIImage *image = [UIImage imageNamed:normal];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highlighted] forState:UIControlStateHighlighted];
    btn.bounds = (CGRect){CGPointZero, image.size};
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [self initWithCustomView:btn];
}

+ (id)itemWithNormalIcon:(NSString *)normal highlightedIcon:(NSString *)highlighted target:(id)target action:(SEL)action {
    return [[self alloc] initWithNormalIcon:normal highlightedIcon:highlighted target:target action:action];
}

// 设置文字按钮，默认文字颜色：高亮颜色：
- (id)initWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    return [self initWithTitle:title normalColor:NormalColor highlightedColor:HighlightedColor target:target action:action];
}

+ (id)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    return [[self alloc] initWithTitle:title target:target action:action];
}

// 设置文字按钮, backgroundImage:背景图片，normal：常规颜色 Highlighted：高亮颜色
- (id)initWithTitle:(NSString *)title backgroundImage:(UIImage *)backImage target:(id)target action:(SEL)action {
    return [self initWithTitle:title backgroundImage:backImage normalColor:NormalColor highlightedColor:HighlightedColor target:target action:action];
}

+ (id)itemWithTitle:(NSString *)title backgroundImage:(UIImage *)backImage target:(id)target action:(SEL)action {
    return [[self alloc] initWithTitle:title backgroundImage:backImage target:target action:action];
}

// 设置文字按钮，normal：常规颜色 Highlighted：高亮颜色
+ (id)itemWithTitle:(NSString *)title normalColor:(UIColor *)normal highlightedColor:(UIColor *)highlighted target:(id)target action:(SEL)action {
    return [[self alloc] initWithTitle:title backgroundImage:[UIImage new] normalColor:normal highlightedColor:highlighted target:target action:action];
}

- (id)initWithTitle:(NSString *)title normalColor:(UIColor *)normal highlightedColor:(UIColor *)highlighted target:(id)target action:(SEL)action {
    return [self initWithTitle:title backgroundImage:[UIImage new] normalColor:[UIColor lightGrayColor] highlightedColor:[UIColor blackColor] target:target action:action];
}

// 设置文字按钮，backgroundImage:背景图片 normal：常规颜色 Highlighted：高亮颜色
+ (id)itemWithTitle:(NSString *)title backgroundImage:(UIImage *)backImage normalColor:(UIColor *)normal highlightedColor:(UIColor *)highlighted target:(id)target action:(SEL)action {
    return [[self alloc] initWithTitle:title backgroundImage:backImage normalColor:normal highlightedColor:highlighted target:target action:action];
}

- (id)initWithTitle:(NSString *)title backgroundImage:(UIImage *)backImage normalColor:(UIColor *)normal highlightedColor:(UIColor *)highlighted target:(id)target action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor clearColor];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:normal forState:UIControlStateNormal];
    [btn setTitleColor:highlighted forState:UIControlStateHighlighted];

    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    btn.titleLabel.textAlignment = NSTextAlignmentRight;
    btn.frame = CGRectMake(-10, 0, 60, 44);
//    UIImageView *backImageView = [[UIImageView alloc]initWithImage:backImage];
//    backImageView.center = btn.center;
//    CGRect rect = backImageView.frame;
//    rect.size.width = 12;
//    rect.size.height = 16;
//    rect.origin.x = -12;
//    rect.origin.y = btn.center.y/2+4;
//    backImageView.frame = rect;
//    [btn addSubview:backImageView];
    [btn setImage:backImage forState:UIControlStateNormal];
//    [btn setImage:[UIImage imageNamed:@"导航栏-返回-按下"] forState:UIControlStateSelected];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0,10, 0, 0)];

    btn.contentEdgeInsets = UIEdgeInsetsMake(0,-12, 0, 12);
    return [self initWithCustomView:btn];
}

@end
