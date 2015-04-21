//
//  MDUtil.m
//  Distribution
//
//  Created by Lsr on 4/7/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDUtil.h"
#import <Security/Security.h>

@implementation MDUtil

+(MDUtil *)getInstance {
    static MDUtil *sharedInstance;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        sharedInstance = [[MDUtil alloc] init];
    });
    return sharedInstance;
}

-(NSString *)internationalPhoneNumber:(NSString *)phoneNumber {
    if ( ![[phoneNumber substringToIndex:3] isEqualToString:@"+81"] ) {
        NSString *tmpNumber = [NSString stringWithFormat:@"+81%@",[phoneNumber substringFromIndex:1]];
        phoneNumber = tmpNumber;
    }
    
    return phoneNumber;
}

-(NSString *)japanesePhoneNumber:(NSString *)phoneNumber {
    if ( [[phoneNumber substringToIndex:3] isEqualToString:@"+81"] ) {
        NSString *tmpNumber = [NSString stringWithFormat:@"0%@",[phoneNumber substringFromIndex:3]];
        phoneNumber = tmpNumber;
    }
    
    return phoneNumber;
}


@end
