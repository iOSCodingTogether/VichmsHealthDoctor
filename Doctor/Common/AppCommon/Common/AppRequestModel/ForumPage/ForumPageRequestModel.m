

#import "ForumPageRequestModel.h"

@implementation ForumPageRequestModel
-(instancetype)init{
    self = [super init];
    self.requestURL = action_forum_page;//action_forum_page
    self.serverMethod = YTServerMethodGet;
    self.resultDataClass = [ForumPageResultModel class];
    self.needLoginToken = YES;
    return self ;
}
@end
