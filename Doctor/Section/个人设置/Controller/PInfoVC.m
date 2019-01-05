//
//  PInfoVC.m
//  Doctor
//
//  Created by zt on 2019/1/4.
//  Copyright © 2019年 AnyOne. All rights reserved.
//

#import "PInfoVC.h"
#import "UITextView+MWPlaceholder.h"
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
    self.introTextView.layer.borderColor = HEXCOLOR(0xEBEBEB).CGColor;
    self.introTextView.layer.borderWidth = 1;
    [self.introTextView setPlaceholder:@"输入介绍" placeholdColor:[HEXCOLOR(0x919191) colorWithAlphaComponent:0.8]];
    self.introTextView.font = self.nameTextField.font;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
