//
//  MDCustomer.h
//  Distribution
//
//  Created by Lsr on 4/12/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface MDCustomer : NSManagedObject

@property (nonatomic, retain) NSString * phonenumber;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * creditnumber;
@property (nonatomic, retain) NSString * lastname;
@property (nonatomic, retain) NSString * firstname;

@end
