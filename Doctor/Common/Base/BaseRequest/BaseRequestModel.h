//
//  RequestBase.h
//  yuantong
//
//  Created by  licc on 2018/3/12.
//  Copyright © 2018年 boshtc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestHostManage.h"
#import "BaseResultModel.h"

typedef NS_ENUM(NSInteger, YTServerMethod) {
    YTServerMethodGet          = 0,  // get请求
    YTServerMethodPost     = 1,   // post请求
};

@interface BaseRequestModel : NSObject


@property (strong,nonatomic) NSString *requestURL ;//当前接口的地址
@property(nonatomic) YTServerMethod serverMethod;           //请求类型get／Post.. (默认get)
@property (strong,nonatomic) Class resultDataClass;// 接口返回数据需要是BaseResultModel的data的类
@property (assign,nonatomic) BOOL needLoginToken;   //是否在header加 login-token

@property (nonatomic, assign)  NSInteger pageNo;     //
@property (nonatomic, assign)  NSInteger pageSize;     //

-(NSInteger)nextPageNoForCurDataCount:(NSInteger)count;

@end
