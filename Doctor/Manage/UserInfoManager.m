//
//  UserInfoManager.m
//  Doctor
//
//  Created by zt on 2019/1/4.
//  Copyright © 2019年 AnyOne. All rights reserved.
//

#import "UserInfoManager.h"

static NSString * const userKey = @"user";

@implementation UserInfoManager

+ (instancetype)shareInstance {
    static UserInfoManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[UserInfoManager alloc] init];
    });
    return instance;
}

- (UserInfoModel *)user {
    if (!_user) {
        NSDictionary *userInfo = [[NSUserDefaults standardUserDefaults] objectForKey:userKey];
        _user = [UserInfoModel mj_objectWithKeyValues:userInfo];
    }
    
    return _user;
}

- (void)recordUserInfo:(UserInfoModel *)userInfo {
    if (userInfo) {
        self.user = userInfo;
        [[NSUserDefaults standardUserDefaults] setObject:[userInfo mj_JSONObject] forKey:userKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)updateUser {
    [self recordUserInfo:self.user];
}

- (void)logoutUser {
    self.user = nil;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:userKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (UserType)returnUserType {
    // TODO: 判断用户类型，测试用
    switch (self.user.personType.integerValue) {
        case 3: {
            return UserType_Accompany;
        } break;
        case 4: {
            return UserType_Doctor;
        } break;
        case 5: {
            return UserType_Service;
        } break;
    }
    
    return UserType_Accompany;
}

@end
