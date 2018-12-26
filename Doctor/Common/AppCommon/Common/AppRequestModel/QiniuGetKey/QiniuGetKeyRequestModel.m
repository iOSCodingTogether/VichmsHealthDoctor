

#import "QiniuGetKeyRequestModel.h"

@implementation QiniuGetKeyRequestModel
-(instancetype)init{
    self = [super init];
    self.requestURL = action_qiniu_getKey;
    self.serverMethod = YTServerMethodGet;
    self.resultDataClass = [QiniuGetKeyResultModel class];
    self.needLoginToken = YES;
    return self ;
}
@end
