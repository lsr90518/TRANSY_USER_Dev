//
//  MDDevice.m
//  Distribution
//
//  Created by Lsr on 4/20/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDDevice.h"

@implementation MDDevice

+(MDDevice *)getInstance {
    
    static MDDevice *sharedInstance;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        sharedInstance = [[MDDevice alloc] init];
    });
    return sharedInstance;
}

@end
