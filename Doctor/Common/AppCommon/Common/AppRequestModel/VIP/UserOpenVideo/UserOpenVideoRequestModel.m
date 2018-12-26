

#import "UserOpenVideoRequestModel.h"

@implementation UserOpenVideoRequestModel
-(instancetype)init{
    self = [super init];
    self.requestURL = action_user_openVideo;
    self.serverMethod = YTServerMethodPost;
    self.resultDataClass = [UserOpenVideoResultModel class];
    self.needLoginToken = YES;
    return self ;
}
@end
