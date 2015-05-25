//
//  MDRealmNotification.h
//  DistributionDriver
//
//  Created by Lsr on 5/25/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm.h>

@class MDRealmNotificationRecord;

@interface MDRealmNotificationRecord : RLMObject

@property NSString *index;
@property NSString *last_id;

@end

RLM_ARRAY_TYPE(MDRealmNotificationRecord)