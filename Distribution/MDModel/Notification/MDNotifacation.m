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
    _package_id = ([data[@"_package_id"] isEqual:[NSNull null]]) ? @"" : data[@"_package_id"];
    _message = ([data[@"_message"] isEqual:[NSNull null]]) ? @"" : data[@"_message"];
    _created_time = ([data[@"created"] isEqual:[NSNull null]]) ? @"" : data[@"created"];
}

@end


//"id": "6",
//"package_id": null,
//"message": "テストテストだよ",
//"created": "2015-05-17 03:25:27"