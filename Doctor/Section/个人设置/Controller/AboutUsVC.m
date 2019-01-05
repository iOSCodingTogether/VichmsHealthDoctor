
//
//  AboutUsVC.m
//  Doctor
//
//  Created by zt on 2019/1/4.
//  Copyright © 2019年 AnyOne. All rights reserved.
//

#import "AboutUsVC.h"

@interface AboutUsVC ()
@property (nonatomic, strong) UILabel * topLabel;     //
@property (nonatomic, strong) UILabel * detailLabel;     //

@end

@implementation AboutUsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configWithTitle:@"关于我们" backImage:@""];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createViews];
    [self reloadData];

}
-(void)createViews{
    UILabel *topLabel = [UILabel new];
    [self.view addSubview:topLabel];
    topLabel.font = [UIFont systemFontOfSize:16];
    self.topLabel = topLabel;
    
    UILabel *detailLabel = [UILabel new];
    [self.view addSubview:detailLabel];
    detailLabel.font = [UIFont systemFontOfSize:14];
    detailLabel.numberOfLines = 0;
    self.detailLabel = detailLabel;
    
    
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(kNavigationBarHeight+20);
    }];
    
    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(topLabel.mas_bottom).offset(40);
    }];
    
    
    
    
}
-(void)reloadData{
    self.topLabel.text =@"北京胜利祥健科技服务有限公司";
    self.detailLabel.text =@"北京胜利祥健科技服务有限公司是一家私营企业，注册资金520万元人民币，由创始人田春来带领下，经过不懈努力于2013年10月29日成立，目前员工人数208人，拥有大学学历人才42人。经营范围：医学研究；承办展览展示；会议服务；组织文化艺术交流；货物进出口、技术进出口、代理进出口；租赁汽车（不含九座以上客车）；健康管理、健康咨询(须经审批的诊疗活动除外）；销售化妆品；零售化工产品（不含危险化学品）、仪器仪表、机械设备、消防器材、计算机软件及辅助设备、工艺品；物业管理。（企业依法自主选择经营...，主要面向中小企业及个人提供医学研究；承办展览展示；会议服务；组织文化艺术交流；货物进出口、技术进出口、代理进出口；租赁汽车（不含九座以上客车）；健康管理、健康咨询(须经审批的诊疗活动除外）；销售化妆品；零售化工产品（不含危险化学品）、仪器仪表、机械设备、消防器材、计算机软件及辅助设备、工艺品；物业管理。（企业依法自主选择经营...，经过多年专业水平和成熟技术积累，年营业额达到28912万元。北京胜利祥健科技服务有限公司本着“客户第一,诚信至上”的原则,以实力和质量获得业界的高度认可。欢迎各界朋友莅临参观、指导和业务洽谈。您如果对我们感兴趣的话，可以直接联系我们或者留下联系方式。\n\
    北京胜利祥健科技服务有限公司以诚信、实力和产品质量获得业界的高度认可。欢迎各界朋友莅临参观、指导和业务洽谈。";
    
    
}
@end
