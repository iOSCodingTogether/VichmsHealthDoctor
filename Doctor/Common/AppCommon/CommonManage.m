//
//  CommonManage.m
//  VichmsHealthDoctor
//
//  Created by  licc on 2018/11/4.
//  Copyright © 2018年 AnyOne. All rights reserved.
//

#import "CommonManage.h"
#import "BaseRequest.h"
#import "QiniuSDK.h"
#import "QN_GTM_Base64.h"
#import <CommonCrypto/CommonHMAC.h>


@implementation CommonManage

static CommonManage * sharedInstance = nil;
+(CommonManage *)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CommonManage alloc] init];
    });
    return sharedInstance;

}
-(GoodsPageResultModel *)goodsPageResultModel{
    [self goodsPageResultModelBack:^(GoodsPageResultModel * _Nonnull goodsPageResultModel) {
        
    }];
    return _goodsPageResultModel;
}
-(void)goodsPageResultModelBack:(void (^)(GoodsPageResultModel * ))back{
    if(_goodsPageResultModel==nil){
        GoodsPageRequestModel *model = [GoodsPageRequestModel new];
        model.sortInfo = @"DESC_createDate";
        [BaseRequest requestWithRequestModel:model ret:^(BOOL success,  GoodsPageResultModel *dataModel, NSString *jsonObjc) {
            if(dataModel.success){
                self->_goodsPageResultModel = dataModel;
                
            }
        }];
    }
    else{
        back(_goodsPageResultModel);
    }
    
}

-(void)qiniugetKeyBack:(void (^)(QiniuGetKeyResultModel *qnmodel))back{
    if(_qiniuResultModel ==nil){
        QiniuGetKeyRequestModel *model = [QiniuGetKeyRequestModel new];
        [BaseRequest requestWithRequestModel:model ret:^(BOOL success,  QiniuGetKeyResultModel *dataModel, NSString *jsonObjc) {
            if(dataModel.success){
                self->_qiniuResultModel = dataModel;
                
            }
        }];
    }else{
        back(_qiniuResultModel);

    }
}



+(void)QNPutimage:( id)image
          forView:(UIView *)view
              key:(NSString *)key
              res:(void(^)( BOOL success,NSString *key,NSString *imageURL))resInfoHandler
  progressHandler:(QNUpProgressHandler)progressHandler{
    [[CommonManage shareInstance]qiniugetKeyBack:^(QiniuGetKeyResultModel * _Nonnull qnmodel) {
        //七牛
        static NSString *qiniutoken;
        if(qiniutoken.length ==0){
            qiniutoken = [CommonManage getQiNiuTokenKey:nil accesskey:qnmodel.accesskey secretKey:qnmodel.secretKey];
        }
        NSString *token = qiniutoken;


        NSData *data;
        if([image isKindOfClass:[UIImage class]]){
            //    if (UIImagePNGRepresentation(image) == nil) {
            data = UIImageJPEGRepresentation(image, 0.5);
        }
        else  if([image isKindOfClass:[NSData class]]){
            data = image;
        }
        else if([image isKindOfClass:[NSString class]]){
            data = [NSData dataWithContentsOfURL:[NSURL URLWithString:image]];

        }

        
        QNUploadOption *opt= [[QNUploadOption alloc] initWithMime:nil
                                                  progressHandler: ^(NSString *key, float percent) {
                                                      
                                                      if (progressHandler) {
                                                          progressHandler(key,percent);
                                                      }
                                                  }
                              
                                                           params:@{ @"x:foo":@"fooval" } checkCrc:YES cancellationSignal:nil];
//        QNUploadManager *upManager = [[QNUploadManager alloc] init];
        QNUploadManager *upManager = [ QNUploadManager sharedInstanceWithConfiguration:[QNConfiguration build:^(QNConfigurationBuilder *builder) {
            builder.zone = [QNZone zone0];
        }]];

        [upManager putData:data key:key token:token
                  complete: ^(QNResponseInfo *info,NSString *key,NSDictionary *resp){
                      if(key.length ==0){
                          key = resp[@"key"];//hash
                      }
                      if (resInfoHandler) {
                          NSString *url= [NSString stringWithFormat:@"%@",key];
                          resInfoHandler(info.statusCode==200?YES:NO,key,url);
                      }
                  }
                    option:opt];
    }];
    
}

+ (NSString*)getQiNiuTokenKey:(NSString *)key accesskey:(NSString *)accesskey secretKey:(NSString *)secretKey{
    
    NSMutableDictionary *authInfo = [NSMutableDictionary dictionary];
    NSString *sc0=@"demo";
    if (key.length) {
        sc0=[sc0 stringByAppendingFormat:@":%@",key ];
        
    }
    [authInfo setObject:sc0 forKey:@"scope"];
    
    [authInfo
     setObject:[NSNumber numberWithLong:[[NSDate date] timeIntervalSince1970] + 360]
     forKey:@"deadline"];
    
    NSData *jsonData =
    [NSJSONSerialization dataWithJSONObject:authInfo options:NSJSONWritingPrettyPrinted error:nil];
    NSString *encodedString = [self urlSafeBase64Encode:jsonData];
    
    NSString *encodedSignedString = [self HMACSHA1:secretKey text:encodedString];
    
    NSString *token =
    [NSString stringWithFormat:@"%@:%@:%@",accesskey, encodedSignedString, encodedString];
    
    return token;
    
}

+ (NSString *)urlSafeBase64Encode:(NSData *)text {
    NSString *base64 =
    [[NSString alloc] initWithData:[QN_GTM_Base64 encodeData:text] encoding:NSUTF8StringEncoding];
    return base64;
}
+ (NSString *)HMACSHA1:(NSString *)key text:(NSString *)text {
    const char *cKey = [key cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [text cStringUsingEncoding:NSUTF8StringEncoding];
    
    char cHMAC[CC_SHA1_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC length:CC_SHA1_DIGEST_LENGTH];
    NSString *hash = [self urlSafeBase64Encode:HMAC];
    return hash;
}

@end
