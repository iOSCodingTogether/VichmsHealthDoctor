

#import "CouponUseUsableRequestModel.h"

@implementation CouponUseUsableRequestModel
-(instancetype)init{
    self = [super init];
    self.requestURL = action_couponUse_usable;
    self.serverMethod = YTServerMethodGet;
    self.resultDataClass = [CouponUseUsableResultModel class];
    self.needLoginToken = YES;
    return self ;
}
@end
