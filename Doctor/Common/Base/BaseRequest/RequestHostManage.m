//
//  RequestHostManage.m
//  VichmsHealthDoctor
//  Created by  licc on 2018/9/4.
//  Copyright © 2018年 AnyOne. All rights reserved.
//

#import "RequestHostManage.h"
NSString *appHOST;
@implementation RequestHostManage
+(void)load
{
    if(appHOST == nil){
        appHOST = @"http://www.goodly.com.cn/VichmsApi/api";
    }
    DLog(@"自动执行服务器缺省地址%@",appHOST);

}

+ (instancetype)shareInstance{
    
    static RequestHostManage * sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[RequestHostManage alloc] init];
    });
    return sharedInstance;
}

@end
