//
//  AppUserDefaults.h
//  VichmsHealthDoctor
//   Created by  licc on 2018/9/4.
//  Copyright © 2018年 AnyOne. All rights reserved.
//

#import "BaseUserDefaults.h"

@interface AppUserDefaults : BaseUserDefaults
@property (nonatomic, strong) NSString * token;
@property (nonatomic, strong) NSString * userName;//ge人
@property (nonatomic, strong) NSString * smsCode;

@property (nonatomic, strong) NSString * companyuserName;     //企业
@property (nonatomic, strong) NSString * password;     //

@property (nonatomic, strong) NSString * loginTest;

@property (nonatomic, strong) NSString * loginResultInfo;//LoginResultModel
@property (nonatomic, strong) NSString *  userInfo;//UserInfoResultModel

@end
