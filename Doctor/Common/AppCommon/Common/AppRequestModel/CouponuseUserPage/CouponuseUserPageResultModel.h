

#import "BaseResultModel.h"
#import "CouponuseUserPageResultListCouponModel.h"
#import "CouponuseUserPageResultListCouponUseModel.h"
@class CouponuseUserPageResultListModel;
@interface CouponuseUserPageResultModel : BaseResultModel
@property(strong, nonatomic) NSArray <CouponuseUserPageResultListModel *>* data;        //listModel（）    (array)



@end

@interface CouponuseUserPageResultListModel : NSObject

@property (nonatomic, strong) CouponuseUserPageResultListCouponModel * coupon;     //
@property (nonatomic, strong) CouponuseUserPageResultListCouponUseModel * couponUse;     //


@property (nonatomic, assign) BOOL isSelect;     //


@end
