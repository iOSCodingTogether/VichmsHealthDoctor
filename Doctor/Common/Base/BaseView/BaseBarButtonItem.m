//
//  BaseBarButtonItem.m
//  VichmsHealthDoctor
//  Created by  licc on 2018/9/2.
//  Copyright © 2018年 AnyOne. All rights reserved.
//

#import "BaseBarButtonItem.h"

@implementation BaseBarButtonItem
- (instancetype)initBaseWithTitle:(nullable NSString *)title target:(nullable id)target action:(nullable SEL)action t:(int) t{
    if(t ==0 ){
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 10, 44)];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    self = [self initWithCustomView:button];
    return self;
    }
    else{
        self = [self initWithTitle:title style:UIBarButtonItemStylePlain target:target action:action];
        return self;
    }

}

@end
