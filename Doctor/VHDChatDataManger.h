//
//  VHDChatDataManger.h
//  Doctor
//
//  Created by zt on 2019/1/25.
//  Copyright © 2019 AnyOne. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <NIMSDK/NIMSDK.h>
#import <NIMKit.h>

@interface VHDChatDataManger : NSObject <NIMKitDataProvider>

+ (instancetype)sharedInstance;

@end
