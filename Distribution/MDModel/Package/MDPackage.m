//
//  MDPackage.m
//  Distribution
//
//  Created by Lsr on 4/13/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDPackage.h"

@implementation MDPackage

-(MDPackage *)initWithData:(NSDictionary *)data{
    _note =                             ([data[@"note"] isEqual:[NSNull null]]) ? @"" : data[@"note"];
    _order =                            ([data[@"note"] isEqual:[NSNull null]]) ? @"" : data[@"note"];
    _package_number =                   ([data[@"package_number"] isEqual:[NSNull null]]) ? @"" : data[@"package_number"];
    _package_id =                       ([data[@"id"] isEqual:[NSNull null]]) ? @"" : data[@"id"];
    
    NSMutableArray *tmpArray = [[NSMutableArray alloc]initWithObjects:[[NSMutableArray alloc]initWithObjects:@"-1", nil] , nil];
    _at_home_time =                     ([data[@"at_home_time"] isEqual:[NSNull null]]) ? tmpArray : data[@"at_home_time"];
    _deliver_limit =                    ([data[@"deliver_limit"] isEqual:[NSNull null]]) ? @"" : data[@"deliver_limit"];
    _driver_id =                        ([data[@"driver_id"] isEqual:[NSNull null]]) ? @"" : data[@"driver_id"];
    _expire =                           ([data[@"expire"] isEqual:[NSNull null]]) ? @"" : data[@"expire"];
    _from_addr =                        ([data[@"from_addr"] isEqual:[NSNull null]]) ? @"" : data[@"from_addr"];
    _from_lat =                         ([data[@"from_lat"] isEqual:[NSNull null]]) ? @"" : data[@"from_lat"];
    _from_lng =                         ([data[@"from_lng"] isEqual:[NSNull null]]) ? @"" : data[@"from_lng"];
    _from_pref =                        ([data[@"from_pref"] isEqual:[NSNull null]]) ? @"" : data[@"from_pref"];
    _from_zip =                         ([data[@"from_zip"] isEqual:[NSNull null]]) ? @"" : data[@"from_zip"];
    _image =                            ([data[@"image"] isEqual:[NSNull null]]) ? @"" : data[@"image"];
    _review =                           ([data[@"review"] isEqual:[NSNull null]]) ? @"" : data[@"review"];
    _review_limit =                     ([data[@"review_limit"] isEqual:[NSNull null]]) ? @"" : data[@"review_limit"];
    _request_amount =                   ([data[@"request_amount"] isEqual:[NSNull null]]) ? @"" : data[@"request_amount"];
    _reward_amount =                    ([data[@"reward_amount"] isEqual:[NSNull null]]) ? @"" : data[@"reward_amount"];
    _size =                             ([data[@"size"] isEqual:[NSNull null]]) ? @"" : data[@"size"];
    _status =                           ([data[@"status"] isEqual:[NSNull null]]) ? @"" : data[@"status"];
    _to_addr =                          ([data[@"to_addr"] isEqual:[NSNull null]]) ? @"" : data[@"to_addr"];
    _to_lat =                           ([data[@"to_lat"] isEqual:[NSNull null]]) ? @"" : data[@"to_lat"];
    _to_lng =                           ([data[@"to_lng"] isEqual:[NSNull null]]) ? @"" : data[@"to_lng"];
    _to_pref =                          ([data[@"to_pref"] isEqual:[NSNull null]]) ? @"" : data[@"to_pref"];
    _to_zip =                           ([data[@"to_zip"] isEqual:[NSNull null]]) ? @"" : data[@"to_zip"];
    _requestType =                      ([data[@"type"] isEqual:[NSNull null]]) ? @"" : data[@"type"];
    _created_time =                     ([data[@"created"] isEqual:[NSNull null]]) ? @"" : data[@"created"];
    _user_id =                          ([data[@"user_id"] isEqual:[NSNull null]]) ? @"" : data[@"user_id"];
    _distance = @"0";
    
    _driverReview = [[MDReview alloc]init];
    [_driverReview initWithData:data[@"review"][@"from_driver"]];
    
    _userReview = [[MDReview alloc]init];
    [_userReview initWithData:data[@"review"][@"from_user"]];
    
    _user_id = data[@"user_id"];
    
    return self;
}

-(NSComparisonResult) compareByDate: (MDPackage *)otherData{
    MDPackage *tmpPackage = (MDPackage *)self;
    
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [dateFormat setDateFormat:@"YYYY-MM-dd HH:mm:ss"];//设定时间格式,这里可以设置成自己需要的格式
    NSDate *selfDate =[dateFormat dateFromString:tmpPackage.created_time];
    NSDate *givenDate = [dateFormat dateFromString:otherData.created_time];
    
    NSTimeInterval sinterval = [selfDate timeIntervalSinceNow];
    NSTimeInterval ginterval = [givenDate timeIntervalSinceNow];
    
    if(sinterval > ginterval){
        return NSOrderedDescending;
    } else {
        return NSOrderedAscending;
    }
    
}

@end
