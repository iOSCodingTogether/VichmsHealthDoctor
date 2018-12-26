

#import "BaseRequestModel.h"
#import "OrderCreateResultModel.h"

@interface OrderCreateRequestModel : BaseRequestModel


@property (strong, nonatomic) NSString * orgOrder;    //是否企业订单
@property (strong, nonatomic) NSString *orgId;           //组织ID
@property (strong, nonatomic) NSString *relative;    //与患者关系，1：本人，2：家属，3：朋友，4：同事
@property (strong, nonatomic) NSString *orderType;   //订单类型，1：第一次就诊；2：复诊
@property (strong, nonatomic) NSString *personId;    //患者ID
@property (strong, nonatomic) NSString *personName;    //姓名
@property (strong, nonatomic) NSString *personSex;    //性别
@property (strong, nonatomic) NSString *personAge;    //年龄
@property (strong, nonatomic) NSString *personPhone;  //手机号
@property (strong, nonatomic) NSString *personIdCard; //身份证号码
@property (strong, nonatomic) NSString *sickDes;    //病情简介
@property (strong, nonatomic) NSString *DoctorId; //预约专家ID
@property (strong, nonatomic) NSString *Doctor; //预约专家
@property (strong, nonatomic) NSString *hospitalId;  //医院ID
@property (strong, nonatomic) NSString *hospital;  //医院
@property (strong, nonatomic) NSString *departmentId; //科室ID
@property (strong, nonatomic) NSString *department; //科室
@property (strong, nonatomic) NSString *sickPic; //病历图片
@property (strong, nonatomic) NSString *sickVedio; //病历视频
//@property (strong, nonatomic) NSString *  orderTime;  //下单时间
@property (strong, nonatomic) NSString *  visitTime;  //就诊时间
@property (strong, nonatomic) NSString *buyGoodsType;//购买服务类型
@property (strong, nonatomic) NSString *orderMoney;//

-(instancetype)initModel;


@end
