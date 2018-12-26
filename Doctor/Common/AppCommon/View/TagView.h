//
//  TagView.h
//  CeshiDemo
//
//   Created by  licc on 2018/11/29.
//  Copyright © 2018年 CH. All rights reserved.
//标签云

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TagView : UIView
@property (strong, nonatomic) NSArray *tags;
@property (copy, nonatomic) void(^didClickBack)(NSInteger index,NSString *str);
@property (assign,nonatomic) CGFloat fitHeight;

-(UILabel *)viewWithIndex:(NSInteger)index;
-(void)selectIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
