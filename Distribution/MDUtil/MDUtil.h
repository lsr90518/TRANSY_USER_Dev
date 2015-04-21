//
//  MDUtil.h
//  Distribution
//
//  Created by Lsr on 4/7/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDUtil : NSObject

+(MDUtil *)getInstance;

-(NSString *)internationalPhoneNumber:(NSString *)phoneNumber;
-(NSString *)japanesePhoneNumber:(NSString *)phoneNumber;

-(BOOL) isIos7;

@end
