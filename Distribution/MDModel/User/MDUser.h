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
@property (strong, nonatomic) NSString *mailAddress;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *lastname;
@property (strong, nonatomic) NSString *firstname;
@property (strong, nonatomic) NSString *checknumber;
@property (strong, nonatomic) NSString *userHash;
@property (strong, nonatomic) NSString *loginStatus;
@property (nonatomic) NSInteger credit;

+(MDUser *)getInstance;

-(void) initDataClear;

-(void) setLogin;
-(void) setLogout;
-(BOOL) isLogin;

//{
//    "code": 0,
//    "data": {
//        "id": "2",
//        "phone": "+819081593894",
//        "name": "Masashi Kakami",
//        "mail": "mkakami@modelor.com",    // 無ければnull
//        "credit": "0",
//        "created": "2015-04-04 04:44:36"
//    },
//    "hash": "QsyWWh4wNpFCwZAqLEdKcg=="
//}

@end
