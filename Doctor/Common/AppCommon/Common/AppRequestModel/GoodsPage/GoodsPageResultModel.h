

#import "BaseResultModel.h"
#import "GoodsPageResultSubModel.h"

@interface GoodsPageResultModel : BaseResultModel

@property(assign, nonatomic) int    totalPages;        //1    (int)
@property(assign, nonatomic) int    pageNo;        //1    (int)
@property(strong, nonatomic) NSArray <GoodsPageResultSubModel *> *list;        //listModel（）    (array)
@property(assign, nonatomic) int    pageSize;        //10    (int)
@property(assign, nonatomic) int    total;        //2    (int)
@property(strong, nonatomic) NSString * sort;        //DESC_createDate    (string)
-(NSArray <GoodsPageResultSubModel *> *)channelListModel:(BOOL)greenChanel;

-(GoodsPageResultSubModel *)findBygoodsTypeName:(NSString *)typeName;
@end
