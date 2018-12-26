//
//  BaseRequest.m
//  VichmsHealthDoctor
//  Created by  licc on 2018/8/28.
//  Copyright © 2018年 AnyOne. All rights reserved.
//

#import "BaseRequest.h"
#import "AppDefine.h"
#import "BaseErrResultModel.h"
#import "DoctorLoginManage.h"

static AFSecurityPolicy *_securityPolicy = nil;
static AFHTTPResponseSerializer *_responseSerializer = nil;

@interface BaseRequest ()
@property (assign,nonatomic) BOOL showSuccessHud;
@property (assign,nonatomic) BOOL showFailHud;
//@property (assign,nonatomic) BOOL notShowFailHud;
@property (assign,nonatomic) BOOL showGifHud;
//@property (assign,nonatomic) BOOL needLoginAgain;

@property (strong,nonatomic) UIView * viewForGif;
@property (strong,nonatomic) UIView * viewForSuccessFail;
@property (strong,nonatomic) MBProgressHUD * gifHud;
@property (strong, nonatomic) BaseRequestModel *requestModel;


@property (strong,nonatomic) NSURLSessionDataTask *sessionDataTask;


@end

@implementation BaseRequest








+(BaseRequest *)requestWithRequestModelget:(BaseRequestModel *)requestModel ret:(YTRequestBack)ret{

    BaseRequest *manage = [BaseRequest manager];
    //    manage.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/javascript",@"application/json",@"text/json",@"text/plain",@"multipart/form-data",@"application/vnd.goa.error",nil];
    
    manage.requestModel = requestModel;
    NSString *url = requestModel.requestURL;
    NSDictionary *params = requestModel.mj_keyValues;
    NSString *mes =[NSString stringWithFormat:@"%@ \n%@",@"request",requestModel.mj_JSONString ];
    NSLog(@"%@",mes);
    
    //        AFHTTPRequestSerializer *requestSerializer =  [AFHTTPRequestSerializer serializer];
    AFHTTPRequestSerializer *requestSerializer =  [AFJSONRequestSerializer serializer];
    [requestSerializer setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [requestSerializer setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"token"] forHTTPHeaderField:@"token"];
    
    manage.showFailHud = YES;
    if(requestModel.needLoginToken){
        
    }
    manage.requestSerializer = requestSerializer;
    //    }
    //    manage.responseSerializer = [AFJSONResponseSerializer serializer];
    
    __weak BaseRequest *weakManage = manage;
    
    UIView *view;
    if(view == nil){
        view = [UIApplication sharedApplication].delegate.window;
    }
    manage.gifHud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    manage.showGifHud = YES;
    [manage.gifHud hideAnimated:1];
    
   
    
    if (requestModel.serverMethod ==YTServerMethodGet ){//
        manage.sessionDataTask = [manage GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSString *jsonStr = ((NSDictionary*)responseObject).mj_JSONString;
            //        BaseResultModel *resultModel = [BaseResultModel mj_objectWithKeyValues:responseObject];
            Class respDataclass = weakManage.requestModel.resultDataClass;
            __kindof BaseResultModel * obj = [respDataclass mj_objectWithKeyValues:responseObject];
            
            DLog(@"%@ 返回数据Success\n%@",task.response.URL,jsonStr);
            if (ret){
                ret(true,obj, jsonStr);
            }
            if (manage.showFailHud&&[obj success]==0){
                LR_TOAST(@"%@",obj.msg);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (weakManage.gifHud){
                [weakManage.gifHud hideAnimated:YES];
            }
            NSData *data = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
            NSString *errorStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            Class respDataclass = weakManage.requestModel.resultDataClass;
            __kindof BaseResultModel * obj = [respDataclass mj_objectWithKeyValues:errorStr];
            NSLog(@"%@ 返回数据fail\n %@\n\n%@",task.response.URL,data.mj_keyValues,errorStr);
            
            if (ret){
                ret(NO,obj, errorStr);
            }
            if (manage.showFailHud&&[obj success]==0){
                LR_TOAST(@"server error :%@",obj.msg);
            }
            if(obj.status== 401)
            {
                [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"token"];
                // 改的代码，此处传LoginSmsCodeVC
                [DoctorLoginManage verifyIsOnline:[UIViewController new]];
                
                
            }
        } ];
    }
   
    
    return manage;
}
+(BaseRequest *)requestWithRequestModelpost:(BaseRequestModel *)requestModel ret:(YTRequestBack)ret{
    BaseRequest *manage = [BaseRequest manager];
    //    manage.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/javascript",@"application/json",@"text/json",@"text/plain",@"multipart/form-data",@"application/vnd.goa.error",nil];
    
    manage.requestModel = requestModel;
    NSString *url = requestModel.requestURL;
    NSDictionary *params = requestModel.mj_keyValues;
    NSString *mes =[NSString stringWithFormat:@"%@ \n%@",@"request",requestModel.mj_JSONString ];
    NSLog(@"%@",mes);
    
    //        AFHTTPRequestSerializer *requestSerializer =  [AFHTTPRequestSerializer serializer];
    AFHTTPRequestSerializer *requestSerializer =  [AFJSONRequestSerializer serializer];
    [requestSerializer setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [requestSerializer setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"token"] forHTTPHeaderField:@"token"];
    
    manage.showFailHud = YES;
    if(requestModel.needLoginToken){
        
    }
    manage.requestSerializer = requestSerializer;
    //    }
    //    manage.responseSerializer = [AFJSONResponseSerializer serializer];
    
    __weak BaseRequest *weakManage = manage;
    
    UIView *view;
    if(view == nil){
        view = [UIApplication sharedApplication].delegate.window;
    }
    manage.gifHud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    manage.showGifHud = YES;
    [manage.gifHud hideAnimated:1];
    
   
    
    if (requestModel.serverMethod ==YTServerMethodPost){
        manage.sessionDataTask = [manage POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSString *jsonStr = ((NSDictionary*)responseObject).mj_JSONString;
            //        BaseResultModel *resultModel = [BaseResultModel mj_objectWithKeyValues:responseObject];
            Class respDataclass = weakManage.requestModel.resultDataClass;
            __kindof BaseResultModel * obj = [respDataclass mj_objectWithKeyValues:responseObject];
            
            DLog(@"%@ 返回数据Success\n%@",task.response.URL,jsonStr);
            if (ret){
                ret(true,obj, jsonStr);
            }
            if (manage.showFailHud&&[obj success]==0){
                LR_TOAST(@"%@",obj.msg);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (weakManage.gifHud){
                [weakManage.gifHud hideAnimated:YES];
            }
            NSData *data = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
            NSString *errorStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            Class respDataclass = weakManage.requestModel.resultDataClass;
            __kindof BaseResultModel * obj = [respDataclass mj_objectWithKeyValues:errorStr];
            NSLog(@"%@ 返回数据fail\n %@\n\n%@",task.response.URL,data.mj_keyValues,errorStr);
            
            if (ret){
                ret(NO,obj, errorStr);
            }
            if (manage.showFailHud&&[obj success]==0){
                LR_TOAST(@"server error :%@",obj.msg);
            }
            if(obj.status== 401)
            {
                [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"token"];
                // 改的代码，此处传LoginSmsCodeVC
                [DoctorLoginManage verifyIsOnline:[UIViewController new]];
            }
        } ];    }
    
    return manage;
    
}
+(BaseRequest *)requestWithRequestModel:(BaseRequestModel *)requestModel ret:(YTRequestBack)ret{
    if (requestModel.serverMethod ==YTServerMethodGet ){//
       return [self requestWithRequestModelget:requestModel ret:ret];
    }
    else if (requestModel.serverMethod ==YTServerMethodPost){
        return [self requestWithRequestModelpost:requestModel ret:ret];
    }
    return nil;
}


@end
