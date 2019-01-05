//
//  UserInfoManager.h
//  Doctor
//
//  Created by zt on 2019/1/4.
//  Copyright © 2019年 AnyOne. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, UserType) {
    UserType_Doctor,
    UserType_Accompany,
    UserType_Service,
};

@interface UserInfoManager : NSObject

+ (instancetype)shareInstance;

- (UserType)returnUserType;

@end
