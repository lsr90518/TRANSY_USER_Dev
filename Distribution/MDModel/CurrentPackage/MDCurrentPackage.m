//
//  MDCurrentPackage.m
//  Distribution
//
//  Created by Lsr on 4/13/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDCurrentPackage.h"
#import "MDUtil.h"

@implementation MDCurrentPackage

+(MDCurrentPackage *)getInstance {
    
    static MDCurrentPackage *sharedInstance;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        sharedInstance = [[MDCurrentPackage alloc] init];
    });
    return sharedInstance;
}

-(void) initData {
    self.requestType = @"0";
    self.size = (self.size.length > 0) ? self.size : @"120";
    self.note = (self.note.length > 0) ? self.note : @"特になし";
    
    NSDate *now = [NSDate date];
    
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
//    NSMutableArray *defaultTime = [NSMutableArray arrayWithObjects:@"-1",@"-1",@"-1", nil];
//    self.at_home_time = [[NSMutableArray alloc]initWithCapacity:10];
//    [self.at_home_time addObject:defaultTime];
    
    
    //預かり時刻
    if(self.at_home_time == nil){
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"YYYY-MM-dd"];
        NSMutableArray *defaultTime = [NSMutableArray arrayWithObjects:[dateFormatter stringFromDate:now],@"-1",@"-1", nil];
        
        self.at_home_time = [[NSMutableArray alloc]initWithCapacity:10];
        [self.at_home_time addObject:defaultTime];
    }
//    //届け時刻
    if(self.deliver_limit == nil) {
        //4時間後
        NSDate *fiveHoursAfter = [now dateByAddingTimeInterval:72*60*60];
        NSCalendar *gregorianCalendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateFormatter *tmpFormatter = [[NSDateFormatter alloc]init];
        [tmpFormatter setCalendar:gregorianCalendar];
        [tmpFormatter setLocale:[NSLocale systemLocale]];
        [tmpFormatter setDateFormat:@"YYYY-MM-dd HH:mm:00"];
        self.deliver_limit = [tmpFormatter stringFromDate:fiveHoursAfter];
    }
//
    //期限
    if(self.expire == nil) {
        //24時間後
        NSDate *threeHoursAfter = [now dateByAddingTimeInterval:24*60*60];
        NSCalendar *gregorianCalendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateFormatter *tmpFormatter = [[NSDateFormatter alloc]init];
        [tmpFormatter setCalendar:gregorianCalendar];
        [tmpFormatter setLocale:[NSLocale systemLocale]];
        [tmpFormatter setDateFormat:@"YYYY-MM-dd HH:mm:00"];
        self.expire = [tmpFormatter stringFromDate:threeHoursAfter];
        
    }
    
    
    self.request_amount = (self.request_amount.length > 0) ? self.request_amount : @"1400";
    
    self.expire = (self.expire.length > 0) ? self.expire : @"24";
    
    //lat lng
    if(self.to_lng.length < 1){
        self.to_lng = @"";
    }
    if(self.to_lat.length < 1){
        self.to_lat = @"";
    }
    if(self.from_lat.length < 1){
        self.from_lat = @"";
    }
    if(self.from_lng.length < 1){
        self.from_lng = @"";
    }
}

-(BOOL) isAllInput{
    BOOL returnFlag = YES;
    
    if(self.from_pref.length < 1){
        returnFlag = NO;
    }
    if(self.from_addr.length < 1){
        returnFlag = NO;
    }

    if(self.from_lat.length < 1){
        returnFlag = NO;
    }

    if(self.from_lng.length < 1){
        returnFlag = NO;
    }

    if(self.from_zip.length < 1){
        returnFlag = NO;
    }

    if(self.to_pref.length < 1){
        returnFlag = NO;
    }

    if(self.to_addr.length < 1){
        returnFlag = NO;
    }

    if(self.to_lat.length < 1){
        returnFlag = NO;
    }

    if(self.to_lng.length < 1){
        returnFlag = NO;
    }

    if(self.to_zip.length < 1){
        returnFlag = NO;
    }

    if(self.size.length < 1){
        returnFlag = NO;
    }

    if(self.request_amount.length < 1){
        returnFlag = NO;
    }

    if(self.deliver_limit.length < 1){
        returnFlag = NO;
    }

    if(self.expire.length < 1){
        returnFlag = NO;
    }

    if(self.note.length < 1){
        returnFlag = NO;
    }

    if([self.at_home_time count] < 1){
        returnFlag = NO;
    }
    
    return returnFlag;
}

@end
