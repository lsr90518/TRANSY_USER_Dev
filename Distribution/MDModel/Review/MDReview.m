//
//  MDReview.m
//  Distribution
//
//  Created by Lsr on 5/9/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDReview.h"

@implementation MDReview

-(void) initWithData:(NSDictionary*)data{
    _user_id = data[@"user_id"];
    _user_name = data[@"user_name"];
    _star = data[@"star"];
    _text = data[@"text"];
}

@end
