//
//  HomeBannerRequstModel.m
//  VichmsHealthDoctor
//  Created by  licc on 2018/9/8.
//  Copyright © 2018年 AnyOne. All rights reserved.
//

#import "HomeBannerRequstModel.h"

@implementation HomeBannerRequstModel
-(instancetype)init{
    self = [super init];
    self.requestURL = action_banner_page;
    self.serverMethod = YTServerMethodGet;
    self.resultDataClass = [HomeBannerResultModel class];
    self.needLoginToken = YES;
    return self ;
}
@end
