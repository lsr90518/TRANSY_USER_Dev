//
//  MDRealmNotice.h
//  DistributionDriver
//
//  Created by Lsr on 5/28/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Realm.h>

@class MDRealmPushNotice;

@interface MDRealmPushNotice : RLMObject

@property NSString *notification_id;
@property NSString *package_id;
@property NSString *message;
@property NSString *created_time;

@end

RLM_ARRAY_TYPE(MDRealmPushNotice)