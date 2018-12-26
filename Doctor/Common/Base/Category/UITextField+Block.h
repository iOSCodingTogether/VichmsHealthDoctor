


#import <UIKit/UIKit.h>

@interface UITextField (Block)
typedef void(^TextFieldBlock)(UITextField* textField);

- (void)addActiontextFieldChanged:(TextFieldBlock)block;

@end
