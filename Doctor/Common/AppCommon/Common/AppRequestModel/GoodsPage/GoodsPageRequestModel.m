

#import "GoodsPageRequestModel.h"

@implementation GoodsPageRequestModel
-(instancetype)init{
    self = [super init];
    self.requestURL = action_goods_page;
    self.serverMethod = YTServerMethodGet;
    self.resultDataClass = [GoodsPageResultModel class];
    self.needLoginToken = YES;
    return self ;
}
@end
