//
//  UserInfoModel.h
//  Doctor
//
//  Created by zt on 2019/1/5.
//  Copyright © 2019 AnyOne. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 user信息
 */
@interface UserInfoModel : NSObject
//"token": "4vkDJeIQ_gOyYzZ_XfcB4BX8SjDtaBbUcXbG9PBg_5ELZNUcdRavd9U0_JpJIad-",
//"accid": "297ea9bb65add4b30165ae334a80001e",
//"uuidhh": "100004888",
//"tokenhh": "91141BE3A4F4946FAC1D1FC608D7BBA63F0D04F68EA2608F6783B874E4F50EEF",
//"tokenyx": "d668698f6bf9d5c76dc5601268760526",
//"name": "姜涛",
//"vip": "",
//"headPic": "http://www.erpside.com/38926cffc1e17160b_1540783656935.jpg",
//"memberLevel": "",
//"age": "",
//"phone": "13856444885",
//"oldPhone": "",
//"personType": "4",
//"accountMoney": 0,
//"sumMoney": 0,
//"orgName": "",
//"orgId": "",
//"openVideoDoctor": "",
//"activeVideoDoctor": "",
//"openDate": null,
//"validDate": null,
//"registerTime": null,
//"doctorId": "297ea9bb65add4b30165ae334a58001d",
//"password": "",
//"idCard": ""

@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *accid;
@property (nonatomic, copy) NSString *uuidhh;
@property (nonatomic, copy) NSString *tokenyx;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *vip;
@property (nonatomic, copy) NSString *headPic;
@property (nonatomic, copy) NSString *memberLevel;
@property (nonatomic, copy) NSString *age;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *oldPhone;
@property (nonatomic, copy) NSString *personType;
@property (nonatomic, copy) NSString *accountMoney;
@property (nonatomic, copy) NSString *sumMoney;
@property (nonatomic, copy) NSString *orgName;
@property (nonatomic, copy) NSString *orgId;
@property (nonatomic, copy) NSString *openVideoDoctor;
@property (nonatomic, copy) NSString *activeVideoDoctor;
@property (nonatomic, copy) NSString *openDate;
@property (nonatomic, copy) NSString *validDate;
@property (nonatomic, copy) NSString *registerTime;
@property (nonatomic, copy) NSString *doctorId;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *idCard;

@end
