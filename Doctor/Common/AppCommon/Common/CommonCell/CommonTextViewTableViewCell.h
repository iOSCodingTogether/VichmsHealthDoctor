//
//  CommonTextViewTableViewCell.h
//  VichmsHealthDoctor
//
//  Created by  licc on 2018/8/31.
//  Copyright © 2018年 AnyOne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTextView.h"
#import "SKTagView.h"
@interface CommonTextViewTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet BaseTextView *TextView;
@property (weak, nonatomic) IBOutlet SKTagView *tagView;

@end
