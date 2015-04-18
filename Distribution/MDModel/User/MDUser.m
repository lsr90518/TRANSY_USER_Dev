//
//  MDUser.m
//  Distribution
//
//  Created by Lsr on 4/12/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDUser.h"

@implementation MDUser

+(MDUser *)getInstance {
    
    static MDUser *sharedInstance;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        sharedInstance = [[MDUser alloc] init];
    });
    return sharedInstance;
}

-(void) initDataClear {
    if(_phoneNumber.length < 1){
       _phoneNumber = @"";
    }
    if(_password.length < 1){
        _password = @"";
    }
    if(_creditNumber.length < 1){
        _creditNumber = @"";
    }
    if(_lastname.length < 1){
        _lastname = @"";
    }
    if(_firstname.length < 1){
        _firstname = @"";
    }
    if(_checknumber.length < 1){
        _checknumber = @"";
    }
}

@end
