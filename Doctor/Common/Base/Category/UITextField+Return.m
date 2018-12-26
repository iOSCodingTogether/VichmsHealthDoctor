//
//  UITextField+Return.m
//  HomeKitNew
//
//   Created by  licc on 2018/9/10.
//  Copyright © 2018年 CY. All rights reserved.
//

#import "UITextField+Return.h"

@implementation UITextField (Return)
+ (void)load
{
    SEL originalBec = @selector(becomeFirstResponder);
    SEL swizzledBec = @selector(ix_becomeFirstResponder);
    Class class = self;
    
    Method originalMethod = class_getInstanceMethod(class, originalBec);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledBec);
    BOOL didAddMethod = class_addMethod(class,
                                        originalBec,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        //用swizzledSelector作为originalMethod方法实现的选择器
        class_replaceMethod(class,
                            swizzledBec,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        //调换两个方法的方法实现
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }

}
- (BOOL)ix_becomeFirstResponder
{
    if(self.delegate == nil){
        self.delegate = (id<UITextFieldDelegate>)self;
    }
    return [self ix_becomeFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self resignFirstResponder];
    NSLog(@"键盘 完成");
    return YES;
}

@end
