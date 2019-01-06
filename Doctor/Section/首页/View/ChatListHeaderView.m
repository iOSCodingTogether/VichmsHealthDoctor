//
//  ChatListHeaderView.m
//  Doctor
//
//  Created by zt on 2019/1/6.
//  Copyright © 2019 AnyOne. All rights reserved.
//

#import "ChatListHeaderView.h"
#import "UIView+MWFrame.h"

@implementation ChatListHeaderView

- (CGSize)sizeThatFits:(CGSize)size{
    CGFloat height = 0;
    for (UIView *subView in self.subviews) {
        [subView sizeToFit];
        height += subView.mw_height;
    }
    return CGSizeMake(self.mw_width, height);
}


- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat top = 0;
    for (UIView *subView in self.subviews) {
        subView.mw_top = top;
        top = top + subView.mw_height;
        subView.mw_centerX = self.mw_width * .5f;
    }
}


#pragma mark - Private
- (void)refreshWithCommonText:(NSString *)text {
    [self addRow:ListHeaderTypeCommonText content:text viewClassName:@"NTESTextHeaderView"];
}

//参数viewClassName的Class 必须是UIControl的子类并实现<NTESSessionListHeaderView>协议
- (void)addRow:(NTESListHeaderType)type content:(NSString *)content viewClassName:(NSString *)viewClassName{
    UIControl<NTESListHeaderView> *rowView = (UIControl<NTESListHeaderView> *)[self viewWithTag:type];
    if ([content length]) {
        if (!rowView) {
            Class clazz = NSClassFromString(viewClassName);
            rowView = [[clazz alloc] initWithFrame:CGRectMake(0, 0, self.mw_width, 0)];
            rowView.backgroundColor = [self fillBackgroundColor:type];
            __block NSInteger insert = self.subviews.count;
            [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                UIView *view = obj;
                if (view.tag > type) {
                    insert = idx;
                    *stop = YES;
                }
            }];
            rowView.tag = type;
            [self insertSubview:rowView atIndex:insert];
            [rowView addTarget:self action:@selector(didSelectRow:) forControlEvents:UIControlEventTouchUpInside];
        }
        [rowView setContentText:content];
    } else {
        [rowView removeFromSuperview];
    }
}


- (void)didSelectRow:(id)sender{
    UIControl *view = sender;
    if ([self.delegate respondsToSelector:@selector(didSelectRowType:)]) {
        [self.delegate didSelectRowType:view.tag];
    }
}


- (UIColor *)fillBackgroundColor:(NTESListHeaderType)type{
    NSDictionary *dict = @{
                           @(ListHeaderTypeNetStauts)    : [UIColor yellowColor],
                           @(ListHeaderTypeCommonText)   : [UIColor blackColor],
                           @(ListHeaderTypeLoginClients) : [UIColor blackColor]
                           };
    return dict[@(type)];
}

@end
