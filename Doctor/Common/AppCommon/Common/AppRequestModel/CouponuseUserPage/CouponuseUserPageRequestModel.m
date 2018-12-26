

#import "CouponuseUserPageRequestModel.h"

@implementation CouponuseUserPageRequestModel
-(instancetype)init{
    self = [super init];
    self.requestURL = action_couponuse_user_page;////action_couponuse_user_page
    self.serverMethod = YTServerMethodGet;
    self.resultDataClass = [CouponuseUserPageResultModel class];
    self.needLoginToken = YES;
    return self ;
}
@end
