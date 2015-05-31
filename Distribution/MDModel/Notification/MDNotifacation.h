//
//  MDNotifacation.h
//  Distribution
//
//  Created by Lsr on 5/17/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDUtil.h"

@interface MDNotifacation : NSObject

@property (strong, nonatomic) NSString *notification_id;
@property (strong, nonatomic) NSString *package_id;
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) NSString *created_time;

-(void) initDataWithData:(NSDictionary *)data;

-(NSComparisonResult) noticeCompareByDate: (MDNotifacation *)otherData;

@end

//"id": "6",
//"package_id": null,
//"message": "テストテストだよ",
//"created": "2015-05-17 03:25:27"