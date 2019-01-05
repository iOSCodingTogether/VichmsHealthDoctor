//
//  UITextView+MWPlaceholder.m
//  MyWardrobe
//
//  Created by zt on 2018/12/15.
//  Copyright © 2018 Simon Mr. All rights reserved.
//

#import "UITextView+MWPlaceholder.h"

@implementation UITextView (MWPlaceholder)

-(void)setPlaceholder:(NSString *)placeholdStr placeholdColor:(UIColor *)placeholdColor
{
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.text = placeholdStr;
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.textColor = placeholdColor;
    placeHolderLabel.font = self.font;
    [placeHolderLabel sizeToFit];
    
    /*
     [self setValue:(nullable id) forKey:(nonnull NSString *)]
     ps: KVC键值编码，对UITextView的私有属性进行修改
     */
    UILabel *placeholder = [self valueForKey:@"_placeholderLabel"];
    //防止重复
    if (placeholder) {
        return;
    }
    [self addSubview:placeHolderLabel];
    [self setValue:placeHolderLabel forKey:@"_placeholderLabel"];

}

@end
