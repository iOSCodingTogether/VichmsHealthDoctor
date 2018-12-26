

#import "DoctorPageRequestModel.h"

@implementation DoctorPageRequestModel
-(instancetype)init{
    self = [super init];
    self.requestURL = action_doctor_page;
    self.serverMethod = YTServerMethodGet;
    self.resultDataClass = [DoctorPageResultModel class];
    self.needLoginToken = YES;
    return self ;
}
@end
