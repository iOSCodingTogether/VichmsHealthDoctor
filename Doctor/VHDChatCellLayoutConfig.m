//
//  VHDChatCellLayoutConfig.m
//  Doctor
//
//  Created by zt on 2019/1/25.
//  Copyright © 2019 AnyOne. All rights reserved.
//

#import "VHDChatCellLayoutConfig.h"

#import <NIMKit.h>

@interface VHDChatCellLayoutConfig()

@property (nonatomic,strong)    NSArray *types;

@end

@implementation VHDChatCellLayoutConfig

- (BOOL)shouldShowNickName:(NIMMessageModel *)model{
    if ([self isSupportedTeamMessage:model.message]) {
        return YES;
    }
    
    return [super shouldShowNickName:model];
}

- (BOOL)isSupportedTeamMessage:(NIMMessage *)message {
    return message.session.sessionType == NIMSessionTypeTeam
    && (message.messageType == NIMMessageTypeText
        || message.messageType == NIMMessageTypeRobot
        || [self isSupportedCustomMessage:message]);
}

- (BOOL)isSupportedCustomMessage:(NIMMessage *)message {
    NIMCustomObject *object = message.messageObject;
    return [object isKindOfClass:[NIMCustomObject class]]
    && [_types indexOfObject:NSStringFromClass([object.attachment class])] != NSNotFound;
}
@end
