

#import "OrderPageMyRequestModel.h"

@implementation OrderPageMyRequestModel
-(instancetype)init{
    self = [super init];
    self.requestURL = action_order_page_my;//action_order_page_my
    self.serverMethod = YTServerMethodGet;
    self.resultDataClass = [OrderPageMyResultModel class];
    self.needLoginToken = YES;
    return self ;
}
-(NSString *)sortInfo{
    if(!_sortInfo){

        _sortInfo = @"DESC_createDate";
        
    }
    return _sortInfo;
}
@end
