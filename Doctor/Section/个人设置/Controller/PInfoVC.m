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
@interface PInfoVC ()
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
        self.headerImage.image = photos[0];
//        [self upLoadImageWithPhotos:photos assets:assets isSelectOriginalPhoto:YES withKey:dic[@"title"]];
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

@end
