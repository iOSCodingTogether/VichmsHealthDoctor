//
//  PageButtonView.m
//  XiangjianiOS
//
//  Created by  licc on 2018/8/12.
//  Copyright © 2018年 AnyOne. All rights reserved.
//

#import "PageButtonView.h"
#import <Masonry/Masonry.h>
#import "UIColor+CCategory.h"
@interface PageButtonView()
@property (nonatomic, strong) UIView * colorLine;     //

@property (nonatomic, strong) NSArray * titles;     //
@property (nonatomic, strong) NSMutableArray * buttons;     //
@property (nonatomic, strong) UIColor * normalColor;     //
@property (nonatomic, strong) UIColor * selectColor;     //

@end

@implementation PageButtonView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.clipsToBounds = YES;
    return self;
}

-(void)setSubButtons:(NSArray *)titles{
    self.normalColor = LR_NORMALCOLOR;
    self.selectColor = LR_MAINCOLOR;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.titles = titles;
    
    self.buttons =[NSMutableArray array];
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *button =[UIButton new];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [self.buttons addObject:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self).multipliedBy((0.5*2 + i*2) / titles.count );
            make.width.mas_equalTo(self).multipliedBy(1.0/titles.count);
            make.top.bottom.mas_equalTo(self);
        }];
        
    }
    UIView *grayLine =[UIView new];
    grayLine.backgroundColor =[UIColor clearColor];
    [self addSubview:grayLine];
    [grayLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    UIView *colorLine = [UIView new];
    [self addSubview:colorLine];
    colorLine.backgroundColor = LR_MAINCOLOR;
    self.colorLine = colorLine;
    [colorLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(grayLine);
        make.width.mas_equalTo(40);
//        make.centerX.mas_equalTo(0);
    }];
        [self layoutIfNeeded];

    [self scrollToPage:0];

}
-(void)buttonClick:(UIButton *)button{
    [self scrollToPage:button.tag];
    if(self.delegate && [self.delegate respondsToSelector:@selector(pageButtonViewDidselect:)]){
        [self.delegate pageButtonViewDidselect:button.tag];
    }
}
-(void)scrollToPage:(CGFloat)page{
//
//    [self.colorLine mas_updateConstraints:^(MASConstraintMaker *make) {
////        make.left.mas_equalTo(self).multipliedBy((page+0.5)/3.0*200 *2+0.001);
//
//        DLog(@"%.2f",(0.5 + page) / self.titles.count*2 );
//    }];
//
        [self.colorLine mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(1);
            make.width.mas_equalTo(40);
            make.centerX.mas_equalTo(self).multipliedBy(((0.5*2 + page*2) / self.titles.count )?:0.01);
//            make.left.mas_equalTo(self.frame.size.width*page/self.titles.count);
        }];
    
    
    
    NSLog(@"page 0 = %.2f",page);

    page = MAX(MIN(page, self.titles.count - 1), 0);
    NSLog(@"page = %.2f",page);
    NSInteger intPage = (NSInteger)page;
    CGFloat floatPage = page - intPage;

    for(NSInteger i=0; i < self.titles.count ; i++){
        UIButton *button = [self.buttons objectAtIndex:i];
        UIColor *titleColor;
        if(i == intPage){//左边按钮
            titleColor = [UIColor mixColorA:self.selectColor occupyA:(1 -floatPage)*5 withColorB:self.normalColor occupyB:(floatPage)];
        }
        else if (i == intPage + 1){
            titleColor = [UIColor mixColorA:self.selectColor occupyA:(floatPage)*5 withColorB:self.normalColor occupyB:(1 - floatPage)];
        }
        else {
            titleColor = self.normalColor;
        }
        [button layoutIfNeeded];
        [button setTitleColor:titleColor forState:UIControlStateNormal];
    }
    [UIView animateWithDuration:0.1 animations:^{
        [self layoutIfNeeded];
    }];
    
}

@end
