//
//  MDLocalNotificationManager.h
//  Distribution
//
//  Created by 各務 将士 on 2015/05/19.
//  Copyright (c) 2015年 Lsr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MDAPI.h"
#import "MDPackageService.h"
#import "MDUtil.h"

@interface MDLocalNotificationManager : NSObject
// ローカル通知を登録する
- (void)scheduleLocalNotifications;
@end
