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

@property (nonatomic,copy) NSString *headPic;//头像名字
@property (nonatomic,assign) BOOL isChangeHead;//是否修改头像

@end

@implementation PInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.headPic = @"";
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
    [self.view endEditing:YES];
    NSDictionary *paramDic = @{@"remark":self.introTextView.text
                               //                                             @"sex":@"男",
                               //                                             @"name":@"",
                               //                                             @"headPic":self.headPic
                               //                                             @"idCard":@"",
                               //                                             @"age":@9
                               };
    if (self.isChangeHead) {
        paramDic = @{@"remark":self.introTextView.text,
                                   //                                             @"sex":@"男",
                                   //                                             @"name":@"",
                                                                                @"headPic":self.headPic
                                   //                                             @"idCard":@"",
                                   //                                             @"age":@9
                                   };

    }
    [HYBNetworking postWithUrl:URL_Save body:paramDic success:^(id response) {
        NSDictionary *dic = response;
        if ([dic[@"code"] isEqual:@100]) {
            NSString *headPic = [UserInfoManager shareInstance].user.headPic;
            NSMutableArray *arr = [NSMutableArray arrayWithArray:[headPic componentsSeparatedByString:@"/"]];
            if (arr.count >= 2) {
                [arr replaceObjectAtIndex:arr.count-1 withObject:self.headPic];
            }
            [UserInfoManager shareInstance].user.headPic = [arr componentsJoinedByString:@"/"];
            [[UserInfoManager shareInstance]updateUser];
            [self.navigationController popViewControllerAnimated:YES];
            [MBProgressHUD showAlertWithView:self.view andTitle:@"修改成功"];
        }else {
            [MBProgressHUD showAlertWithView:self.view andTitle:@"修改失败"];
        }

    } fail:^(NSError *error, NSInteger statusCode) {
        [MBProgressHUD showAlertWithView:self.view andTitle:@"修改失败"];
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
            self.headPic = headPic;
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
        if (statusCode == 401) {
            //token失效，重新登录
            [UIApplication sharedApplication].delegate.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[LoginVC new]];
            [[UserInfoManager shareInstance] logoutUser];
            
            [[[NIMSDK sharedSDK] loginManager] logout:^(NSError * _Nullable error) {
                if (error) {
                    NSLog(@"退出登录失败");
                    return;
                }
            }];
        }else {
            [MBProgressHUD showAlertWithView:self.view andTitle:@"连接服务器失败"];
        }
    }];
}
- (void)upLoadQN:(NSDictionary *)dic imageData:(NSData*)imgData{
    NSString *token = dic[@"uploadToken"];
    QNConfiguration *config = [QNConfiguration build:^(QNConfigurationBuilder *builder) {
        builder.useHttps = YES;
    }];
    QNUploadManager *upManager = [[QNUploadManager alloc] initWithConfiguration:config];
    NSString *fileName = [NSString stringWithFormat:@"ios_header_%@",[self getCurrentTime]];
    [upManager putData:imgData
                   key:fileName
                 token:token
              complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                  NSLog(@"%@",resp);
                  if (info.ok) {
                      //MARK: key是文件名字
                      self.headPic = key;
                      self.isChangeHead = YES;
                      
                      
                      if ([resp[@"status"] isEqual:@0]) {
                          
                      }
                  }
                  else {
                      [MBProgressHUD showAlertWithView:self.view andTitle:@"上传失败，请重试"];
                  }
              } option:nil];
}
- (NSString *)getCurrentTime {
    // 获取系统当前时间
    NSDate * date = [NSDate date];
    NSTimeInterval sec = [date timeIntervalSinceNow];
    NSDate * currentDate = [[NSDate alloc] initWithTimeIntervalSinceNow:sec];
    
    //设置时间输出格式：
    NSDateFormatter * df = [[NSDateFormatter alloc] init ];
    [df setDateFormat:@"yyyyMMddHHmmss_SSS"];
    NSString * na = [df stringFromDate:currentDate];
    return na;
}

@end
