

#import "CouponuseUserPageResultModel.h"

@implementation CouponuseUserPageResultModel
+ (NSDictionary *)objectClassInArray{
    return @{
             @"data" : @"CouponuseUserPageResultListModel"
             };
}

@end


@implementation CouponuseUserPageResultListModel

+ (NSArray *)mj_ignoredPropertyNames{
    return @[@"isSelect",@""];
}

@end
