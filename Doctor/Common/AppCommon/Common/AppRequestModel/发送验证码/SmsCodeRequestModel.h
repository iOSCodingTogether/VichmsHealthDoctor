//
//  SmsCodeRequestModel.h
//  VichmsHealthDoctor
//  Created by  licc on 2018/9/4.
//  Copyright © 2018年 AnyOne. All rights reserved.
//

#import "BaseRequestModel.h"
#import "SmsCodeResultModel.h"

@interface SmsCodeRequestModel : BaseRequestModel

@property(strong, nonatomic) NSString * phone;        //手机号    (string)
@property(strong, nonatomic) NSString * personType;  //1 个人 2 企业
@end
