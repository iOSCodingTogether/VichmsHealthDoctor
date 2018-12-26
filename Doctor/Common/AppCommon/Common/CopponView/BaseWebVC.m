//
//  BaseWebVC.m
//  VichmsHealthDoctor
//   Created by  licc on 2018/10/17.
//  Copyright © 2018年 AnyOne. All rights reserved.
//

#import "BaseWebVC.h"

@interface BaseWebVC ()

@end

@implementation BaseWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.webView loadHTMLString:self.content baseURL:[NSURL URLWithString:@"http://baidu.com"]];
    
    UIImage *image = [UIImage imageNamed:@"icon_25"];
    
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    //

    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 10, 16)];
    button.backgroundColor = [UIColor redColor];
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backTo) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *item= [[UIBarButtonItem alloc] initWithCustomView:button];
    //    UIBarButtonItem *item= [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_25"] style:UIBarButtonItemStylePlain target:self action:@selector(backTo)];
    self.navigationItem.leftBarButtonItem = item;
}
-(UIWebView *)webView{
    if(!_webView){
        _webView = [UIWebView new];
        [self.contentView addSubview:_webView];
        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
    }
    return _webView;
}

-(void)backTo{
    if([_webView canGoBack]){
        [_webView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
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
