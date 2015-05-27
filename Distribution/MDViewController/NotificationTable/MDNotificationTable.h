//
//  MDNotificationTable.h
//  Distribution
//
//  Created by 劉 松然 on 2015/05/20.
//  Copyright (c) 2015年 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDPackage.h"
#import "MDPackageService.h"
#import <MJRefresh.h>

@interface MDNotificationTable : UITableViewController

@property (strong, nonatomic) NSMutableArray *notificationList;

@end
