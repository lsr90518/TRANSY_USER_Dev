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
    _user_id = ([data[@"user_id"] isEqual:[NSNull null]]) ? @"" : data[@"user_id"];
    _user_name = ([data[@"user_name"] isEqual:[NSNull null]]) ? @"" : data[@"user_name"];
    _name = ([data[@"name"] isEqual:[NSNull null]]) ? @"" : data[@"name"];
    _star = ([data[@"star"] isEqual:[NSNull null]]) ? @"" : data[@"star"];
    _text = ([data[@"text"] isEqual:[NSNull null]]) ? @"" : data[@"text"];
    _reviewed = ([data[@"reviewed"] isEqual:[NSNull null]]) ? @"" : data[@"reviewed"];
    
}

@end
