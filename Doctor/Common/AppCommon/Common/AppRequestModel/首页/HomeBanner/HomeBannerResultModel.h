//
//  HomeBannerResultModel.h
//  VichmsHealthDoctor
//  Created by  licc on 2018/9/8.
//  Copyright © 2018年 AnyOne. All rights reserved.
//

#import "BaseResultModel.h"
#import "HomeBannerResultSubModel.h"


@interface HomeBannerResultModel : BaseResultModel

@property(assign, nonatomic) int    totalPages;        //1    (int)
@property(assign, nonatomic) int    pageNo;        //1    (int)
@property(strong, nonatomic) NSArray <HomeBannerResultSubModel *>* list;        //listModel（）    (array)
@property(assign, nonatomic) int    pageSize;        //10    (int)
@property(assign, nonatomic) int    total;        //2    (int)
@property(strong, nonatomic) NSString * sort;        //ASC_sn //DESC_createDate    (string)

@end
