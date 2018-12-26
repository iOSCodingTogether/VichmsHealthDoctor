//
//  LoginRequest.m
//  VichmsHealthDoctor
//   Created by  licc on 2018/9/4.
//  Copyright © 2018年 AnyOne. All rights reserved.
//

#import "LoginRequestModel.h"

@implementation LoginRequestModel
-(instancetype)init{
    self = [super init];
    self.requestURL = action_user_login;
    self.serverMethod = YTServerMethodPost;
    self.resultDataClass = [LoginResultModel class];
    self.needLoginToken = NO;
    return self ;
}
@end
