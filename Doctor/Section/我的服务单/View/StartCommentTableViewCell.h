//
//  StartCommentTableViewCell.h
//  Doctor
//
//  Created by zt on 2019/1/6.
//  Copyright © 2019年 AnyOne. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StartCommentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *yellowStar;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *yellowStarWidth;

- (void)configWithScore:(NSString *)score comment:(NSString *)comment;
@end

NS_ASSUME_NONNULL_END
