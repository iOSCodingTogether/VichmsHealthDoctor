//
//  StartCommentTableViewCell.m
//  Doctor
//
//  Created by zt on 2019/1/6.
//  Copyright © 2019年 AnyOne. All rights reserved.
//

#import "StartCommentTableViewCell.h"

@implementation StartCommentTableViewCell

- (void)configWithScore:(NSString *)score comment:(NSString *)comment {
    self.commentLabel.text = comment;
    self.scoreLabel.text = score;
    if ([score isEqualToString:@"暂无评分"]) {
        self.yellowStar.hidden = YES;
    }else {
        self.yellowStar.hidden = NO;
        CGFloat scale = [score floatValue];
        [self.yellowStar layoutIfNeeded];
        CGRect rect = self.yellowStar.frame;
        self.yellowStarWidth.constant = rect.size.width/5.0 * scale;

    }

}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (UIView *)copyView:(UIView *)view{
    NSData * tempArchive = [NSKeyedArchiver archivedDataWithRootObject:view];
    return [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
