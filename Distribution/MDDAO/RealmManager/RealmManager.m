//
//  RealmManager.m
//  Distribution
//
//  Created by Lsr on 5/16/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "RealmManager.h"

@implementation RealmManager

static id shareInstance;

+ (RealmManager *)sharedRealmManager
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
    });
    
    return shareInstance;
}

-(void) initDataFile {
    NSData *realmFile = [[NSFileManager defaultManager] contentsAtPath:[RLMRealm defaultRealmPath]];
    if(realmFile == nil){
//        self.realm = [RLMRealm defaultRealm];
    }
}

-(void) clearData{
    [[NSFileManager defaultManager] removeItemAtPath:[RLMRealm defaultRealmPath] error:nil];
}

@end
