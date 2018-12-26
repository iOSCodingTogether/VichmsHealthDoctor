//
//  JAVATESPOND.m
//  VichmsHealthDoctor
//   Created by  licc on 2018/10/16.
//  Copyright © 2018年 AnyOne. All rights reserved.
//

#import "JAVATESPOND.h"

@implementation JAVATESPOND
//1CourseItemRespond
//    {
//        "modify": "8a8ab0b246dc81120146dc8181950052",
//            "modifyDept": "8a8ab0b246dc81120146dc8180ba0017",
//            "createDept": "8a8ab0b246dc81120146dc8180ba0017",
//            "modifyDate": "2018-09-06T03:41:45.000+0000",
//            "create": "管理员",
//            "id": "297ea9bb65acd1650165aced9da40030",
//            "department": "肿瘤科",
//            "departmentDes": "肿瘤科和内科、外科、妇产科和儿科一样，是临床医学的二级学科，分为肿瘤内科、肿瘤放射治疗科和肿瘤外科等，肿瘤内科主要从事各种良、恶性肿瘤的内科治疗;肿瘤放射治疗科主要从事肿瘤的放射线治疗;肿瘤外科提供以手术为主的综合治疗。专门的肿瘤医院的相关科室会根据不同部位再行细分，例如肿瘤内科里的胃肠肿瘤科、淋巴瘤肿瘤科;肿瘤外科有乳腺外科、头颈外科、胸外科、肿瘤妇科、腹部外科等。",
//            "createDate": "2018-09-06T03:29:38.000+0000"
//    },


//2//DoctorInfoRespond

/**
 * departmentId : 402881e665ae0da30165ae1dbe130019
 * recommend :
 * source : 祥健
 * speciality :
 * qrCode :
 * hospitalId : 297ea9bb65acd1650165ace2902e0013
 * create : 管理员
 * id : 402881e665ae0da30165ae1e2e7e001b
 * department : 中医科
 * serviceId :
 * introduction : 承担研究课题《常用抗精神病药物疗效及对血糖、血脂、体重和内分泌的影响》、《抑郁症中医证候学研究》、《老年期抑郁症的对照研究》、《精神分裂症失眠中药的动物实验研究》、《中药治疗精神分裂症、焦虑症多中心临床试验工作》、《精神分裂症治疗效果与结局的评估研究》等。
 发表著作《精神分裂症失眠的特点及中药治疗临床观察》、《中药治疗精神分裂症失眠临床观察》、《利培酮在首发精神分裂症不同中医辨证分型的疗效观察》等。
 * createDate : 2018-09-06T09:02:18.000+0000
 * sex : 1
 * hospitalName : 北京协和医院
 * serviceName :
 * headPic : TIM图片20180908131446_1536384588427.png
 * yxToken :
 * createDept : 8a8ab0b246dc81120146dc8180ba0017
 * name : 曹欣冬
 * duty :
 */


//3DoctorItemRespond
//    {
//        "id":"402881e665ae0da30165ae1e2e7e001b",
//            "createDate":"2018-09-06T09:02:18.000+0000",
//            "createDept":"8a8ab0b246dc81120146dc8180ba0017",
//            "create":"管理员",
//            "createId":null,
//            "modifyDate":null,
//            "modify":null,
//            "modifyId":null,
//            "modifyDept":null,
//            "headPic":"TIM图片20180908131446_1536384588427.png",
//            "name":"曹欣冬",
//            "sex":"1",
//            "hospitalName":"北京协和医院",
//            "hospitalId":"297ea9bb65acd1650165ace2902e0013",
//            "department":"中医科",
//            "departmentId":"402881e665ae0da30165ae1dbe130019",
//            "duty":"",
//            "speciality":"",
//            "introduction":"承担研究课题《常用抗精神病药物疗效及对血糖、血脂、体重和内分泌的影响》、《抑郁症中医证候学研究》、《老年期抑郁症的对照研究》、《精神分裂症失眠中药的动物实验研究》、《中药治疗精神分裂症、焦虑症多中心临床试验工作》、《精神分裂症治疗效果与结局的评估研究》等。\r\n    发表著作《精神分裂症失眠的特点及中药治疗临床观察》、《中药治疗精神分裂症失眠临床观察》、《利培酮在首发精神分裂症不同中医辨证分型的疗效观察》等。",
//            "servePerson":null,
//            "keepPerson":null,
//            "satisficing":null,
//            "qrCode":"",
//            "recommend":"",
//            "serviceName":"",
//            "serviceId":"",
//            "yxToken":"",
//            "videoPrice":null,
//            "source":"祥健"
//    }

//4FlexibleInfoItemRespond
//private String id;
//private String goodsInfoId;  //服务类型ID
//private String goodsDetailsType;    //服务内容类型  1服务内容 2预约须知3服务评价
//private String goodsDes;    //服务描述

//5GoodsItemRespond
//private String id;
//private String goodsType;
//private String feeType; //收费方式 1按年/收费 2按次数收费
//private BigDecimal fee;//价格（元）
//private String greenChanel; //是否绿色通道
//private String picture;
//private String logoPicture;



//QiniuKeyRespond
//private String accessKey;
//private String secretKey;






//public interface ApplyApi {
//    //获取内容信息列表
//    @GET("apply/page?search_EQ_column=1&sortInfo=DESC_createDate")
//    Call<RootRespond<List<ApplyItemRespond>>> getApplyList(@Query("pageNO") Integer pageIndex, @Query("pageSize") Integer pageSize);
//}

//
//public interface CommentApi {
//
//    @GET("comment/page?sortInfo=DESC_createDate")
//    Call<RootRespond> getList(@Query("pageNO") Integer pageIndex, @Query("pageSize") Integer pageSize);
//
//}
//
//
//public interface CouponUseApi {
//
//    @GET("couponUse/usable?sortInfo=DESC_createDate")
//    Call<RootRespond> getList(@Query("pageNO") Integer pageIndex, @Query("pageSize") Integer pageSize);
//}
//
//public interface DepartmentApi {
//
//    @GET("dempartment/findById")
//    Call<RootRespond> getInfo(@Query("id") String id);
//
//
//    @GET("dempartment/page?sortInfo=DESC_createDate")
//    Call<RootRespond<PageRootRespond<CourseItemRespond>>> getList(@Query("pageNO") Integer pageIndex, @Query("pageSize") Integer pageSize);
//
//
//
//}
//
//public interface DoctorApi {
//
//@GET("doctor/findById")
//Call<RootRespond<DoctorInfoRespond>> getInfo(@Query("id") String id);
//
//
//@GET("doctor/page")
//Call<RootRespond<PageRootRespond<DoctorItemRespond>>> getList( @Query("pageNO") Integer pageIndex, @Query("pageSize") Integer pageSize, @Query("search_EQ_departmentId") String departmentId);
//
//
//}
//
//
//public interface ForumApi {
//
//    //获取内容信息列表
//    @GET("forum/type/page?search_EQ_column=1&sortInfo=DESC_createDate")
//    Call<RootRespond<List<ForumTypeRespond>>> getForumTypeList();
//
//    //获取内容信息列表
//    @GET("forum/page?search_EQ_column=1&sortInfo=DESC_createDate")
//    Call<RootRespond<List<ForumItemRespond>>> getForumList(@Query("pageNO") Integer pageIndex, @Query("pageSize") Integer pageSize);
//
//
//    @GET("forum/page?sortInfo=DESC_createDate")
//    Call<RootRespond> getList(@Query("pageNO") Integer pageIndex, @Query("pageSize") Integer pageSize);
//
//
//}
//
//
//public interface GoodsApi {
//
//    //    @GET("goods/findByGoodsType")
//    //    Call<RootRespond> getInfo(@Query("type") String type);
//
//
//    @GET("goods/page?sortInfo=DESC_createDate")//greenChanel是否绿通
//    Call<RootRespond<PageRootRespond<GoodsItemRespond>>> getList(@Query("search_EQ_greenChanel") String greenChanel, @Query("pageNO") Integer pageIndex, @Query("pageSize") Integer pageSize);
//}
//
//public interface GoodsDetailsApi {
//
//    @GET("goodsDetails/column?sortInfo=DESC_createDate")
//    Call<RootRespond<PageRootRespond<FlexibleInfoItemRespond>>> getColumn(@Query("pageNO") Integer pageIndex, @Query("pageSize") Integer pageSize);
//}
//
//public interface NewsApi {
//
//    @GET("news/column")
//    Call<RootRespond<List<HomeTagItemRespond>>> getHomeTagList();
//    //
//    //获取内容信息列表
//    @GET("news/page?sortInfo=DESC_createDate")
//    Call<RootRespond<PageRootRespond<HomeNewsItemRespond>>> getHomeNewsList(@Query("search_EQ_column") String typeCode , @Query("pageNO") Integer pageIndex, @Query("pageSize") Integer pageSize);
//}
//
//public interface OrderApi {
//
//
//    @GET("order/findById")
//    Call<RootRespond> getInfo(@Query("id") String id);
//
//    @GET("order/page/my?sortInfo=DESC_createDate")
//    Call<RootRespond<PageRootRespond<AppointItemRespond>>> getList(@Query("pageNO") Integer pageIndex, @Query("pageSize") Integer pageSize);
//
//    @POST("order/create")
//    Call<RootRespond> create(@Body RequestBody json);
//
//
//}
//
//public interface OrderEvaluationApi {
//
//    @GET("orderEvaluationEvaluation/page?sortInfo=DESC_createDate")
//    Call<RootRespond> getList(@Query("pageNO") Integer pageIndex, @Query("pageSize") Integer pageSize);
//
//
//    @GET("orderEvaluationEvaluation/doctorTab")
//    Call<RootRespond> getMap(@Query("doctorId") String doctorId);
//}
//
//public interface PayRecordApi {
//
//    @POST("payRecord/create")
//    Call<RootRespond> create(@Body RequestBody json);
//}
//
//
//public interface QiniuApi {
//
//    @GET("qiniu/getKey")
//    Call<RootRespond<QiniuKeyRespond>> getKey();
//
//}
//
//
//public interface UserApi {
//
//    @GET("user/smsCode")
//    Call<RootRespond> sendSmsCode(@Query("personType") String personType, @Query("phone") String mobile);
//
//    @POST("user/login")
//    Call<RootRespond<LoginRespond>> userLogin(@Body RequestBody json);
//
//
//    @GET("user/me")
//    Call<RootRespond> getUserInfo();
//
//    @POST("user/openVideo")
//    Call<RootRespond> openVideo();
//
//
//    @POST("user/activeVideo")
//    Call<RootRespond> activeVideo();
//
//    @GET("user/page/my?sortInfo=DESC_createDate")
//    Call<RootRespond> getList(@Query("pageNO") Integer pageIndex, @Query("pageSize") Integer pageSize);
//
//
//    @GET("user/myCorpAdminPhone")//获取我的企业管理员电话
//    Call<RootRespond> getUserPhone();
//}

@end
