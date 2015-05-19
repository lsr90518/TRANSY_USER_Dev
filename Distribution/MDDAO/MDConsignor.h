//
//  MDConsignor.h
//  Distribution
//
//  Created by Lsr on 5/16/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "RLMObject.h"
#import <Realm.h>

@class MDConsignor;

@interface MDConsignor : RLMObject

@property NSString  *userid;
@property NSString  *phonenumber;
@property NSString  *password;


@end

RLM_ARRAY_TYPE(MDConsignor)