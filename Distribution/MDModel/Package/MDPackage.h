//
//  MDPackage.h
//  Distribution
//
//  Created by Lsr on 4/13/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDPackage : NSObject

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
@property (strong, nonatomic) NSString *reward_amount;
@property (strong, nonatomic) NSString *deliver_limit;
@property (strong, nonatomic) NSString *expire;
@property (strong, nonatomic) NSString *note;
@property (strong, nonatomic) NSMutableArray *at_home_time;
@property (strong, nonatomic) NSString *image;
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSString *driver_id;
@property (strong, nonatomic) NSString *package_number;
@property (strong, nonatomic) NSString *review;
@property (strong, nonatomic) NSString *review_limit;
@property (strong, nonatomic) NSString *requestType;



//{
//    "id": "3",
//    "user_id": "2",
//    "from_addr": "京都リサーチパーク",
//    "from_lat": "0",
//    "from_lng": "0",
//    "to_addr": "京都駅",
//    "to_lat": "0",
//    "to_lng": "0",
//    "size": "0",
//    "request_amount": "1400",
//    "reward_amount": "1260",
//    "deliver_limit": null,
//    "expire": "2015-04-04 07:50:41",
//    "note": "壊れ物なので丁寧にお願いします。",
//    "at_home_time": [
//                     [
//                      9,
//                      12
//                      ],
//                     [
//                      18,
//                      21
//                      ]
//                     ],
//    "image": null,
//    "status": "-1",
//    "driver_id": null,
//    "package_number": 1420123946,
//    "review": null,
//    "review_limit": null
//}

@end
