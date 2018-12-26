//
//  PageButtonView.h
//  XiangjianiOS
//
//  Created by  licc on 2018/8/12.
//  Copyright © 2018年 AnyOne. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PageButtonViewwDelegate<NSObject>

@optional

- (void)pageButtonViewDidselect:(NSInteger)index;

@end
@interface PageButtonView : UIView
-(void)setSubButtons:(NSArray *)titles;
-(void)scrollToPage:(CGFloat)page;
@property(nonatomic,weak) id<PageButtonViewwDelegate>        delegate;


@end
