

#import "DepartmentFindByIdRequestModel.h"

@implementation DepartmentFindByIdRequestModel
-(instancetype)init{
    self = [super init];
    self.requestURL = action_dempartment_findById;
    self.serverMethod = YTServerMethodGet;
    self.resultDataClass = [DepartmentFindByIdResultModel class];
    self.needLoginToken = YES;
    return self ;
}
@end
