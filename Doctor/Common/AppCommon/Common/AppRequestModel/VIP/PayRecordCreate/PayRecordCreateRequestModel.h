

#import "BaseRequestModel.h"
#import "PayRecordCreateResultModel.h"

@interface PayRecordCreateRequestModel : BaseRequestModel
@property (strong, nonatomic) NSDictionary *payRecord;
@property (strong, nonatomic) NSArray *couponUseList;
@end
//{"payRecord":{"payMoney":123,"couponMoney":10,"paymentType":"支付宝","activePayMoney":113},
//    "couponUseList":[
//                     ​{"id":"03a9811d1a9546fe9c4a8c359bde3b29"},
//                     ​{"id":"0d7f0ca7d7fa415883c6e45d77e007cf"}]
//}
