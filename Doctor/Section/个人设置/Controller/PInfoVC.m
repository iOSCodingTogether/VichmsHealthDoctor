//
//  PInfoVC.m
//  Doctor
//
//  Created by zt on 2019/1/4.
//  Copyright © 2019年 AnyOne. All rights reserved.
//

#import "PInfoVC.h"
#import "UITextView+MWPlaceholder.h"
#import "TZImagePickerController.h"

#import "QiniuSDK.h"
#import <QN_GTM_Base64.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>

@interface PInfoVC ()
@property (nonatomic , assign) int expires; //怎么定义随你...
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UITextView *introTextView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@end

@implementation PInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configWithTitle:@"个人信息" backImage:@""];
    self.naviBGView.backgroundColor = [UIColor whiteColor];
    self.rightTitle = @"保存";
    @weakify(self);
    [[self.rightBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
       //保存
        @strongify(self);
        [self saveUserInfo];
    }];
    self.introTextView.layer.borderColor = HEXCOLOR(0xEBEBEB).CGColor;
    self.introTextView.layer.borderWidth = 1;
    [self.introTextView setPlaceholder:@"输入介绍" placeholdColor:[HEXCOLOR(0x919191) colorWithAlphaComponent:0.8]];
    self.introTextView.font = self.nameTextField.font;
    self.nameTextField.enabled = NO;
    [self.headerImage addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectHeader)]];
    
    [self loadData];
}
- (void)saveUserInfo {
//    [HYBNetworking postWithUrl:URL_Save body:@{@"FRemark":self.introTextView.text} success:^(id response) {
//        NSLog(@"====保存%@",response);
//    } fail:^(NSError *error, NSInteger statusCode) {
//
//    }];
    [HYBNetworking postWithUrl:URL_Save refreshCache:YES params:@{@"FRemark":self.introTextView.text} success:^(id response) {
        NSLog(@"====保存%@",response);
    } fail:^(NSError *error, NSInteger statusCode) {
        
    }];
}
#pragma mark -- 数据请求
- (void)loadData {
    [HYBNetworking getWithUrl:URL_Me refreshCache:YES success:^(id response) {
        NSLog(@"====个人信息%@",response);
        NSDictionary *dic = response;
        if ([dic[@"code"] isEqual:@100]) {
            NSDictionary *data = dic[@"data"];
            NSString *name = data[@"name"];
            NSString *headPic = data[@"headPic"];
            NSString *remark = data[@"remark"];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (name.length == 0) {
                    self.nameTextField.enabled = YES;
                }else {
                    self.nameTextField.enabled = NO;
                    self.nameTextField.text = name;
                }
                if ([remark isKindOfClass:[NSNull class]]) {
                    self.introTextView.text = @"";
                }else {
                    self.introTextView.text = remark;
                }
                [self.headerImage sd_setImageWithURL:[NSURL URLWithString:[headPic stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
            });
            
        }
    } fail:^(NSError *error, NSInteger statusCode) {
        
    }];
}
- (void)selectHeader {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] init];
    imagePickerVc.maxImagesCount = 1;
    imagePickerVc.allowPickingOriginalPhoto = YES;
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingImage = YES;
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
        NSData *imgData = UIImageJPEGRepresentation(photos[0], 0.5);
        [self getQNTokenWithImageData:imgData];
        self.headerImage.image = photos[0];
//        [self upLoadImageWithPhotos:photos assets:assets isSelectOriginalPhoto:YES withKey:dic[@"title"]];
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

//MARK:从服务器获取token
- (void)getQNTokenWithImageData:(NSData *)data {

    @weakify(self);
    [HYBNetworking getWithUrl:[NSString stringWithFormat:@"%@",URL_GetQNKey] refreshCache:YES success:^(id response) {
        NSLog(@"====七牛token服务器%@",response);
        @strongify(self);
        if ([response[@"code"] isEqual:@100]) {
            NSDictionary *dic = response[@"data"];
            if (![dic isKindOfClass:[NSNull class]]) {
                //MARK:上传七牛
                [self upLoadQN:dic imageData:data];
            }
        }else {
            [MBProgressHUD showAlertWithView:self.view andTitle:@"请求失败"];
        }
    } fail:^(NSError *error, NSInteger statusCode) {
        [MBProgressHUD showAlertWithView:self.view andTitle:@"连接服务器失败"];
    }];
}
- (void)upLoadQN:(NSDictionary *)dic imageData:(NSData*)imgData{
    NSString *accesskey = dic[@"accesskey"];
    NSString *secretKey = dic[@"secretKey"];

    QNConfiguration *config = [QNConfiguration build:^(QNConfigurationBuilder *builder) {
        builder.useHttps = YES;
    }];
    QNUploadManager *upManager = [[QNUploadManager alloc] initWithConfiguration:config];
    [upManager putData:imgData
                   key:accesskey
                 token:[self generateToken:accesskey secretKey:secretKey]
              complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                  NSLog(@"%@",resp);
                  if (info.ok) {
                      if ([resp[@"status"] isEqual:@0]) {
                      }
                  }
                  else {
                      
                  }
              } option:nil];
}

/**生成token*/
-(NSString*)generateToken:(NSString *)accessKey secretKey:(NSString *)secretKey{
    NSString *encodedString = [self encodedString];
    NSString*encodedSignedString = [self HMACSHA1:secretKey text:encodedString];
    return[NSString stringWithFormat:@"%@:%@:%@",accessKey,encodedSignedString,encodedString];
}
/**生成encodedString*/
-(NSString*)encodedString {
    NSMutableDictionary *authInfo = [[NSMutableDictionary alloc] init];
    authInfo[@"scope"] =@"demo";
//    authInfo[@"deadline"] = @(Deadline);
    /** 时间*/
    NSData *authInfoData = [NSJSONSerialization dataWithJSONObject:authInfo
                                                           options:0
                                                             error:nil];
    NSString* encoded = [self URLSafeBase64Encode:authInfoData];
    return encoded;
}
/** URL安全的Base64编码 */
- (NSString*)URLSafeBase64Encode:(NSData*)text {
    NSString *base64 = [[NSString alloc] initWithData:[QN_GTM_Base64 encodeData:text]
                                             encoding:NSUTF8StringEncoding];
    base64 = [base64 stringByReplacingOccurrencesOfString:@"+" withString:@"-"];
    base64 = [base64 stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    return base64;
    
}
/**URL安全的Base64编码*/
- (NSString*)HMACSHA1:(NSString*)key text:(NSString*)text
{
    const char *cKey = [key cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [text cStringUsingEncoding:NSUTF8StringEncoding];
    char cHMAC[CC_SHA1_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA1, cKey,strlen(cKey), cData,strlen(cData), cHMAC);
    NSData *HMAC = [[NSData alloc]initWithBytes:cHMAC length:CC_SHA1_DIGEST_LENGTH];
    NSString *hash = [self URLSafeBase64Encode:HMAC];
    return hash;
    
}


@end
