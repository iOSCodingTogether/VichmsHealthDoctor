//
//  UserInfoManager.h
//  Doctor
//
//  Created by zt on 2019/1/4.
//  Copyright © 2019年 AnyOne. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UserInfoModel.h"

typedef NS_ENUM(NSUInteger, UserType) {
    UserType_Doctor,
    UserType_Accompany,
    UserType_Service,
};

@interface UserInfoManager : NSObject

@property (nonatomic, strong) UserInfoModel *user;

+ (instancetype)shareInstance;

/** 存储user信息 */
- (void)recordUserInfo:(UserInfoModel *)userInfo;
/** 更新数据 */
- (void)updateUser;

/** 退出登录 */
- (void)logoutUser;

- (UserType)returnUserType;

@end
