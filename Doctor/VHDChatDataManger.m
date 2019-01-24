//
//  VHDChatDataManger.m
//  Doctor
//
//  Created by zt on 2019/1/25.
//  Copyright © 2019 AnyOne. All rights reserved.
//

#import "VHDChatDataManger.h"

@interface VHDChatDataManger () <NIMUserManagerDelegate, NIMTeamManagerDelegate>

@end

@implementation VHDChatDataManger

+ (instancetype)sharedInstance{
    static VHDChatDataManger *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[VHDChatDataManger alloc] init];
    });
    return instance;
}

@end
