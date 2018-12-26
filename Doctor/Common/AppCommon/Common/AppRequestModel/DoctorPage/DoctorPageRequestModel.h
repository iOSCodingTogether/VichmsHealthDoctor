

#import "BaseRequestModel.h"
#import "DoctorPageResultModel.h"

@interface DoctorPageRequestModel : BaseRequestModel
@property (nonatomic, strong) NSString * search_LIKE_name;     //
@property (nonatomic, strong) NSString * search_EQ_departmentId;//  科室

@property (nonatomic, strong) NSString * search_EQ_id;//省略findByid接口，使用搜索的结果

@end
