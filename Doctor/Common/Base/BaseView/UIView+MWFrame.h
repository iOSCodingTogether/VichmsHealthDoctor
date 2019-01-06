//
//  UIView+MWFrame.h
//  MyWardrobe
//
//  Created by Simon Mr on 2018/12/10.
//  Copyright © 2018 Simon Mr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MWFrame)

/** 大小 */
@property (nonatomic, assign) CGSize mw_size;
/** 左距 */
@property (nonatomic, assign) CGFloat mw_left;
/** 右距 */
@property (nonatomic, assign) CGFloat mw_right;
/** 上距 */
@property (nonatomic, assign) CGFloat mw_top;
/** 下距 */
@property (nonatomic, assign) CGFloat mw_bottom;
/** 中心X */
@property (nonatomic, assign) CGFloat mw_centerX;
/** 中心Y */
@property (nonatomic, assign) CGFloat mw_centerY;
/** 宽度 */
@property (nonatomic, assign) CGFloat mw_width;
/** 高度 */
@property (nonatomic, assign) CGFloat mw_height;
    
@end
