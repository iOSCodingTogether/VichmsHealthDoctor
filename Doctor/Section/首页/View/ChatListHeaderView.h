//
//  ChatListHeaderView.h
//  Doctor
//
//  Created by zt on 2019/1/6.
//  Copyright © 2019 AnyOne. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NTESListHeaderType) {
    ListHeaderTypeCommonText = 1,
    ListHeaderTypeNetStauts,
    ListHeaderTypeLoginClients,
};

@protocol NTESListHeaderView <NSObject>

@required
- (void)setContentText:(NSString *)content;

@end

@protocol NTESListHeaderDelegate <NSObject>

@optional

- (void)didSelectRowType:(NTESListHeaderType)type;

@end

@interface ChatListHeaderView : UIView

@property (nonatomic,weak) id<NTESListHeaderDelegate> delegate;

- (void)refreshWithCommonText:(NSString *)text;

@end
