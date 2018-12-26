

#import "BaseResultModel.h"
#import "CouponUseUsableResultSubModel.h"

@interface CouponUseUsableResultModel : BaseResultModel

//@property(assign, nonatomic) int    totalPages;        //1    (int)
//@property(assign, nonatomic) int    pageNo;        //1    (int)
//@property(strong, nonatomic) NSArray <CouponUseUsableResultSubModel *> *  list;        //listModel（）    (array)
//@property(assign, nonatomic) int    pageSize;        //10    (int)
//@property(assign, nonatomic) int    total;        //2    (int)
//@property(strong, nonatomic) NSString * sort;        //DESC_createDate    (string)


@property(strong, nonatomic) NSArray <CouponUseUsableResultSubModel *> *  data;        //listModel（）    (array)

@end
