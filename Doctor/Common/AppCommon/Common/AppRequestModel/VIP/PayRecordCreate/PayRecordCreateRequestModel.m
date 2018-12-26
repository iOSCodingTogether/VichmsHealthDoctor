

#import "PayRecordCreateRequestModel.h"

@implementation PayRecordCreateRequestModel
-(instancetype)init{
    self = [super init];
    self.requestURL = action_payRecord_create;
    self.serverMethod = YTServerMethodPost;
    self.resultDataClass = [PayRecordCreateResultModel class];
    self.needLoginToken = YES;
    return self ;
}
@end

