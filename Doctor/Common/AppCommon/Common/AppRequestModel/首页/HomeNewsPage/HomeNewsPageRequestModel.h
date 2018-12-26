

#import "BaseRequestModel.h"
#import "HomeNewsPageResultModel.h"

@interface HomeNewsPageRequestModel : BaseRequestModel
@property (nonatomic, assign) NSInteger pageNo;     //
@property (nonatomic, assign) NSInteger pageSize;     //
@property (nonatomic, strong) NSString * search_EQ_column;     //
@property (nonatomic, strong) NSString * sortInfo;     //DESC_createDate
//DESC_createDate:按创建时间降序，search_EQ_column=1，表明是查询column等于1，具体见翻页查询文档说明。
@end
