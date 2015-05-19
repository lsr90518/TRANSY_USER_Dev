//
//  RealmManager.h
//  Distribution
//
//  Created by Lsr on 5/16/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "RLMObject.h"
#import <Realm.h>

@interface RealmManager : RLMObject

//@property (strong , nonatomic) RLMRealm *realm;

+(RealmManager *) sharedRealmManager;

@end
