

#import "HomeNewsColumnRequestModel.h"

@implementation HomeNewsColumnRequestModel
-(instancetype)init{
    self = [super init];
    self.requestURL = action_news_column;
    self.serverMethod = YTServerMethodGet;
    self.resultDataClass = [HomeNewsColumnResultModel class];
    self.needLoginToken = YES;
    return self ;
}
@end
