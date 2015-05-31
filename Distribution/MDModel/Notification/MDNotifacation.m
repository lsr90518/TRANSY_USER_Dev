//
//  MDNotifacation.m
//  Distribution
//
//  Created by Lsr on 5/17/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDNotifacation.h"

@implementation MDNotifacation

-(void) initDataWithData:(NSDictionary *)data{
    _notification_id = ([data[@"id"] isEqual:[NSNull null]]) ? @"" : data[@"id"];
    _package_id = ([data[@"_package_id"] isEqual:[NSNull null]]) ? @"" : data[@"package_id"];
    _message = ([data[@"_message"] isEqual:[NSNull null]]) ? @"" : data[@"message"];
    _created_time = ([data[@"created"] isEqual:[NSNull null]]) ? @"" : [MDUtil getLocalDateTimeStrFromString:data[@"created"] format:@"yyyy年MM月dd日 HH:mm:ss"];;
}

-(NSComparisonResult) noticeCompareByDate: (MDNotifacation *)otherData{
    MDNotifacation *tmpNotification = (MDNotifacation *)self;
    
    
    //排序
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
    NSDate *date1 = [dateFormat dateFromString:tmpNotification.created_time];
    NSDate *date2 = [dateFormat dateFromString:otherData.created_time];
    
    NSTimeInterval time1 = [date1 timeIntervalSince1970];
    NSTimeInterval time2 = [date2 timeIntervalSince1970];
    
    
    if (time1 > time2) {
        return NSOrderedAscending;
    } else {
        return NSOrderedDescending;
    }
    
}

@end


//"id": "6",
//"package_id": null,
//"message": "テストテストだよ",
//"created": "2015-05-17 03:25:27"