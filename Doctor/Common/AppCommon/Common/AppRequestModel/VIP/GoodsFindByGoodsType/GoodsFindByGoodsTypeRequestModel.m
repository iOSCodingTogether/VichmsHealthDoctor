

#import "GoodsFindByGoodsTypeRequestModel.h"

@implementation GoodsFindByGoodsTypeRequestModel
-(instancetype)init{
    self = [super init];
    self.requestURL = action_goods_findByGoodsType;
    self.serverMethod = YTServerMethodGet;
    self.resultDataClass = [GoodsFindByGoodsTypeResultModel class];
    self.needLoginToken = YES;
    return self ;
}
@end
