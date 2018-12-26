

#import "HomeNewsPageRequestModel.h"

@implementation HomeNewsPageRequestModel
-(instancetype)init{
    self = [super init];
    self.requestURL = action_news_page;
    self.serverMethod = YTServerMethodGet;
    self.resultDataClass = [HomeNewsPageResultModel class];
    self.needLoginToken = YES;
    return self ;
}
@end
