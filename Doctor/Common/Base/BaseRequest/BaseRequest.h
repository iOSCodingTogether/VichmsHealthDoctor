//
//  BaseRequest.h
//  VichmsHealthDoctor
//  Created by  licc on 2018/8/28.
//  Copyright © 2018年 AnyOne. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "BaseResultModel.h"
#import "BaseRequestModel.h"
#import <MBProgressHUD/MBProgressHUD.h>

//typedef void(^YTRequestBack)( BaseResultModel *result,  NSObject * dataModel, NSString* jsonObjc);
typedef void(^YTRequestBack)( BOOL success, __kindof BaseResultModel *dataModel, NSString *jsonObjc);


@interface BaseRequest : AFHTTPSessionManager

//@property(nonatomic,strong)AFHTTPSessionManager* afSessionManager;


+(BaseRequest *)requestWithRequestModel:(BaseRequestModel *)requestModel ret:(YTRequestBack)ret;





@end
