


#import "UITextField+Block.h"
#import <objc/runtime.h>
static char ActionTag;
@implementation UITextField (Block)
- (void)addActiontextFieldChanged:(TextFieldBlock)block{
    
    objc_setAssociatedObject(self, &ActionTag, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
}
- (void)textFieldChanged:(id)sender
{
    TextFieldBlock blockAction = (TextFieldBlock)objc_getAssociatedObject(self, &ActionTag);
    if (blockAction)
    {
        blockAction(self);
    }
}

@end
