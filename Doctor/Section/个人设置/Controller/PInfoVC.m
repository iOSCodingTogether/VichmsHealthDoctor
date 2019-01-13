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
    self.introTextView.layer.borderColor = HEXCOLOR(0xEBEBEB).CGColor;
    self.introTextView.layer.borderWidth = 1;
    [self.introTextView setPlaceholder:@"输入介绍" placeholdColor:[HEXCOLOR(0x919191) colorWithAlphaComponent:0.8]];
    self.introTextView.font = self.nameTextField.font;
    self.nameTextField.enabled = NO;
    [self.headerImage addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectHeader)]];
    
    [self loadData];
}

- (void)loadData {
    [HYBNetworking getWithUrl:URL_Me refreshCache:YES success:^(id response) {
        NSLog(@"====个人信息%@",response);
        NSDictionary *dic = response;
        if ([dic[@"code"] isEqual:@100]) {
            NSDictionary *data = dic[@"data"];
            NSString *name = data[@"name"];
            NSString *headPic = data[@"headPic"];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (name.length == 0) {
                    self.nameTextField.enabled = YES;
                }else {
                    self.nameTextField.enabled = NO;
                    self.nameTextField.text = name;
                }
                [self.headerImage sd_setImageWithURL:[NSURL URLWithString:headPic]];
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
