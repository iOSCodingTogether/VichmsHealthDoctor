

#import "BaseRequestModel.h"
#import "OrderPageMyResultModel.h"

@interface OrderPageMyRequestModel : BaseRequestModel
@property (nonatomic, strong) NSString * sortInfo;     //DESC_createDate
@property (nonatomic, strong) NSString * search_EQ_orderStatus;     //5

@property (nonatomic, strong) NSString * search_EQ_buyGoodsType;     //5

//sortInfo=DESC_createDate&search_EQ_orderStatus=5&pageNO=1&pageSize=10 HTTP/1.1
@end
