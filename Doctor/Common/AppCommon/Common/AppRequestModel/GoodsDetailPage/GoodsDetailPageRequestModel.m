

#import "GoodsDetailPageRequestModel.h"

@implementation GoodsDetailPageRequestModel
-(instancetype)init{
    self = [super init];
    self.requestURL = action_goodsDetails_page;
    self.serverMethod = YTServerMethodGet;
    self.resultDataClass = [GoodsDetailPageResultModel class];
    self.needLoginToken = YES;
    return self ;
}
@end
