//
//  MDDriver.h
//  Distribution
//
//  Created by Lsr on 5/9/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDDriver : NSObject

@property (strong, nonatomic) NSString      *driver_id;
@property (strong, nonatomic) NSString      *name;
@property (strong, nonatomic) NSString      *phoneNumber;
@property (strong, nonatomic) NSString      *image;
@property (strong, nonatomic) NSString      *intro;
@property (strong, nonatomic) NSString      *delivered_package;
@property (strong, nonatomic) NSString      *average_star;
@property (strong, nonatomic) NSMutableArray *reviews;


-(void) initWithData:(NSDictionary*)data;

@end
