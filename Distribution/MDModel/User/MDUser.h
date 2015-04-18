//
//  MDUser.h
//  Distribution
//
//  Created by Lsr on 4/12/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface MDUser : NSObject

@property (strong, nonatomic) NSString *phoneNumber;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *creditNumber;
@property (strong, nonatomic) NSString *lastname;
@property (strong, nonatomic) NSString *firstname;
@property (strong, nonatomic) NSString *checknumber;
@property (strong, nonatomic) NSString *userHash;
@property (strong, nonatomic) NSString *image;
@property (strong, nonatomic) NSString *status;

+(MDUser *)getInstance;

-(void) initDataClear;

//{
//    "code": 0,
//    "data": {
//        "id": "11",
//        "phone": "+819081593894",
//        "name": "各務 将士",
//        "walk": "1",
//        "bike": "1",
//        "motorbike": "0",
//        "car": "1",
//        "image": "https://distribution-dev.s3-ap-northeast-1.amazonaws.com/driver/images/11",
//        "status": "0",
//        "created": "2015-04-02 02:30:34"
//    },
//    "hash": "eYIFmpw/pe+QKp50MnkgGA=="
//}

@end
