//
//  HomeNewsPageResultSubModel.m
//  VichmsHealthDoctor
//  Created by  licc on 2018/9/9.
//  Copyright © 2018年 AnyOne. All rights reserved.
//

#import "HomeNewsPageResultSubModel.h"


@implementation HomeNewsPageResultSubModel


-(NSString *)endTimeTranslate{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //指定时间显示样式: HH表示24小时制 hh表示12小时制
    if(self.endDate.length>10){
        return [self.endDate substringWithRange:NSMakeRange(0, 10)];
    }
    return @"";
}
@end
