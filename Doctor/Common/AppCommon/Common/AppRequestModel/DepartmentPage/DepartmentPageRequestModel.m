

#import "DepartmentPageRequestModel.h"

@implementation DepartmentPageRequestModel
-(instancetype)init{
    self = [super init];
    self.requestURL = action_dempartment_page;
    self.serverMethod = YTServerMethodGet;
    self.resultDataClass = [DepartmentPageResultModel class];
    self.needLoginToken = YES;
    return self ;
}
@end
