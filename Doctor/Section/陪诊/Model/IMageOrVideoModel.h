//
//  IMageOrVideoData.h
//  Suffer
//
//   Created by  licc on 2018/11/26.
//  Copyright © 2018年 AnyOne. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IMageOrVideoModel : NSObject
@property (strong, nonatomic) id image;//主体
@property (strong, nonatomic) NSString * imageURLKey;//s服务器地址对应
@property (strong, nonatomic) id imageOther;//其他可能需要的属性

-(NSMutableArray *)getImagesFromModelArray:(NSArray <IMageOrVideoModel *>*)modelArr;
@end

NS_ASSUME_NONNULL_END
