//
//  CommentVC.h
//  Doctor
//
//  Created by zt on 2019/1/6.
//  Copyright © 2019年 AnyOne. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommentVC : BaseViewController

@property (nonatomic,strong) NSDictionary *topDic;//上面view的内容
@property (nonatomic,strong) NSString *orderId;

/**
 yes则是提交评价，NO则是查看评价
 */
@property (nonatomic,assign) BOOL isEdit;

@end

NS_ASSUME_NONNULL_END
