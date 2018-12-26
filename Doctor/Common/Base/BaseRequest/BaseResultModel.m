//
//  ResultBase.m
//  yuantong
//
//  Created by  licc on 2018/3/12.
//  Copyright © 2018年 boshtc. All rights reserved.
//

#import "BaseResultModel.h"

#import <MJExtension/MJExtension.h>

@implementation BaseResultModel

@synthesize description = _description;

-(BOOL)success{
    return [self.code integerValue] == 100;

}

+ (NSArray *)mj_ignoredPropertyNames{
    return @[@"success",@""];
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    NSArray *keys = [self keysArray];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for(NSString *key in  keys){
        if([@[@"data",@"code",@"msg",@"timestamp",@"status",@"error",@"message",@"path"] containsObject:key]){
//        for(NSString * parameter in @[@"data",@"code",@"msg",@"timestamp",@"status",@"error",@"message",@"path"]){
//            if([parameter isEqualToString:key]){
                continue;
            }
//        }
        [dic setObject:[NSString stringWithFormat:@"data.%@",key] forKey:key];

    }
    return dic;
}
+(NSArray *)keysArray{
    Class clazz = [BaseResultModel class];
    NSMutableArray *arr = [NSMutableArray array];
    NSArray *allowedPropertyNames = [clazz mj_totalAllowedPropertyNames];
    NSArray *ignoredPropertyNames = [clazz mj_totalIgnoredPropertyNames];
    [self mj_enumerateClasses:^(__unsafe_unretained Class c, BOOL *stop) {
        // 1.获得所有的成员变量
        unsigned int outCount = 0;
        objc_property_t *properties = class_copyPropertyList(c, &outCount);
        
        // 2.遍历每一个成员变量
        for (unsigned int i = 0; i<outCount; i++) {
            MJProperty *property = [MJProperty cachedPropertyWithProperty:properties[i]];
//             0.检测是否被忽略
            if (allowedPropertyNames.count && ![allowedPropertyNames containsObject:property.name]) continue;
            if ([ignoredPropertyNames containsObject:property.name]) continue;
            
            [arr addObject:property.name];
        }
        // 3.释放内存
        free(properties);
    }];
    return arr;
}


//+ (NSDictionary *)mj_replacedKeyFromPropertyName{
//    NSArray *keys = [self keysArray];
//    NSString * replaceKey = nil;
//
//    BOOL needReplace = NO;
//    for(NSString *key in  keys){
//        if([key hasPrefix:@"__replacedKey__"]){
//            needReplace = YES;
//            replaceKey = key;
//            break;
//        }
//    }
//    if(needReplace){
//        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//        NSString * replace = [replaceKey stringByReplacingOccurrencesOfString:@"__replacedKey__" withString:@""];
//        for(NSString *key in  keys){
//            for(NSString * parameter in @[replace,@"code",@"msg",@"timestamp",@"status",@"error",@"message",@"path"]){
//                if([parameter isEqualToString:key]){
//                    continue;
//                }
//            }
//            [dic setObject:[NSString stringWithFormat:@"%@.%@",replace,key] forKey:key];
//
//        }
//        return dic;
//    }
//    return nil;
//}
@end
