//
//  LoginRequest.h
//  VichmsHealthDoctor
//   Created by  licc on 2018/9/4.
//  Copyright © 2018年 AnyOne. All rights reserved.
//

#import "BaseRequestModel.h"
#import "LoginResultModel.h"

@interface LoginRequestModel : BaseRequestModel

@property (nonatomic, strong) NSString * phone;     //
@property (nonatomic, strong) NSString * password;     //
@property(strong, nonatomic) NSString * personType;  //1 个人 2 企业

@end
