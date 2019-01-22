//
//  AccompanyRecordVC.m
//  Doctor
//
//  Created by zt on 2019/1/5.
//  Copyright © 2019年 AnyOne. All rights reserved.
//

#import "AccompanyRecordVC.h"
#import "CommonCell0.h"
#import "CollectionTableViewCell.h"
#import "CommonTextViewTableViewCell.h"
#import "OrderCreateRequestModel.h"
#import "BRPickerView.h"
#import "NSDate+CCategory.h"
#import "TZImagePickerController.h"
#import "IMageOrVideoModel.h"
#import <VideoToolbox/VideoToolbox.h>

typedef NS_ENUM(NSUInteger, CELLTYPE) {
    CELLTYPE_DROP,//下拉列表
    CELLTYPE_SELECTSEX,//选择男女
    CELLTYPE_TEXTFIELDSTR,//文本框中文
    CELLTYPE_TEXTFIELDPHONE,//文本框手机号
    CELLTYPE_TEXTFIELDAGE,//文本框年龄
    CELLTYPE_TEXTFIELDIDCARD,//文本框身份证号
    CELLTYPE_TEXTVIEW,//textview
    CELLTYPE_DATA,//选择时间
    CELLTYPE_IMAGE,//选择图片
    CELLTYPE_VEDIO,//选择视频
};

@interface AccompanyRecordVC ()

@property (nonatomic,strong) NSMutableDictionary *orderDic;//接口订单
@property (nonatomic,strong) NSMutableDictionary *nurseDic;//接口护士
//@property (nonatomic, strong) UIView * genderView;     //
//@property (nonatomic, strong) UIButton * maleButton;     //
//@property (nonatomic, strong) UIButton * femaleButton;     //
@property (nonatomic,strong) NSMutableArray *dataArray;//数据源
@property (nonatomic,strong) NSMutableArray *nurseDescArray;//描述数据源
@property (nonatomic,strong) NSMutableArray *nurseDescSelectedArr;//选中的描述数据源
@property (nonatomic,copy) NSString *nurseRecord;//陪诊记录
@property (nonatomic,strong) NSMutableArray *doctorArr;//医生数组

@end
@implementation AccompanyRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.orderDic = [NSMutableDictionary dictionary];
    self.nurseDic = [NSMutableDictionary dictionary];
    self.nurseDescArray = [NSMutableArray array];
    self.nurseDescSelectedArr = [NSMutableArray array];
    self.doctorArr = [NSMutableArray array];
    [self createViews];
    @weakify(self);
    [HYBNetworking getWithUrl:URL_GetNurseDes refreshCache:YES success:^(id response) {
        @strongify(self);
        NSDictionary *dic = response;
        if ([dic[@"code"] isEqual:@100]) {
            [self.nurseDescArray addObjectsFromArray:dic[@"data"]];
        }
        [self request];

        NSLog(@"=====nurseDes:%@",response);
    } fail:^(NSError *error, NSInteger statusCode) {
        @strongify(self);
        [self request];
    }];
}
- (void)request {
    @weakify(self);
    [HYBNetworking getWithUrl:[NSString stringWithFormat:@"%@?orderId=%@",URL_GetOrderNurseByOrserId,self.orderId] refreshCache:YES success:^(id response) {
        @strongify(self);
        NSDictionary *dic = response;
        if ([dic[@"code"] isEqual:@100]) {
            NSDictionary *data = dic[@"data"];
            if ([data isKindOfClass:[NSDictionary class]]) {
                self.orderDic = [NSMutableDictionary dictionaryWithDictionary:data[@"order"]];
                if (![data[@"nurse"] isKindOfClass:[NSNull class]]) {
                    self.nurseDic = [NSMutableDictionary dictionaryWithDictionary:data[@"nurse"]];
                }
            }
            
            [self.mainTableView reloadData];
        }else {
            [MBProgressHUD showAlertWithView:self.view andTitle:@"请求失败"];
        }
    } fail:^(NSError *error, NSInteger statusCode) {
        
        [MBProgressHUD showAlertWithView:self.view andTitle:@"连接服务器失败"];
    }];
}

-(void)createViews{
    
    if (self.navTitle.length <= 0) {
        [self configWithTitle:@"陪诊记录" backImage:nil];
    }else {
        [self configWithTitle:self.navTitle backImage:nil];
    }
    self.naviBGView.backgroundColor = [UIColor whiteColor];
    registerNibWithCellName(self.mainTableView, @"CommonCell0");
    registerNibWithCellName(self.mainTableView, @"CollectionTableViewCell");
    registerNibWithCellName(self.mainTableView, @"CommonTextViewTableViewCell");
    
    self.dataArray = [NSMutableArray arrayWithArray:@[@{@"title":@"患者信息",
                                                        @"data":@[@{@"title":@"类型：",
                                                                    @"type":@(CELLTYPE_DROP),
                                                                    @"value":@"请选择陪诊类型",
                                                                    @"en":@"orderType",
                                                                    @"isEnabled":@NO
                                                                    },
                                                                  @{@"title":@"姓名：",
                                                                    @"type":@(CELLTYPE_TEXTFIELDSTR),
                                                                    @"value":@"请输入姓名",
                                                                    @"en":@"personName",
                                                                    @"isEnabled":@NO
                                                                    },
                                                                  @{@"title":@"性别：",
                                                                    @"type":@(CELLTYPE_SELECTSEX),
                                                                    @"value":@"",
                                                                    @"en":@"personSex",
                                                                    @"isEnabled":@NO
                                                                    },
                                                                  @{@"title":@"年龄：",
                                                                    @"type":@(CELLTYPE_TEXTFIELDAGE),
                                                                    @"value":@"请输入年龄",
                                                                    @"en":@"personAge",
                                                                    @"isEnabled":@NO
                                                                    },
                                                                  @{@"title":@"手机号：",
                                                                    @"type":@(CELLTYPE_TEXTFIELDPHONE),
                                                                    @"value":@"请输入手机号",
                                                                    @"en":@"personPhone",
                                                                    @"isEnabled":@NO
                                                                    },
                                                                  @{@"title":@"身份证号：",
                                                                    @"type":@(CELLTYPE_TEXTFIELDIDCARD),
                                                                    @"value":@"请输入身份证号",
                                                                    @"en":@"personIdCard",
                                                                    @"isEnabled":@NO
                                                                    }]},
                                                      @{@"title":@"病情介绍",
                                                        @"data":@[@{@"title":@"",
                                                                    @"type":@(CELLTYPE_TEXTVIEW),
                                                                    @"value":@"请输入病情介绍",
                                                                    @"en":@"sickDes",
                                                                    @"isEnabled":@NO
                                                                    }]
                                                        },
                                                      @{@"title":@"就诊信息",
                                                        @"data":@[@{@"title":@"就诊时间：",
                                                                    @"type":@(CELLTYPE_DATA),
                                                                    @"value":@"请选择就诊时间",
                                                                    @"en":@"visitTime",
                                                                    @"isEnabled":@(self.visitTime)
                                                                    },
                                                                  @{@"title":@"医生：",
                                                                    @"type":@(CELLTYPE_DROP),
                                                                    @"value":@"请选择医生",
                                                                    @"en":@"doctor",
                                                                    @"isEnabled":@(self.selectDoc)
                                                                    },
                                                                  @{@"title":@"医院：",
                                                                    @"type":@(CELLTYPE_TEXTFIELDSTR),
                                                                    @"value":@"请输入医院",
                                                                    @"en":@"hospital",
                                                                    @"isEnabled":@NO
                                                                    },
                                                                  @{@"title":@"科室：",
                                                                    @"type":@(CELLTYPE_TEXTFIELDSTR),
                                                                    @"value":@"请输入科室",
                                                                    @"en":@"department",
                                                                    @"isEnabled":@NO
                                                                    }]
                                                        },
                                                      @{@"title":@"病例图片",
                                                        @"data":@[@{@"title":@"",
                                                                    @"type":@(CELLTYPE_IMAGE),
                                                                    @"value":@"",
                                                                    @"en":@"sikPic",
                                                                    @"isEnabled":@NO
                                                                    }]
                                                        },
                                                      @{@"title":@"病例视频",
                                                        @"data":@[@{@"title":@"",
                                                                    @"type":@(CELLTYPE_VEDIO),
                                                                    @"value":@"",
                                                                    @"en":@"sickVedio",
                                                                    @"isEnabled":@NO
                                                                    }]
                                                        },
                                                      @{@"title":@"陪诊图片",
                                                        @"data":@[@{@"title":@"",
                                                                    @"type":@(CELLTYPE_IMAGE),
                                                                    @"value":@"",
                                                                    @"en":@"nursePic",
                                                                    @"isEnabled":@YES
                                                                    }]
                                                        },
                                                      @{@"title":@"陪诊记录",
                                                        @"data":@[@{@"title":@"",
                                                                    @"type":@(CELLTYPE_TEXTVIEW),
                                                                    @"value":@"请输入陪诊记录",
                                                                    @"en":@"nurseDes",
                                                                    @"isEnabled":@YES
                                                                    }]
                                                        },
                                                      @{@"title":@"陪诊人信息",
                                                        @"data":@[@{@"title":@"陪诊人：",
                                                                    @"type":@(CELLTYPE_TEXTFIELDSTR),
                                                                    @"value":@"请输入陪诊人姓名",
                                                                    @"en":@"nurseName",
                                                                    @"isEnabled":@YES
                                                                    },
                                                                  @{@"title":@"陪诊日期：",
                                                                    @"type":@(CELLTYPE_DATA),
                                                                    @"value":@"请选择陪诊日期",
                                                                    @"en":@"confirmTime",
                                                                    @"isEnabled":@YES
                                                                    }]
                                                        }]];
    self.mainTableView.estimatedRowHeight = 80;
    
    self.mainTableView.backgroundColor = LR_TABLE_BACKGROUNDCOLOR;
//    self.genderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 60)];
//    UILabel *maleLabel = [UILabel new];
//    [self.genderView addSubview:maleLabel];
//    maleLabel.text = @"男";
//
//    self.maleButton = [UIButton new];
//    [self.genderView addSubview:self.maleButton];
//    [self.maleButton setImage:LRSTRING2IMAGE(@"icon_31") forState:UIControlStateNormal];
//    [self.maleButton setImage:LRSTRING2IMAGE(@"icon_32") forState:UIControlStateSelected];
//
//
//
//    UILabel *femaleLabel = [UILabel new];
//    [self.genderView addSubview:femaleLabel];
//    femaleLabel.text = @"女";
//
//    self.femaleButton = [UIButton new];
//    [self.genderView addSubview:self.femaleButton];
//    [self.femaleButton setImage:LRSTRING2IMAGE(@"icon_31") forState:UIControlStateNormal];
//    [self.femaleButton setImage:LRSTRING2IMAGE(@"icon_32") forState:UIControlStateSelected];
//
//    [maleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(0);
//        make.centerY.mas_equalTo(0);
//    }];
//    [self.maleButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(maleLabel.mas_right).offset(4);
//        make.centerY.mas_equalTo(0);
//        make.width.height.mas_equalTo(62/3.0);
//    }];
//    [femaleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.maleButton.mas_right).offset(12);
//        make.centerY.mas_equalTo(0);
//    }];
//    [self.femaleButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(femaleLabel.mas_right).offset(4);
//        make.centerY.mas_equalTo(0);
//        make.width.height.mas_equalTo(62/3.0);
//    }];
    if (self.isEdit) {
        UIView *bottomView = [self crecteBottomViewContainButtonWithTitle:@"提交" action:@selector(bottomButtonAction:)];
        self.mainTableView.tableFooterView = bottomView;
    }else {
        self.mainTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENW, 10)];
    }
//    self.maleButton.tag =1;
//    self.femaleButton.tag = 0;
//    [self.maleButton addTarget:self action:@selector(userSexSet:) forControlEvents:UIControlEventTouchUpInside];
//    [self.femaleButton addTarget:self action:@selector(userSexSet:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)userSexSet:(UIButton *)btn{
    if(btn.tag == 0){
        //女
        [self.orderDic setObject:@"1" forKey:@"personSex"];
    }
    else{
        //男
        [self.orderDic setObject:@"0" forKey:@"personSex"];
    }
    [self.mainTableView reloadData];
    
}
-(void)bottomButtonAction:(UIButton *)action{
    DLog(@"");
    [self requestPost];
    
}


#pragma mark - UITableViewDelegate UITableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([self.navTitle isEqualToString:@"预约专家"]) {
        return 5;
    }
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSDictionary *dic = self.dataArray[section];
    NSArray *arr = dic[@"data"];
    return arr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    NSDictionary *dic = self.dataArray[indexPath.section];
    NSArray *arr = dic[@"data"];
    NSDictionary *dataDic = arr[indexPath.row];
    NSInteger type = [dataDic[@"type"] integerValue];
    if (type == CELLTYPE_IMAGE || type == CELLTYPE_VEDIO) {
        return UITableViewAutomaticDimension;
    }else if(type == CELLTYPE_TEXTVIEW) {
        return UITableViewAutomaticDimension;
    }
    return 44;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 44)];
    UILabel *label = [UILabel new];
    [view addSubview:label];
    label.textColor = HEXCOLOR(0x919191);
    label.font = [UIFont systemFontOfSize:13];
    NSDictionary *dic = self.dataArray[section];
    label.text = dic[@"title"];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.centerY.mas_equalTo(0);
    }];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LRWeakSelf
    NSDictionary *dic = self.dataArray[indexPath.section];
    NSArray *dataArr = dic[@"data"];
    NSDictionary *dataDic = dataArr[indexPath.row];
    NSInteger type = [dataDic[@"type"] integerValue];
    if(type == CELLTYPE_TEXTFIELDIDCARD ||
       type == CELLTYPE_TEXTFIELDPHONE ||
       type == CELLTYPE_TEXTFIELDAGE ||
       type == CELLTYPE_TEXTFIELDSTR ||
       type == CELLTYPE_DATA ||
       type == CELLTYPE_SELECTSEX ||
       type == CELLTYPE_DROP) {
        CommonCell0 *cell = [tableView dequeueReusableCellWithIdentifier:@"CommonCell0"];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.rightButton.hidden = YES;
//        if(self.genderView.superview == cell){
//            [self.genderView removeFromSuperview];
//        }
        cell.label0.text = dataDic[@"title"];
        cell.textField.placeholder = dataDic[@"value"];
        if (type == CELLTYPE_DROP) {
            cell.textField.userInteractionEnabled = NO;
            if ([dataDic[@"isEnabled"] boolValue]) {
                if (self.isEdit) {
                    cell.textField.enabled = YES;
                }else {
                    cell.textField.enabled = NO;
                }
                if (indexPath.section == 0 && indexPath.row == 0) {
                    cell.textField.text = [NSString stringWithFormat:@"%@",[self.nurseDic objectForKey:dataDic[@"en"]]];
                }else {
                    cell.textField.text = [NSString stringWithFormat:@"%@",[self.orderDic objectForKey:dataDic[@"en"]]];
                }
                [cell.rightButton setImage:[UIImage imageNamed:@"icon_24"] forState:UIControlStateNormal];
                cell.rightButton.hidden = NO;
            }else {
                cell.textField.enabled = NO;
                cell.textField.text = [NSString stringWithFormat:@"%@",[self.orderDic objectForKey:dataDic[@"en"]]];
                cell.rightButton.hidden = YES;
            }
        }else if(type == CELLTYPE_TEXTFIELDAGE || type == CELLTYPE_TEXTFIELDSTR ||
                 type == CELLTYPE_TEXTFIELDPHONE || type == CELLTYPE_TEXTFIELDIDCARD){
            [cell.textField addActiontextFieldChanged:^(UITextField *textField) {
                [self.nurseDic setObject:textField.text forKey:dataDic[@"en"]];
            }];
            cell.textField.enabled = NO;
            if ([dataDic[@"isEnabled"] boolValue]) {
                cell.textField.text = [NSString stringWithFormat:@"%@",[self.nurseDic objectForKey:dataDic[@"en"]]];
            }else {
                cell.textField.text = [NSString stringWithFormat:@"%@",[self.orderDic objectForKey:dataDic[@"en"]]];
            }
//            cell.textField.userInteractionEnabled = YES;
        }else if (type == CELLTYPE_SELECTSEX) {
            cell.textField.placeholder = @"";
            cell.textField.userInteractionEnabled = NO;
//            [cell addSubview:self.genderView];
//            [self.genderView mas_remakeConstraints:^(MASConstraintMaker *make) {
//                make.top.bottom.mas_equalTo(0);
//                make.left.mas_equalTo(cell.label0.mas_right);
//                make.width.mas_equalTo(200);
//            }];
            if ([[self.orderDic objectForKey:dataDic[@"en"]] integerValue] == 0) {
//                self.maleButton.selected = YES;
//                self.femaleButton.selected =NO;
                cell.textField.text = @"男";

            }else {
//                self.maleButton.selected = NO;
//                self.femaleButton.selected =YES;
                cell.textField.text = @"女";
            }

        }else if (type == CELLTYPE_DATA) {
            cell.textField.userInteractionEnabled = NO;
            cell.textField.enabled = NO;
            if ([dataDic[@"isEnabled"] boolValue]) {
                cell.textField.text = [self testDateZone:[NSString stringWithFormat:@"%@",[self.nurseDic objectForKey:dataDic[@"en"]]]];
                [cell.rightButton setImage:[UIImage imageNamed:@"icon_33"] forState:UIControlStateNormal];
                cell.rightButton.hidden = NO;
                if ([dataDic[@"title"] hasPrefix:@"就诊时间"]) {
                    cell.textField.text = [self testDateZone:[NSString stringWithFormat:@"%@",[self.orderDic objectForKey:dataDic[@"en"]]]];
                }
            }else {
                cell.textField.text = [self testDateZone:[NSString stringWithFormat:@"%@",[self.orderDic objectForKey:dataDic[@"en"]]]];
                cell.rightButton.hidden = YES;
            }
        }
        return cell;
        
    }
    else if(type == CELLTYPE_TEXTVIEW){
        CommonTextViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommonTextViewTableViewCell"];
        cell.TextView.placeholder = dataDic[@"value"];
        [cell.tagView removeAllTags];
        cell.tagView.interitemSpacing = 10;
        cell.tagView.regularHeight = 20;
//        cell.tagView.lineSpacing = 5;
        if ([dataDic[@"isEnabled"] boolValue]) {
            if (self.isEdit) {
                cell.TextView.editable = YES;
            }else {
                cell.TextView.editable = NO;
            }
            if (self.nurseRecord.length > 0) {
                cell.TextView.text = self.nurseRecord;
            }else {
                cell.TextView.text = [NSString stringWithFormat:@"%@",[self.nurseDic objectForKey:dataDic[@"en"]]];
            }
            for (NSDictionary *subDic in self.nurseDescArray) {
                if ([subDic isKindOfClass:[NSDictionary class]]) {
                    NSString *subTag = [NSString stringWithFormat:@"%@",subDic[@"typeName"]];
                    SKTag *tag1 = [SKTag tagWithText:subTag];
                    tag1.enable = self.isEdit;
                    if ([self.nurseDescSelectedArr containsObject:subDic]) {
                        //选中的标签
                        tag1.bgColor = HEXCOLOR(0x00A3FE);
                        tag1.borderWidth = 0;
                        tag1.textColor = [UIColor whiteColor];
                    }else {
                        tag1.bgColor = [UIColor whiteColor];
                        tag1.borderWidth = 1;
                        tag1.textColor = HEXCOLOR(0x919191);
                    }
                    tag1.padding = UIEdgeInsetsMake(8, 10, 8, 10);
                    tag1.cornerRadius = 10;
                    tag1.borderColor = [HEXCOLOR(0x919191) colorWithAlphaComponent:0.8];
                    [cell.tagView addTag:tag1];
                    @weakify(self);
                    cell.tagView.didTapTagAtIndex = ^(NSUInteger index) {
                        @strongify(self);
                        if ([self.nurseDescSelectedArr containsObject:self.nurseDescArray[index]]) {
                            [self.nurseDescSelectedArr removeObject:self.nurseDescArray[index]];
                        }else {
                            [self.nurseDescSelectedArr addObject:self.nurseDescArray[index]];
                        }
                        [self.mainTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                    };
                }
            }
            
            @weakify(self);
            [cell.TextView.rac_textSignal subscribeNext:^(id x) {
                
                @strongify(self);
                self.nurseRecord = x;
                
            }];
        }else {
            cell.TextView.editable = NO;
            cell.TextView.text = [NSString stringWithFormat:@"%@",[self.orderDic objectForKey:dataDic[@"en"]]];
        }


        //MARK:待处理
        return cell;
    }
    else if(type == CELLTYPE_IMAGE){
        CollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CollectionTableViewCell"];
        cell.accessoryType = UITableViewCellAccessoryNone;
        if([dic[@"title"] isEqualToString:@"陪诊记录"]) {
            if ([[self.nurseDic objectForKey:dic[@"en"]] isKindOfClass:[NSArray class]]) {
                cell.imagesArr = [self.nurseDic objectForKey:dic[@"en"]];
            }else {
                cell.imagesArr = [NSArray array];
            }
        }else {
            if ([[self.orderDic objectForKey:dic[@"en"]] isKindOfClass:[NSArray class]]) {
                cell.imagesArr = [self.orderDic objectForKey:dic[@"en"]];
            }else {
                cell.imagesArr = [NSArray array];
            }
        }
        if ([dataDic[@"isEnabled"] boolValue] && self.isEdit) {
            [cell setDidSelect:^(NSInteger selectIndex) {
                NSArray *arr = [self.nurseDic objectForKey:dic[@"en"]];
                if(selectIndex == arr.count){//addImage
                    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] init];
                    imagePickerVc.maxImagesCount = 1;
                    imagePickerVc.allowPickingOriginalPhoto = YES;
                    imagePickerVc.allowPickingVideo = NO;
                    imagePickerVc.allowPickingImage = YES;
                    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
                        [self upLoadImageWithPhotos:photos assets:assets isSelectOriginalPhoto:YES withKey:dic[@"title"]];
                    }];
                    [self presentViewController:imagePickerVc animated:YES completion:nil];
                }
                else{
                    //
                }
            }];
            [cell setDidDelect:^(NSInteger deleteIndex) {
                NSMutableArray *arr = [NSMutableArray arrayWithArray:[self.nurseDic objectForKey:dic[@"en"]]];
                if(arr.count > deleteIndex){
                    [arr removeObjectAtIndex:deleteIndex];
                    [self.nurseDic setObject:arr forKey:dic[@"en"]];
                }
            }];
        }else {
            
        }
        
        return cell;
    }
    else if(type == CELLTYPE_VEDIO){
        CollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CollectionTableViewCell"];
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        if ([[self.orderDic objectForKey:dic[@"en"]] isKindOfClass:[NSArray class]]) {
            cell.imagesArr = [self.orderDic objectForKey:dic[@"en"]];
        }else {
            cell.imagesArr = [NSArray array];
        }
        
//        [cell setDidSelect:^(NSInteger selectIndex) {
//            NSArray *arr = [self.valueDic objectForKey:dic[@"title"]];
//            if(selectIndex == arr.count){//addImage
//                TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] init];
//                imagePickerVc.maxImagesCount = 1;
//                imagePickerVc.allowPickingVideo = YES;
//                imagePickerVc.allowPickingImage = NO;
//                [imagePickerVc setDidFinishPickingVideoHandle:^(UIImage *coverImage, PHAsset *asset) {
//                    NSMutableArray *arr = [NSMutableArray arrayWithArray:[self.valueDic objectForKey:dic[@"title"]]];
//                    if(selectIndex == arr.count){//addVideo
//                        [self upLoadVideoWithCoverImage:coverImage asset:asset withKey:dic[@"title"]];
//                    }
//                    else{
//                        //
//                    }
//
//                }];
//                [self presentViewController:imagePickerVc animated:YES completion:nil];
//            }else {
//
//            }
//
//        }];
//        [cell setDidDelect:^(NSInteger deleteIndex) {
//            NSMutableArray *arr = [NSMutableArray arrayWithArray:[self.valueDic objectForKey:dic[@"title"]]];
//            if(arr.count > deleteIndex){
//                [arr removeObjectAtIndex:deleteIndex];
//                [self.valueDic setObject:arr forKey:dic[@"title"]];
//                [self reloadData];
//            }
//        }];
        return cell;
    }
    
    
    return nil;
    
}

-(void)upLoadImageWithPhotos:(NSArray<UIImage *> *)photos assets:(NSArray *)assets isSelectOriginalPhoto:(BOOL )isSelectOriginalPhoto withKey:(NSString *)key{
    if(photos.count == 0){
        NSLog(@"select 0 image");
        return ;
    }
    NSMutableArray *mutArr = [NSMutableArray arrayWithArray:[self.orderDic objectForKey:key]];
//    IMageOrVideoModel *imgModel = [[IMageOrVideoModel alloc]init];
//    imgModel.image = photos[0];
//    imgModel.imageOther = assets[0];
//    imgModel.imageURLKey = key;
//    [mutArr addObject:imgModel];
//    [self.valueDic setObject:[NSArray arrayWithArray:mutArr] forKey:key];
    [mutArr addObjectsFromArray:photos];
    [self.nurseDic setObject:mutArr forKey:key];
//    NSArray *imageArr = [NSArray array];
//    if ([[self.valueDic objectForKey:key] isKindOfClass:[NSArray class]]) {
//        imageArr = [self.valueDic objectForKey:key];
//    }
//    NSMutableArray *arr = [NSMutableArray arrayWithArray:imageArr];
//
//    [CommonManage QNPutimage:photos[0] forView:LR_KEY_WINDOW key:nil res:^(BOOL success, NSString * _Nonnull key, NSString * _Nonnull imageURL) {
//        if(success){
//            IMageOrVideoModel *imgModel = [[IMageOrVideoModel alloc]init];
//            imgModel.image = photos[0];
//            imgModel.imageOther = assets[0];
//            imgModel.imageURLKey = key;
//            [self.imagesModelArr addObject:imgModel];
//            [self reloadData];
//        }
//        else{
//            LR_TOAST(@"上传失败");
//        }
//    } progressHandler:^(NSString *key, float percent) {
//
//    }];
}

-(void)upLoadVideoWithCoverImage:(UIImage *)coverImage asset:(PHAsset *)asset withKey:(NSString *)key{
    [[TZImageManager manager] getVideoWithAsset:asset completion:^(AVPlayerItem *playerItem, NSDictionary *info) {
        AVURLAsset *urlAsset = (AVURLAsset *)playerItem.asset;
        
        NSURL *url = urlAsset.URL;
        //        NSData *data = [NSData dataWithContentsOfURL:url];
        //        NSLog(@"视频大小 %lu",(unsigned long)data.length);
        AVAssetExportSession *exportSession= [[AVAssetExportSession alloc] initWithAsset:urlAsset presetName:AVAssetExportPreset640x480];
        exportSession.shouldOptimizeForNetworkUse = YES;
        NSString*  _outPath = [NSString stringWithFormat:@"%@/bb", NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0]];
        BOOL isSuccess = [ [NSFileManager defaultManager] removeItemAtPath:_outPath error:nil];
        
        
        exportSession.outputURL = [NSURL fileURLWithPath:_outPath];
        exportSession.outputFileType = AVFileTypeMPEG4;
        __block MBProgressHUD *waithud;
        dispatch_async(dispatch_get_main_queue(), ^{
            waithud = [MBProgressHUD showHUDAddedTo:LR_KEY_WINDOW animated:YES];
            waithud.label.text = @"视频处理中";
        });
        
        [exportSession exportAsynchronouslyWithCompletionHandler:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [waithud hideAnimated:YES];
            });
            int exportStatus = exportSession.status;
            NSLog(@"%d",exportStatus);
            switch (exportStatus)
            {
                case AVAssetExportSessionStatusFailed:
                {
                    // log error to text view
                    NSError *exportError = exportSession.error;
                    NSLog (@"AVAssetExportSessionStatusFailed: %@", exportError);
                    break;
                }
                case AVAssetExportSessionStatusCompleted:
                {
                    NSLog(@"视频转码成功");
                    NSData *data2 = [NSData dataWithContentsOfFile:_outPath];
                    NSLog(@"视频大小2 %lu",(unsigned long)data2.length);
                    NSMutableArray *mutArr = [NSMutableArray arrayWithArray:[self.nurseDic objectForKey:key]];
                    IMageOrVideoModel *imgModel = [[IMageOrVideoModel alloc]init];
                    imgModel.image = coverImage;
                    imgModel.imageOther = data2;
                    imgModel.imageURLKey = key;
                    [mutArr addObject:imgModel];
                    [self.nurseDic setObject:[NSArray arrayWithArray:mutArr] forKey:key];
                    dispatch_async(dispatch_get_main_queue(), ^{
                    });

//                    [CommonManage QNPutimage:data2 forView:LR_KEY_WINDOW key:nil res:^(BOOL success, NSString * _Nonnull key, NSString * _Nonnull imageURL) {
//                        if(success){
//                            NSLog(@"video key is %@",key);
//                            IMageOrVideoModel *imgModel = [[IMageOrVideoModel alloc]init];
//                            imgModel.image = coverImage;
//                            imgModel.imageOther = data2;
//                            imgModel.imageURLKey = key;
//                            [self.videosModelArr addObject:imgModel];
//                            [self reloadData];
//                        }
//                        else{
//                            LR_TOAST(@"上传失败");
//                        }
//
//                    } progressHandler:nil];
               
                    
                    
                }
            }
            
            
        }];
    }];
    
    //            if (asset.mediaType == PHAssetMediaTypeVideo) {
    //                PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
    //                options.version = PHImageRequestOptionsVersionCurrent;
    //                options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
    //
    //                PHImageManager *manager = [PHImageManager defaultManager];
    //                [manager requestAVAssetForVideo:asset options:options resultHandler:^(AVAsset * _Nullable avasset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
    //                    AVURLAsset *urlAsset = (AVURLAsset *)avasset;
    //
    //                    NSURL *url = urlAsset.URL;
    //                    NSData *data = [NSData dataWithContentsOfURL:url];
    //
    //                    NSLog(@"%@",data);
    //                }];
    //            }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    @weakify(self);
    NSDictionary *dic = self.dataArray[indexPath.section];
    NSArray *dataArr = dic[@"data"];
    NSDictionary *dataDic = dataArr[indexPath.row];
    NSInteger type = [dataDic[@"type"] integerValue];

    if (self.selectDoc) {
        //如果是医生可选择
        if ([dataDic[@"title"] isEqualToString:@"医生："]) {
            //选择医生
            @weakify(self);
            [HYBNetworking getWithUrl:URL_Doctors refreshCache:YES success:^(id response) {
                @strongify(self);
                NSLog(@"====我的医生%@",response);
                NSDictionary *dic = response;
                if ([dic[@"code"] isEqual:@100]) {
                    NSArray *arr = dic[@"data"];
                    
                    self.doctorArr = [NSMutableArray arrayWithArray:arr];
                    NSMutableArray *doctorNameArr = [NSMutableArray array];
                    for (NSDictionary *subDic in self.doctorArr) {
                        NSString *doctorName = [NSString stringWithFormat:@"%@",subDic[@"name"]];
                        [doctorNameArr addObject:doctorName];
                    }
                    [BRStringPickerView showStringPickerWithTitle:@"请选择医生" dataSource:doctorNameArr defaultSelValue:doctorNameArr[0] isAutoSelect:NO resultBlock:^(id selectValue) {
                        NSLog(@"%@",selectValue);
                        for (NSDictionary *subDic in self.doctorArr) {
                            if ([subDic[@"name"] isEqualToString:selectValue]) {
                                self.orderDic[@"doctor"] = subDic[@"name"];
                                self.orderDic[@"department"] = subDic[@"department"];
                                break;
                            }
                        }
                        [self.mainTableView reloadData];
                        
                    }];

                }else {
                    [MBProgressHUD showAlertWithView:self.view andTitle:@"请求失败"];
                }
                
            } fail:^(NSError *error, NSInteger statusCode) {
                if (statusCode == 401) {
                    //token失效，重新登录
                    [UIApplication sharedApplication].delegate.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[LoginVC new]];
                    [[UserInfoManager shareInstance] logoutUser];
                    
                    [[[NIMSDK sharedSDK] loginManager] logout:^(NSError * _Nullable error) {
                        if (error) {
                            NSLog(@"退出登录失败");
                            return;
                        }
                    }];
                }else {
                    [MBProgressHUD showAlertWithView:self.view andTitle:@"连接服务器失败"];
                }
                
            }];
        }
    }
    if (self.visitTime) {
        if ([dataDic[@"title"] hasPrefix:@"就诊时间"]) {
            NSString *str = dataDic[@"value"];
            if (str.length == 0) {
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                str = [dateFormatter stringFromDate:[NSDate date]];
            }
            [BRDatePickerView showDatePickerWithTitle:dataDic[@"title"] dateType:UIDatePickerModeDateAndTime defaultSelValue:str minDateStr:@"" maxDateStr:@"" isAutoSelect:NO resultBlock:^(NSString *selectValue,NSDate *date) {
                @strongify(self);
                if(date){
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                    //                [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
                    NSString *destDateString = [dateFormatter stringFromDate:date];
                    [self.orderDic setObject:destDateString forKey:dataDic[@"en"]];
                    [self.mainTableView reloadData];
                }
            }];
        }
    }


    
}
-(void)requestPost{
    
    if ([self.navTitle isEqualToString:@"预约专家"]) {
        @weakify(self);
        
        [HYBNetworking postWithUrl:URL_AppointDoctor body:self.orderDic success:^(id response) {
            NSDictionary *dic = response;
            if ([dic[@"code"] isEqual:@100]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    @strongify(self);
                    [MBProgressHUD showAlertWithView:self.view andTitle:[NSString stringWithFormat:@"%@",dic[@"msg"]]];
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }else {
                [MBProgressHUD showAlertWithView:self.view andTitle:@"请求失败"];
            }
        } fail:^(NSError *error, NSInteger statusCode) {
            
            [MBProgressHUD showAlertWithView:self.view andTitle:@"连接服务器失败"];
        }];
           
        return;
    }
    NSMutableString *nurseDes = [NSMutableString string];
    if (self.nurseDescSelectedArr.count > 0) {
        for (NSInteger i=0;i<self.nurseDescSelectedArr.count;i++) {
            NSDictionary *subDic = self.nurseDescSelectedArr[i];
            NSString *typeName = subDic[@"typeName"];
            if (i == self.nurseDescSelectedArr.count - 1) {
                [nurseDes appendString:typeName];
            }else {
                [nurseDes appendFormat:@"%@,",typeName];
            }
        }
    }else {
        nurseDes = [NSMutableString stringWithString:@""];
    }
    NSString *paramId = [NSString stringWithFormat:@"%@",self.nurseDic[@"id"]];
    NSString *nurseRecord = self.nurseRecord;
    NSString *nursePic = @"";
    @weakify(self);
    [HYBNetworking getWithUrl:URL_NurseUpdata refreshCache:YES params:@{@"id":paramId,@"nurseDes":nurseDes,@"nurseRecord":nurseRecord,@"nursePic":nursePic} success:^(id response) {
        
        NSDictionary *dic = response;
        if ([dic[@"code"] isEqual:@100]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                @strongify(self);
                [MBProgressHUD showAlertWithView:self.view andTitle:[NSString stringWithFormat:@"%@",dic[@"msg"]]];
                [self.navigationController popViewControllerAnimated:YES];
            });
        }else {
            [MBProgressHUD showAlertWithView:self.view andTitle:@"请求失败"];
        }
    } fail:^(NSError *error, NSInteger statusCode) {
        
        [MBProgressHUD showAlertWithView:self.view andTitle:@"连接服务器失败"];
    }];
//    if(!self.orderCreateModel){
//        return;
//    }
//    if(self.imagesModelArr.count >0){
//        NSArray *keys = [self.imagesModelArr valueForKeyPath:@"imageURLKey"];
//        NSString *str = [keys componentsJoinedByString:@","];
//        self.orderCreateModel.sickPic =str;
//    }
//    if(self.videosModelArr.count >0){
//        NSArray *keys = [self.videosModelArr valueForKeyPath:@"imageURLKey"];
//        NSString *str = [keys componentsJoinedByString:@","];
//        self.orderCreateModel.sickVedio =str;
//    }
//    [BaseRequest requestWithRequestModel:self.orderCreateModel ret:^(BOOL success, __kindof BaseResultModel *dataModel, NSString *jsonObjc) {
//        NSLog(@"jsonObjc");
//    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(UIView *)crecteBottomViewContainButtonWithTitle:(NSString *)title action:(SEL)action{
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    UIButton *button = [[UIButton alloc]init];
    [bottomView addSubview:button];
    LR_BUTTON_STYLE(button);
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(44);
    }];
    return bottomView;
}


-(NSString *)testDateZone:(NSString *)timeDate
{
    if ([timeDate isKindOfClass:[NSNull class]]) {
        return @"";
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    NSDate *localDate = [dateFormatter dateFromString:timeDate];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDate = [dateFormatter stringFromDate:[self getNowDateFromatAnDate:localDate]];
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    return strDate;
}

- (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate
{
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone systemTimeZone];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate];
    return destinationDateNow;
}

@end
