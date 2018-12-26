//
//  RequestHostManage.h
//  VichmsHealthDoctor
//  Created by  licc on 2018/9/4.
//  Copyright © 2018年 AnyOne. All rights reserved.
//
//接口api管理类

#import <Foundation/Foundation.h>
//服务器地址前缀
extern NSString* appHOST;

#define CombileUrl(url) [NSString stringWithFormat:@"%@%@",appHOST,url]

//发送验证码
#define action_user_smsCode CombileUrl(@"/user/smsCode")


//用户登录
#define action_user_login CombileUrl(@"/user/login")
//action=/user/login


//5 用户信息
//action=
#define action_user_me CombileUrl(@"/user/me")
//
//1（首页-已登录）首页banner轮播：下图位置1
#define action_banner_page  CombileUrl(@"/banner/page")
//
//
//2（首页-已登录）首页栏目：下图位置2
//action= /news/column
#define action_news_column CombileUrl(@"/news/column")
//
//3（首页-已登录）首页资讯信息：TNewsInfo下图位置3
//action= /news/page，
#define action_news_page CombileUrl(@"/news/page")

//4（个人购买vip会员）判断是否是vip会员：
//api，不需要，用户登录之后已返回了用户的基本信息
//
//5 （开通视频医生vip）个人开通视频医生：
//action=/goods/findByGoodsType
#define action_goods_findByGoodsType CombileUrl(@"/goods/findByGoodsType")

//
//6（开通视频医生vip）个人账户余额：
//TPersonBaseInfo
//
//7（开通视频医生vip）个人账户优惠券
//TCouponUse
#define action_couponUse_usable CombileUrl(@"/couponUse/usable")

#define action_couponuse_user_page CombileUrl(@"/couponUse/user/page")

//
//8（开通视频医生vip）购买成功
//action=/payRecord/create
#define action_payRecord_create CombileUrl(@"/payRecord/create")


//
//9（开通提示）开通视频医生
//action=/user/openVideo
#define action_user_openVideo CombileUrl(@"/user/openVideo")

//
//10（首页-已登录）激活视频医生：下图箭头位置
//
#define action_user_activeVideo CombileUrl(@"/user/activeVideo")


//12（产品信息-客户方案）根据不同产品获取服务内容类型
//action= /goodsDetails/page?查询参数 search_EQ_goodsInfoId=服务ID
#define action_goodsDetails_page CombileUrl(@"/goodsDetails/page")


//xx 科室
//@GET("dempartment/findById")
#define action_dempartment_findById CombileUrl(@"/department/findById")

//@GET("dempartment/page?sortInfo=DESC_createDate")
#define action_dempartment_page CombileUrl(@"/department/page")


#define action_goods_page CombileUrl(@"/goods/page")

#define action_doctor_page CombileUrl(@"/doctor/page")
#define action_doctor_findById CombileUrl(@"/doctor/findById")

//14 （提交服务订单）生成普通服务订单信息
#define action_order_create CombileUrl(@"/order/create")//post
#define action_order_page_my CombileUrl(@"/order/page/my")//post
#define action_order_findbyid CombileUrl(@"/order/findById")//post

//消息列表
#define action_message_page CombileUrl(@"/message/page")

//好友动态 分类
#define action_forum_posttypes CombileUrl(@"/forum/postTypes")
#define action_forum_page CombileUrl(@"/forum/page")


#define action_qiniu_getKey CombileUrl(@"/qiniu/getKey")//get


@interface RequestHostManage : NSObject

+ (instancetype)shareInstance;

@end
