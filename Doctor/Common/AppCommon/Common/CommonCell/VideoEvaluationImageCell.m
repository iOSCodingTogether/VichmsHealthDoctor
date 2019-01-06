//
//  VideoEvaluationImageCell.m
//  XiangjianiOS
//
//  Created by  licc on 2018/8/11.
//  Copyright © 2018年 AnyOne. All rights reserved.
//

#import "VideoEvaluationImageCell.h"


@implementation VideoEvaluationImageCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.imageView = [UIImageView new];
    [self addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    self.playImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"playBtn"]];
    [self addSubview:self.playImage];
    self.playImage.hidden = YES;
    [self.playImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    return self;
    
}
-(UIButton *)deleteBtn{
    if(!_deleteBtn){
        _deleteBtn = [UIButton new];
        [self addSubview:_deleteBtn];
        [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.mas_equalTo(0);
            make.width.height.mas_equalTo(30);
        }];
    }
    return _deleteBtn;
}
@end
