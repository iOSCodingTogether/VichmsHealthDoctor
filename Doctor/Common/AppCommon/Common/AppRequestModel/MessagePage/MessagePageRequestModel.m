

#import "MessagePageRequestModel.h"

@implementation MessagePageRequestModel
-(instancetype)init{
    self = [super init];
    self.requestURL = action_message_page;//action_message_page
    self.serverMethod = YTServerMethodGet;
    self.resultDataClass = [MessagePageResultModel class];
    self.needLoginToken = YES;
    return self ;
}
@end
