//
//  SQLManager.m
//  Distribution
//
//  Created by Lsr on 4/12/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDSQLManager.h"

@implementation MDSQLManager

+ (MDSQLManager *)sharedSQLManager
{
    static dispatch_once_t onceToken;
    static id shareInstance;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
    });
    
    return shareInstance;
}

- (void)initCoreData
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = [paths objectAtIndex:0];
    NSURL *storeUrl = [NSURL fileURLWithPath:[basePath stringByAppendingPathComponent:@"DistributonDB.sqlite"]];

    _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];

    NSError *error;
    // option use for lightweight migration
    NSDictionary * option = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                             [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_managedObjectModel];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:option error:&error]) {
        NSLog(@"%@: %@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"], error.localizedDescription);
    }
    

    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    _managedObjectContext.persistentStoreCoordinator = _persistentStoreCoordinator;
    
}

@end
