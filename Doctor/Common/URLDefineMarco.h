//
//  URLMarco.h
//  Doctor
//
//  Created by zt on 2019/1/5.
//  Copyright © 2019 AnyOne. All rights reserved.
//

#ifndef URLDefineMarco_h
#define URLDefineMarco_h

#define URL_HOST @"http://www.goodly.com.cn/VichmsApi/api/"

//#define URL(api) [NSString stringWithFormat:@"%@%@", URL_HOST, api]

#define URL_Login @"user/login"
#define URL_AttenderPage @"order/attender/page"


#define URL_My @"order/page/Doctor/my"
#define URL_DepartmentPage @"department/page"//科室
//MARK:我的服务单
#define URL_GoodsTypes @"goods/goodsTypes"//服务类型
#define URL_Goods @"order/page/Doctor/my/goods"//服务单列表
#define URL_GetOrderEvaluationByOrderId @"orderEvaluation/getOrderEvaluationByOrderId"//查看评价
//MARK:个人设置
#define URL_Me @"user/me" //获取个人信息
#define URL_Save @"user/save"//保存个人信息
#define URL_Message_MY @"message/page/my" //消息通知
#define URL_Count @"doctor/orderEvaluation/count"//统计
#endif /* URLDefineMarco_h */
