//
//  AccompanyRecordVC.h
//  Doctor
//
//  Created by zt on 2019/1/5.
//  Copyright © 2019年 AnyOne. All rights reserved.
//

#import "BaseViewController.h"
//#import "OrderCreateRequestModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AccompanyRecordVC : BaseViewController

@property (nonatomic,copy) NSString *orderId;
@property (nonatomic,assign) BOOL isEdit;

@property (nonatomic,copy) NSString *navTitle;//导航栏title
@property (nonatomic,assign) BOOL selectDoc;//医生可选
@property (nonatomic,assign) BOOL visitTime;//就诊时间


@end

NS_ASSUME_NONNULL_END
