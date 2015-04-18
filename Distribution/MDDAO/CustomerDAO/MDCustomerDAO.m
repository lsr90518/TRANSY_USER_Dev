//
//  MDCustomerDAO.m
//  Distribution
//
//  Created by Lsr on 4/12/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDCustomerDAO.h"

@implementation MDCustomerDAO

-(void) addCustomer :(MDUser *)customer {
    
    MDSQLManager *sqlManager = [MDSQLManager sharedSQLManager];
    [sqlManager initCoreData];
    MDCustomer *newcustomer = (MDCustomer *)[NSEntityDescription insertNewObjectForEntityForName:@"MDCustomer" inManagedObjectContext:sqlManager.managedObjectContext];
    
//    newcustomer = customer;
    [newcustomer setPhonenumber:customer.phoneNumber];
    [newcustomer setPassword:customer.password];
    [newcustomer setCreditnumber:customer.creditNumber];
    [newcustomer setLastname:customer.lastname];
    [newcustomer setFirstname:customer.firstname];
    
    NSError *error = nil;
    if (![sqlManager.managedObjectContext save:&error]) {
        // Handle the error.
        NSLog(@"Save Event failed.");
        return ;
    } else {
        NSLog(@"save ok");
    }
}

-(MDUser *) findCustomer {
    MDUser *returnCustomer = [[MDUser alloc]init];
    MDSQLManager *sqlManager = [MDSQLManager sharedSQLManager];
    [sqlManager initCoreData];
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"MDCustomer" inManagedObjectContext:sqlManager.managedObjectContext];
    
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [sqlManager.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    for (NSManagedObject *customer in fetchedObjects) {
        returnCustomer.phoneNumber = [NSString stringWithFormat:@"%@",[customer valueForKey:@"phonenumber"]];
        returnCustomer.password = [NSString stringWithFormat:@"%@",[customer valueForKey:@"password"]];
        returnCustomer.creditNumber = [NSString stringWithFormat:@"%@",[customer valueForKey:@"creditnumber"]];
        returnCustomer.lastname = [NSString stringWithFormat:@"%@",[customer valueForKey:@"lastname"]];
        returnCustomer.firstname = [NSString stringWithFormat:@"%@",[customer valueForKey:@"firstname"]];
    }
    
    return returnCustomer;
}

-(void) deleteCustomer {
    MDSQLManager *sqlManager = [MDSQLManager sharedSQLManager];
    [sqlManager initCoreData];
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"MDCustomer" inManagedObjectContext:sqlManager.managedObjectContext];
    
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [sqlManager.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    for (NSManagedObject *customer in fetchedObjects) {
        //        NSLog(@"phonenumber:%@", [customer valueForKey:@"phonenumber"]);
        [sqlManager.managedObjectContext deleteObject:customer];
    }
    
    // Commit the change.
    if (![sqlManager.managedObjectContext save:&error]) {
        // Handle the error.
    }
}

@end
