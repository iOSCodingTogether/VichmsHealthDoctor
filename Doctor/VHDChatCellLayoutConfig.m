//
//  VHDChatCellLayoutConfig.m
//  Doctor
//
//  Created by zt on 2019/1/25.
//  Copyright © 2019 AnyOne. All rights reserved.
//

#import "VHDChatCellLayoutConfig.h"

#import <NIMKit.h>

@implementation VHDChatCellLayoutConfig

- (BOOL)shouldShowNickName:(NIMMessageModel *)model {
    return YES;
}

@end
