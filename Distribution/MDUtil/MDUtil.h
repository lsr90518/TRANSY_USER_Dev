//
//  MDUtil.h
//  Distribution
//
//  Created by Lsr on 4/7/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDUtil : NSObject

typedef NS_ENUM (NSUInteger, viewTagNames) {
    paymentSelect = 1000
};


+(MDUtil *)getInstance;

-(NSString *)internationalPhoneNumber:(NSString *)phoneNumber;
-(NSString *)japanesePhoneNumber:(NSString *)phoneNumber;

+(NSString *)getPaymentSelectLabel;

-(BOOL) isIos7;

@end
