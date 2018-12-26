

#import "BaseResultModel.h"

@class ForumPosttypesResultModelModel;
@interface ForumPosttypesResultModel : BaseResultModel
@property(strong, nonatomic) NSArray <ForumPosttypesResultModelModel *>* data;        //listModel（）    (array)

@end
@interface ForumPosttypesResultModelModel : NSObject

@property (nonatomic, strong) NSString * typeCode;     //
@property (nonatomic, strong) NSString * typeName;     //
@property (nonatomic, strong) NSString * id;     //


@end
