//
//  IMageOrVideoData.m
//  Suffer
//
//   Created by  licc on 2018/11/26.
//  Copyright © 2018年 AnyOne. All rights reserved.
//

#import "IMageOrVideoModel.h"

@implementation IMageOrVideoModel
-(NSMutableArray *)getImagesFromModelArray:(NSArray <IMageOrVideoModel *>*)modelArr{
    NSMutableArray *arr = [NSMutableArray arrayWithArray:[modelArr valueForKeyPath:@"image"]];
    return arr;
}

@end
