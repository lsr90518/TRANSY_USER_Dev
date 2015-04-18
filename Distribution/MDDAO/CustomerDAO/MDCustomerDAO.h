//
//  MDCustomerDAO.h
//  Distribution
//
//  Created by Lsr on 4/12/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDSQLManager.h"
#import "MDCustomer.h"
#import "MDUser.h"

@interface MDCustomerDAO : NSObject


-(void) addCustomer:(MDUser *)customer;
-(MDUser *)findCustomer;
-(void) deleteCustomer;

@end
