

#import "BaseRequestModel.h"
#import "GoodsFindByGoodsTypeResultModel.h"

@interface GoodsFindByGoodsTypeRequestModel : BaseRequestModel
@property (nonatomic, strong) NSString * type;     //视频医生（1）

@end
//requestModel.type = @"视频医生";//视频医生=1

