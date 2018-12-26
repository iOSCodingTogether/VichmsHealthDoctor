//
//  ResultBase.h
//  yuantong
//
//  Created by  licc on 2018/3/12.
//  Copyright © 2018年 boshtc. All rights reserved.

// 数据返回（成功/失败）解析 BaseResultModel 统一处理

#import <Foundation/Foundation.h>

#import <MJExtension/MJExtension.h>

#define ReplaceSuper(superName) __replacedKey__##superName;

@interface BaseResultModel : NSObject

@property (assign,nonatomic,readonly) BOOL success;//是否成功（http成功 and 后台成功）


#pragma mark -  success

@property (strong,nonatomic) NSNumber * code;//"0",
@property (strong,nonatomic) NSString * msg;//

///**
// ReplaceSuper(aa)
// 把第二级 aa 下面的属性提到与aa 同一级第一级里面来
// 例如字典：
//  @{@"returnCode" : @"0",@"description" : @"孩子",@"xxxxx" : @{@"phone" : @"lufy"}}
// 可以这样提供给NSObject+MJKeyValue 去解析
// @property (strong,nonatomic) NSString * returnCode,description,phone,ReplaceSuper(aa);
// 除此种情况之外的其他key的替换，自己去实现+ (NSDictionary *)replacedKeyFromPropertyName；
// */
@property (strong,nonatomic) NSString * ReplaceSuper(data);
//

#pragma mark -  fail
//{"timestamp":"2018-10-17T01:53:10.806+0000","status":401,"error":"Unauthorized","message":"No message available","path":"/VichmsApi/api/user/me"}

@property (strong,nonatomic) NSString *timestamp ;  //
@property (assign,nonatomic) NSInteger status ;  //
@property (strong,nonatomic) NSString *error ;  //
@property (strong,nonatomic) NSString *message ;  //
@property (strong,nonatomic) NSString *path ;  //


@end
