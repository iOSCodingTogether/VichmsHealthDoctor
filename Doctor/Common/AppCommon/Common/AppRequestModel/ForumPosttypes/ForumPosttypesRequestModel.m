

#import "ForumPosttypesRequestModel.h"

@implementation ForumPosttypesRequestModel
-(instancetype)init{
    self = [super init];
    self.requestURL = action_forum_posttypes;////action_forum_posttypes
    self.serverMethod = YTServerMethodGet;
    self.resultDataClass = [ForumPosttypesResultModel class];
    self.needLoginToken = YES;
    return self ;
}
@end
