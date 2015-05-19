
//
//  MDNotificationService.m
//  Distribution
//
//  Created by Lsr on 5/17/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDNotificationService.h"

@implementation MDNotificationService

static MDNotificationService *sharedInstance;

+(MDNotificationService *)getInstance {
    
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        sharedInstance = [[MDNotificationService alloc] init];
    });
    return sharedInstance;
}

-(void) initWithDataArray:(NSArray *)dataArray{
    if (_notificationList == nil) {
        _notificationList = [[NSMutableArray alloc]init];
    }
    [_notificationList removeAllObjects];
    
    [dataArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        //
        MDNotifacation *tmpNotification = [[MDNotifacation alloc]init];
        [tmpNotification initDataWithData:obj];
        [_notificationList addObject:tmpNotification];
    }];
}

@end
