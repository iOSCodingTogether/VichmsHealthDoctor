

#import "BaseResultModel.h"
#import "OrderPageMyResultSubModel.h"

@interface OrderPageMyResultModel : BaseResultModel

@property(assign, nonatomic) int    totalPages;        //1    (int)
@property(assign, nonatomic) int    pageNo;        //1    (int)
@property(strong, nonatomic) NSArray <OrderPageMyResultSubModel *> *list;        //listModel（）    (array)
@property(assign, nonatomic) int    pageSize;        //10    (int)
@property(assign, nonatomic) int    total;        //2    (int)
@property(strong, nonatomic) NSString * sort;        //DESC_createDate    (string)

@end
