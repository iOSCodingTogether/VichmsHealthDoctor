//
//  UITextView+MWPlaceholder.h
//  MyWardrobe
//
//  Created by zt on 2018/12/15.
//  Copyright © 2018 Simon Mr. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (MWPlaceholder)

-(void)setPlaceholder:(NSString *)placeholdStr placeholdColor:(UIColor *)placeholdColor;
@end

NS_ASSUME_NONNULL_END
