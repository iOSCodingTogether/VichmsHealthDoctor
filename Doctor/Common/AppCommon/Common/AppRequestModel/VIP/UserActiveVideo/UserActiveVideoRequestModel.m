

#import "UserActiveVideoRequestModel.h"

@implementation UserActiveVideoRequestModel
-(instancetype)init{
    self = [super init];
    self.requestURL = action_user_activeVideo;
    self.serverMethod = YTServerMethodPost;
    self.resultDataClass = [UserActiveVideoResultModel class];
    self.needLoginToken = YES;
    return self ;
}
@end
