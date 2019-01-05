//
//  UserInfoManager.m
//  Doctor
//
//  Created by zt on 2019/1/4.
//  Copyright © 2019年 AnyOne. All rights reserved.
//

#import "UserInfoManager.h"

@implementation UserInfoManager

+ (instancetype)shareInstance {
    static UserInfoManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[UserInfoManager alloc] init];
    });
    return instance;
}

- (UserType)returnUserType {
    // TODO: 判断用户类型，测试用
    int i = 0;
    if (i == 0) {
        //陪诊员
        return UserType_Accompany;
    }else if (i == 1) {
        //专家
        return UserType_Doctor;
    }
    return UserType_Service;

}

@end
