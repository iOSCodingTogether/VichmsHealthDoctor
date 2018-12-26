//
//  NSDate+CCategory.h
//  VichmsHealthDoctor
//  Created by  licc on 2018/9/9.
//  Copyright © 2018年 AnyOne. All rights reserved.
//

#import <Foundation/Foundation.h>


UIKIT_STATIC_INLINE NSString * LRTimeIntervalFromToFormatter(NSString *dateStr,NSString *fromFormatter,NSString *toFormatter){
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //指定时间显示样式: HH表示24小时制 hh表示12小时制
//    [formatter setDateFormat:@"YYYY-MM-ddTHH:mm:ss.sss+xxxx"];
    [formatter setDateFormat:fromFormatter];
    NSDate *date = [formatter dateFromString:dateStr];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:toFormatter];
    NSString *datestring= [dateFormatter stringFromDate:date];
    return datestring;
}

@interface NSDate (CCategory)

@end
