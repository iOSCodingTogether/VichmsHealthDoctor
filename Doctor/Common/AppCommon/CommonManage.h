//
//  CommonManage.h
//  VichmsHealthDoctor
//  Created by  licc on 2018/11/4.
//  Copyright © 2018年 AnyOne. All rights reserved.
//
//单例 全局变量保存
#import <Foundation/Foundation.h>
#import "GoodsPageRequestModel.h"
#import "QiniuGetKeyRequestModel.h"
#import "QiniuSDK.h"

#define  CommonManageInstance [CommonManage shareInstance]

NS_ASSUME_NONNULL_BEGIN

@interface CommonManage : NSObject
+(CommonManage *)shareInstance;

@property (nonatomic, strong) GoodsPageResultModel * goodsPageResultModel;     //
@property (nonatomic, strong) QiniuGetKeyResultModel * qiniuResultModel;     //

-(void)goodsPageResultModelBack:(void(^)(GoodsPageResultModel *goodsPageResultModel))back;

-(void)qiniugetKeyBack:(void (^)(QiniuGetKeyResultModel *qnmodel))back;

+(void)QNPutimage:( id)image
          forView:(UIView *)view
              key:(NSString *)key
              res:(void(^)( BOOL success,NSString *key,NSString *imageURL))resInfoHandler
  progressHandler:(QNUpProgressHandler)progressHandler;

@end

NS_ASSUME_NONNULL_END
