//
//  HomeNewsPageResultSubModel.h
//  VichmsHealthDoctor
//  Created by  licc on 2018/9/9.
//  Copyright © 2018年 AnyOne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDate+CCategory.h"

@interface HomeNewsPageResultSubModel : NSObject

//    //listModel

@property(strong, nonatomic) NSString * modify;        //null    (string)
@property(strong, nonatomic) NSString * column;        //1    (string)
@property(strong, nonatomic) NSString * modifyDate;        //null    (string)
@property(strong, nonatomic) NSString * modifyDept;        //null    (string)
@property(strong, nonatomic) NSString * title;        //优惠券大放送！优惠券大放送    (string)
@property(strong, nonatomic) NSString * status;        //1    (string)
@property(strong, nonatomic) NSString * picture;        //http://peh1bw5l8.bkt.clouddn.com/20180906095357764.jpg    (string)
@property(strong, nonatomic) NSString * create;        //管理员    (string)
@property(strong, nonatomic) NSString * endDate;        //2018-09-18T16:00:00.000+0000    (string)
@property(strong, nonatomic) NSString * id;        //402881e665ac7b7a0165ac9604c50015    (string)
@property(strong, nonatomic) NSString * date;        //2018-09-05T16:00:00.000+0000    (string)
@property(assign, nonatomic) int          pageViews;        //2    (int)
@property(strong, nonatomic) NSString * createId;        //null    (string)
@property(strong, nonatomic) NSString * writer;        //    (string)
@property(strong, nonatomic) NSString * modifyId;        //null    (string)
@property(strong, nonatomic) NSString * createDate;        //2018-09-06T01:53:57.000+0000    (string)
@property(strong, nonatomic) NSString * createDept;        //8a8ab0b246dc81120146dc8180ba0017    (string)
@property(strong, nonatomic) NSString * diseaseType;        //1    (string)
@property(assign, nonatomic) int          collects;        //2    (int)
@property(strong, nonatomic) NSString * content;        ///请在2018.9.19号之前领取<span id="_baidu_bookmark_start_1" style="line-height: 0px; display: none;">‍</span>   (string)


@property(strong, nonatomic,readonly) NSString * endTimeTranslate;        //2018-09-18T16:00:00.000+0000    (string)

@end
