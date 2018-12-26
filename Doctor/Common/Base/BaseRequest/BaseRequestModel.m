//
//  RequestBase.m
//  yuantong
//
//  Created by  licc on 2018/3/12.
//  Copyright © 2018年 boshtc. All rights reserved.
//

#import "BaseRequestModel.h"

@implementation BaseRequestModel

-(Class)resultDataClass{
    if(_resultDataClass == nil){
        _resultDataClass = [BaseResultModel class];
    }
    return _resultDataClass;
}
+ (NSArray *)mj_ignoredPropertyNames{//类型转换忽略
    return @[@"serverMethod",@"requestURL",@"resultDataClass" ,@"needLoginToken"];
}

-(NSInteger)nextPageNoForCurDataCount:(NSInteger)count{
    int pageSize = 0 ;
    if(self.pageSize ==0){
        pageSize =10;
    }else{
        pageSize = self.pageSize;
    }
    NSInteger nextPageNo = count/pageSize+2;
    return nextPageNo;
}

@end
