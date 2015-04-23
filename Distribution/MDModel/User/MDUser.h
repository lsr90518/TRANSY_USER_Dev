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

@property (nonatomic) NSInteger user_id;
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
//        "id": "1",
//        "phone": "+819081593894",
//        "name": "Masashi Kakami2",
//        "created": "2015-04-03 02:16:37"
//    },
//    "hash": "3J5QRDMLSDDA0c4f9sB7RQ=="
//}

@end
