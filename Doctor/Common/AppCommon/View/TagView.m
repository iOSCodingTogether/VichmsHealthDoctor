//
//  TagView.m
//  CeshiDemo
//
//   Created by  licc on 2018/11/29.
//  Copyright © 2018年 CH. All rights reserved.
//

#import "TagView.h"
#define PYSEARCH_MARGIN 10 //标签间隔

@implementation TagView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setTags:(NSArray *)tags{
    _tags = tags;
    NSArray *tagTexts = tags;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];


    NSMutableArray *tagsM = [NSMutableArray array];
    for (int i = 0; i < tagTexts.count; i++) {
        UILabel *label = [self labelWithTitle:tagTexts[i]];
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagDidCLick:)]];
        [self addSubview:label];
        [tagsM addObject:label];
        label.tag = i;
    }
    [self mylayoutSubview];
}

-(void)mylayoutSubview{
    CGFloat width = self.frame.size.width;
    if(width ==0){
        width = 100;
    }
    CGFloat currentX = 0;
    CGFloat currentY = 0;
    CGFloat countRow = 0;
    CGFloat countCol = 0;
    
    for (int i = 0; i < self.subviews.count; i++) {
        UILabel *subView = self.subviews[i];
        // When the number of search words is too large, the width is width of the self
        [subView sizeToFit];
        
        CGRect subframe =subView.frame;
        subframe.size.width+=20;
        subframe.size.height+=14;
        
        if (subframe.size.width > self.frame.size.width){
            subframe.size.width = width;
        }
        if (currentX + subframe.size.width + PYSEARCH_MARGIN * countRow > width) {
            subframe.origin.x = 0;
            subframe.origin.y = (currentY += subframe.size.height) + PYSEARCH_MARGIN * ++countCol;
            currentX = subframe.size.width;
            countRow = 1;
        } else {
            subframe.origin.x = (currentX += subframe.size.width) - subframe.size.width + PYSEARCH_MARGIN * countRow;
            subframe.origin.y  = currentY + PYSEARCH_MARGIN * countCol;
            countRow ++;
        }
        _fitHeight = subframe.origin.y + subframe.size.height;
        subView.frame = subframe;
    }
}
-(CGFloat)fitHeight{
    if(_fitHeight==0){
        return 0.01;
    }
    return _fitHeight;
}
-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self mylayoutSubview];
}
-(void)sizeToFit{
    [super sizeToFit];
    CGRect frame = self.frame;
    frame.size.height = self.fitHeight;
    [self setFrame:frame];
}
- (UILabel *)labelWithTitle:(NSString *)title
{
    UILabel *label = [[UILabel alloc] init];
    label.userInteractionEnabled = YES;
    label.font = [UIFont systemFontOfSize:14];
    label.text = title;
    label.textColor = [UIColor grayColor];
    label.backgroundColor = [UIColor colorWithWhite:0xfa/255.0 alpha:1];
    label.layer.cornerRadius = 3;
    label.clipsToBounds = YES;
    label.textAlignment = NSTextAlignmentCenter;
    [label sizeToFit];

    CGRect  rect = label.frame;
    rect.size.width+=20;
    rect.size.height+=14;

    label.frame = rect;
    return label;
}
-(void)selectIndex:(NSInteger)index{
    NSInteger tempTeg = self.tag;
    self.tag = -999;
    UILabel *label = [self viewWithTag:index];
    if([label isKindOfClass:[UILabel class]]){
        if(label.tag != index){
            label.textColor = [UIColor grayColor];
            label.backgroundColor = [UIColor colorWithWhite:0xfa/255.0 alpha:1];
        }
        else{
            label.textColor = [UIColor blackColor];
            label.backgroundColor = [UIColor colorWithWhite:0xf0/255.0 alpha:1];
            
        }
    }
    self.tag = tempTeg;
}
- (void)tagDidCLick:(UITapGestureRecognizer *)gr
{
    UILabel *label = (UILabel *)gr.view;
    if(self.didClickBack){
        self.didClickBack(label.tag, label.text);
    }
    
}

-(UILabel *)viewWithIndex:(NSInteger)index{
    
    UILabel *lab = [self viewWithTag:index];
    if([lab isKindOfClass:[UILabel class]]){
        return lab;
    }
    return nil;
}
@end
