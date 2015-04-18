//
//  MDCurrentPackage.h
//  Distribution
//
//  Created by Lsr on 4/13/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDCurrentPackage : NSObject

@property (strong, nonatomic) NSString *package_id;
@property (strong, nonatomic) NSString *user_d;
@property (strong, nonatomic) NSString *from_addr;
@property (strong, nonatomic) NSString *from_lat;
@property (strong, nonatomic) NSString *from_lng;
@property (strong, nonatomic) NSString *from_zip;
@property (strong, nonatomic) NSString *to_addr;
@property (strong, nonatomic) NSString *to_lat;
@property (strong, nonatomic) NSString *to_lng;
@property (strong, nonatomic) NSString *to_zip;
@property (strong, nonatomic) NSString *size;
@property (strong, nonatomic) NSString *request_amount;
@property (strong, nonatomic) NSString *deliver_limit;
@property (strong, nonatomic) NSString *expire;
@property (strong, nonatomic) NSString *note;
@property (strong, nonatomic) NSMutableArray *at_home_time; //預かり時刻
@property (strong, nonatomic) NSString *image;
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSString *driver_id;
@property (strong, nonatomic) NSString *package_number;
@property (strong, nonatomic) NSString *review;
@property (strong, nonatomic) NSString *review_limit;
@property (strong, nonatomic) NSString *requestType;

+(MDCurrentPackage *)getInstance;

-(void) initData;

@end
