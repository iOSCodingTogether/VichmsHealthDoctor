

#import "GoodsPageResultModel.h"

@implementation GoodsPageResultModel

+ (NSDictionary *)objectClassInArray{
    return @{
        @"list" : @"GoodsPageResultSubModel"
    };
}

-(NSArray <GoodsPageResultSubModel *> *)channelListModel:(BOOL)greenChanel{

    NSMutableArray *list = [NSMutableArray array];
    for(GoodsPageResultSubModel *subModel in self.list){
        if(subModel.greenChanel.integerValue == greenChanel){
            [list addObject:subModel];
        }
    }
    
    return list;
}
-(GoodsPageResultSubModel *)findBygoodsTypeName:(NSString *)typeName{

    for(GoodsPageResultSubModel *subModel in self.list){
        if([subModel.goodsTypeName isEqualToString:typeName]){
            return subModel;
        }
    }
    return nil;
}

@end
