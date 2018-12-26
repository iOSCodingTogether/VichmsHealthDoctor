//
//  DoctorLoginManage.m
//  Doctor
//
//  Created by  licc on 2018/9/9.
//  Copyright © 2018年 AnyOne. All rights reserved.
//

#import "DoctorLoginManage.h"
#import "AppUserDefaults.h"
#import "BaseNavViewController.h"
#import "LoginResultModel.h"
#import "UserInfoRequestModel.h"
#import "BaseRequest.h"
#import "UserInfoRequestModel.h"

@implementation DoctorLoginManage

+(void)getUserInfo{
    [BaseRequest requestWithRequestModel:[UserInfoRequestModel new] ret:^(BOOL success, __kindof LoginResultModel *dataModel, NSString *jsonObjc) {
        if(dataModel.success){
            LR_USER_DEFAULTS.userInfo = jsonObjc;
    }
    }];
        
}
+(BOOL)verifyIsOnline:(UIViewController *)vc {
    if (LR_USER_DEFAULTS.token.length == 0){
        BaseNavViewController *nav =[[BaseNavViewController alloc]initWithRootViewController:vc];
        UITabBarController *tab =  (UITabBarController *)[UIApplication sharedApplication].delegate.window.rootViewController;
        [tab presentViewController:nav animated:YES completion:nil];
        return NO;
    }
    else{
        return YES;
    }
    
}
//实现功能：用户点击“视频医生”后，
//1） 系统判断登录用户的【人员类型】=个人（1），
//则判断用户名与TpersonBaseInfo表中的FPhone相等记录的FVIP是否=否，
//1) 如果=否则出现弹窗；点击弹窗【开通】进入《开通视频医生vip》页面
//2) 如果=是则直接调用和缓医生界面。
//2） 【人员类型】=企业（2），
//则判断用户名与TpersonBaseInfo表中的FPhone相等记录的FVIP是否=否，
//1) 如果=否则系统给出提示：企业用户请联系管理员开通视频医生。
//2) 如果=是则（判断是否在有效期内TPersonBaseInfo表的【有效日期】）直接调用和缓医生界面。
+(BOOL)verifyIsVip{
    UserInfoResultModel *userInfo = [UserInfoResultModel mj_objectWithKeyValues: LR_USER_DEFAULTS.userInfo];
    if(userInfo.personType.integerValue == 1){
        DLog(@"个人用户");
        if(userInfo.vip.integerValue ==0){
            return 0;
        }
        else{
            return 1;
        }
    }
    else if(userInfo.personType.integerValue == 2){
        DLog(@"企业用户");
        if(userInfo.vip.integerValue ==0){
            return 0;
        }
        else{
            if(userInfo.validDate){//判断有效期
                return YES;
            }
            return NO;
        }
    }
    return NO;

}
+(void)verifyIsVipBack:(void (^)(BOOL isVip))back{
    [DoctorLoginManage requestUserInfoRet:^(BOOL success, __kindof UserInfoResultModel *dataModel, NSString *jsonObjc) {
        if(dataModel.success){
            LR_USER_DEFAULTS.userInfo = dataModel.mj_JSONData;
            if(back){
                BOOL isVip = [DoctorLoginManage verifyIsVip];
                back(isVip);
            }
        }
    }];
}
+(BaseRequest *)requestUserInfoRet:(YTRequestBack)ret{

    UserInfoRequestModel *requestModel = [UserInfoRequestModel new];
    return [BaseRequest requestWithRequestModel:requestModel ret:ret ];
}
@end
