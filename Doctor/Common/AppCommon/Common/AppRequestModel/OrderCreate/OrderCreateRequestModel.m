

#import "OrderCreateRequestModel.h"

@implementation OrderCreateRequestModel
-(instancetype)init{
    self = [super init];
    self.requestURL = action_order_create;
    self.serverMethod = YTServerMethodPost;
    self.resultDataClass = [OrderCreateResultModel class];
    self.needLoginToken = YES;
    return self ;
}

-(instancetype)initModel{
    self = [self init];
    OrderCreateRequestModel *model = self;
    if(model){
        
        //        {"orderMoney":888,"orgOrder":"0",}HTTP/1.1 200 OK
        model.relative = @"1";//与患者关系，1：本人，2：家属，3：朋友，4：同事
        model.orderType =@"1";////订单类型，1：第一次就诊；2：复诊
        model.personSex =@"0";//女 男
        model.personAge = @"";////年龄
        model.personPhone = @"";////手机号
        model.personIdCard = @"";//身份证号码
        model.sickDes = @"";////病情简介
        model.visitTime = @"1988-01-18T20:26:40.419+0000";//1542400419
        model.sickPic = @"";
        model.sickVedio = @"";
        model.personName = @"";
        model.department =@"";//"中医科"
        model.departmentId = @"";////科室ID
        model.Doctor = @"";
        model.DoctorId = @"";
        model.hospital = @"";
        model.hospitalId = @"";
//        model.orderTime = @"1998-01-18T20:26:40.419+0000";
        model.orderMoney = @"6688";
        model.buyGoodsType = @"1004";
    }
    return self;
}

@end
