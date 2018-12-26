//
//  SmsCodeRequestModel.m
//  VichmsHealthDoctor
//  Created by  licc on 2018/9/4.
//  Copyright © 2018年 AnyOne. All rights reserved.
//

#import "SmsCodeRequestModel.h"

@implementation SmsCodeRequestModel


-(instancetype)init{
    self = [super init];
    self.requestURL = action_user_smsCode;
    self.serverMethod = YTServerMethodGet;
    self.resultDataClass = [SmsCodeResultModel class];
    self.needLoginToken = NO;
    return self ;
}

@end
