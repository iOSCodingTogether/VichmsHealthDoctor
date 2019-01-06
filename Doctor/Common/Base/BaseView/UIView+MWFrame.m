//
//  UIView+MWFrame.m
//  MyWardrobe
//
//  Created by Simon Mr on 2018/12/10.
//  Copyright © 2018 Simon Mr. All rights reserved.
//

#import "UIView+MWFrame.h"

@implementation UIView (MWFrame)
    
- (void)setMw_size:(CGSize)mw_size {
    CGPoint origin = [self frame].origin;
    [self setFrame:CGRectMake(origin.x, origin.y, mw_size.width, mw_size.height)];
}
    
- (CGSize)mw_size {
    return [self frame].size;
}
    
- (CGFloat)mw_left {
    return CGRectGetMinX([self frame]);
}
    
- (void)setMw_left:(CGFloat)x {
    CGRect frame = [self frame];
    frame.origin.x = x;
    [self setFrame:frame];
}
    
- (CGFloat)mw_top {
    return CGRectGetMinY([self frame]);
}
    
- (void)setMw_top:(CGFloat)y {
    CGRect frame = [self frame];
    frame.origin.y = y;
    [self setFrame:frame];
}
    
- (CGFloat)mw_right {
    return CGRectGetMaxX([self frame]);
}
    
- (void)setMw_right:(CGFloat)right {
    
    CGRect frame = [self frame];
    frame.origin.x = right - frame.size.width;
    [self setFrame:frame];
}
    
- (CGFloat)mw_bottom {
    return CGRectGetMaxY([self frame]);
}
    
- (void)setMw_bottom:(CGFloat)bottom {
    
    CGRect frame = [self frame];
    frame.origin.y = bottom - frame.size.height;
    [self setFrame:frame];
}
    
- (CGFloat)mw_centerX {
    return [self center].x;
}
    
- (void)setMw_centerX:(CGFloat)centerX {
    [self setCenter:CGPointMake(centerX, self.center.y)];
}
    
- (CGFloat)mw_centerY {
    return [self center].y;
}
    
- (void)setMw_centerY:(CGFloat)centerY {
    [self setCenter:CGPointMake(self.center.x, centerY)];
}
    
- (CGFloat)mw_width {
    return CGRectGetWidth([self frame]);
}
    
- (void)setMw_width:(CGFloat)width {
    
    CGRect frame = [self frame];
    frame.size.width = width;
    [self setFrame:CGRectStandardize(frame)];
}
    
- (CGFloat)mw_height {
    return CGRectGetHeight([self frame]);
}
    
- (void)setMw_height:(CGFloat)height {
    
    CGRect frame = [self frame];
    frame.size.height = height;
    [self setFrame:CGRectStandardize(frame)];
}

@end
