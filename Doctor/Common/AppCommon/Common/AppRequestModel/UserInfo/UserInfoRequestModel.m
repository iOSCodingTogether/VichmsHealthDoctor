

#import "UserInfoRequestModel.h"

@implementation UserInfoRequestModel
-(instancetype)init{
    self = [super init];
    self.requestURL = action_user_me;
    self.serverMethod = YTServerMethodGet;
    self.resultDataClass = [UserInfoResultModel class];
    self.needLoginToken = YES;
    return self ;
}
@end
