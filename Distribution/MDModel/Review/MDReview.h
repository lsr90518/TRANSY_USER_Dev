//
//  MDReview.h
//  Distribution
//
//  Created by Lsr on 5/9/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDReview : NSObject

@property (strong, nonatomic) NSString *user_id;
@property (strong, nonatomic) NSString *user_name;
@property (strong, nonatomic) NSString *star;
@property (strong, nonatomic) NSString *text;

-(void) initWithData:(NSDictionary*)data;

@end
